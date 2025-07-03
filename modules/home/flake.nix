{
  description = "home module flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {home-manager, ...}: {
    homeManagerModules.default = import ./default.nix;
    homeManagerModule = {
      host,
      system,
      ...
    }: {
      imports = [home-manager.nixosModules.home-manager];
      home-manager = {
        extraSpecialArgs = {inherit host system;};
      };
    };
  };
}
