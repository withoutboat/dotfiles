{
  description = "Home-manager flake module for multi-user setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11";
    home-manager.url = "github:nix-community/home-manager";
    # Add more inputs here if needed
  };

  outputs = {home-manager, ...}: {
    homeManagerModule = {
      system,
      users,
    }: {...}: {
      imports = [home-manager.nixosModules.home-manager];
      home-manager = {
        sharedModules = [
          # sops-nix.homeManagerModules.sops
        ];
        useUserPackages = true;
        useGlobalPkgs = false;
        backupFileExtension = "backup";
        #  extraSpecialArgs = {inherit inputs;};
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
