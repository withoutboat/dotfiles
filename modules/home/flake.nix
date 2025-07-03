{
  description = "home module flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {home-manager, ...}: {
    homeManagerModule = home-manager.nixosModules.home-manager;
  };
}
