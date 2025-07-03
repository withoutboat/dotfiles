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

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    core,
    home,
    nvf,
    ...
  }: let
    host = import ./hosts/mac-cero/variables.nix;
  in {
    nixosConfigurations.mac-cero = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inputs = {inherit nvf;};
        inherit host;
        pryme = "withoutboat";
      };

      modules = [
        ./hosts/mac-cero
        core.nixosModules.default
        home.nixosModules.default
        ./profiles/intel
      ];
      #  ++ builtins.attrValues (home.homeConfigurations host);
    };
  };
}
