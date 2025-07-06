{
  description = "withoutboatOss";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    core = {
      url = "path:./modules/core";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home = {
      url = "path:./modules/home";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {
    nixpkgs,
    core,
    home,
    ...
  }: let
    host = import ./hosts/mac-cero/variables.nix;
  in {
    nixosConfigurations.mac-cero = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        pryme = "withoutboat";
        inherit host;
      };

      modules = [
        ./hosts/mac-cero
        home.nixosModules.default
        core.nixosModules.default
        ./profiles/intel
      ];
    };
  };
}
