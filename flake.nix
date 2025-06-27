{
  description = "withoutboatOss";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nvf.url = "github:notashelf/nvf";
    stylix.url = "github:danth/stylix/release-25.05";
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
