{
  description = "Home-manager flake module for multi-user setup";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {home-manager, ...}: {
    homeManagerModule = {
      system,
      users,
      username,
      host,
    }: {
      imports = [home-manager.nixosModules.home-manager];

      home-manager = {
        sharedModules = [
          # sops-nix.homeManagerModules.sops
        ];
        useUserPackages = true;
        useGlobalPkgs = false;
        backupFileExtension = "backup";
        extraSpecialArgs = {inherit username host;};
        users = builtins.listToAttrs (
          map (user: {
            inherit (user) name;
            value = {
              imports = [./default.nix];
              home = {
                username = user.name;
                homeDirectory =
                  if system == "aarch64-darwin" || system == "x86_64-darwin"
                  then "/Users/${user.name}"
                  else "/home/${user.name}";
                stateVersion = "23.11";
              };
            };
          })
          users
        );
      };
    };
  };
}
