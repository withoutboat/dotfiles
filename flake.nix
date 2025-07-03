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
      inputs.nixpkgs.follows = "nixpkgs";
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
  }: {
    nixosConfigurations.mac-cero = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inputs = {inherit nixpkgs core nvf;};
      };

      modules = [
        ./hosts/mac-cero/flake.nix
        core.nixosModules.default
        home.homeManagerModule
        ./profiles/intel
      ];
    };
  };
}
