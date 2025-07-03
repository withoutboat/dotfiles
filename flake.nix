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
    mac-cero,
    core,
    home,
    nvf,
    ...
  }: {
    nixosConfigurations.mac-cero = nixpkgs.lib.nixosSystem {
      inherit (mac-cero) system;

      specialArgs = {
        host = mac-cero.config;
        inputs = {inherit nixpkgs mac-cero core nvf;};
      };

      modules = [
        mac-cero.nixosModules.default
        core.nixosModules.default
        home.homeManagerModule
        {
          inherit (mac-cero.config) users;
          inherit (mac-cero) system;
          inherit (mac-cero.config) username;
        }
        ./profiles/intel
      ];
    };
  };
}
