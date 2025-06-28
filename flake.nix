{
  description = "withoutboatOss";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
  };

  outputs = {
    nixpkgs,
    nix-flatpak,
    ...
  } @ inputs: let
    host = "mac-cero";
    username = "withoutboat";
  in {
    nixosConfigurations = {
      mac-cero = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit host;
          profile = "mac-cero";
        };
        modules = [
          ./hosts/mac-cero
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };
  };
}
