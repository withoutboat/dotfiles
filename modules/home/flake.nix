{
  description = "home module flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {home-manager, ...}: {
    nixosModules.default = home-manager.nixosModules.home-manager;
    homeManagerModules.default = import ./default.nix;
  };
}
