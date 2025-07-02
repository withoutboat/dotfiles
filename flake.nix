{
  description = "withoutboatOss";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Define core at the root level
    core = {
      url = "path:./modules/core";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Mac-cero as a module source
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
    # Define the system in the root flake only
    nixosConfigurations.mac-cero = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inputs = {inherit nixpkgs mac-cero core home-manager nvf;};
        username = "withoutboat";
        host = "mac-cero";
        profile = "mac-cero";
      };

      modules = [
        # Core modules
        mac-cero.nixosModules.default
        core.nixosModules.default

        # Import mac-cero modules

        # Intel profile
        ./profiles/intel
      ];
    };
  };
}
