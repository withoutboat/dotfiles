{
  description = "home module flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: {
    homeManagerModules.default = import ./default.nix;

    homeConfigurations = host:
      builtins.listToAttrs (
        map (user: {
          name = "${user}@${host.name}";
          value = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {inherit (host) system;};
            modules =
              (
                if !(host.system == "aarch64-darwin" || host.system == "x86_64-darwin")
                then [home-manager.nixosModules.home-manager]
                else []
              )
              ++ [self.homeManagerModules.default];
            extraSpecialArgs = {
              inherit host;
            };
          };
        })
        host.users
      );
  };
}
