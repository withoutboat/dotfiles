{
  description = "withoutboatOss";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    core = {
      url = "path:./modules/core";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-cero = {
      url = "path:./hosts/mac-cero";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    mac-cero,
    core,
    home-manager,
    nvf,
    ...
  }: {
    nixosConfigurations.mac-cero = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        host = mac-cero.config;
        inputs = {inherit nixpkgs mac-cero core home-manager nvf;};
        username = "withoutboat";
        profile = "mac-cero";
      };

      modules = [
        mac-cero.nixosModules.default
        core.nixosModules.default
        ./profiles/intel
      ];
    };
  };
}
