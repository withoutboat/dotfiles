{
  description = "home module flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    home-manager,
    nvf,
    ...
  }: {
    nixosModules.default = {
      host,
      pryme,
      ...
    }: {
      imports = [
        home-manager.nixosModules.home-manager
        nvf.homeManagerModules.default
      ];

      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = false;
        backupFileExtension = "backup";

        extraSpecialArgs = {
          inherit pryme;
          inherit host;
        };

        users = builtins.listToAttrs (
          map (user: {
            name = user;
            value = {
              imports = [./default.nix];
              home = {
                username = user;
                homeDirectory = "/home/${user}";
                stateVersion = host.homeStateVersion or "23.11";
              };
            };
          })
          host.users
        );
      };
    };
  };
}
