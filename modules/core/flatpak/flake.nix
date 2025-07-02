{
  description = "Flatpak config module flake";

  inputs = {
    nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
  };

  outputs = {nix-flatpak, ...}: {
    nixosModules.default = {
      imports = [nix-flatpak.nixosModules.nix-flatpak ./tmp.nix];
    };

    # expose nix-flatpak if you want to re-use it elsewhere
    # inherit nix-flatpak;
  };
}
