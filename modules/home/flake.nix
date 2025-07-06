{
  description = "home module flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

      nvim.url = "github:withoutboat/nvim-flake";
  };

  outputs = {
    home-manager,
    nvf,
    nvim,
    ...
  }: {
    nixosModules.default = {
      host,
      pryme,
      ...
    }: {
      imports = [
        home-manager.nixosModules.home-manager
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
              imports = [
                ./default.nix
               # nvf.homeManagerModules.default
                nvim.homeManagerModules.default
              ];
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
