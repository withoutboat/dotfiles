{
  description = "Flatpak config module flake";

  inputs = {
    nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
  };

  outputs = {nix-flatpak, ...}: {
    nixosModules.default = {pkgs}: {
      imports = [nix-flatpak.nixosModules.nix-flatpak];

      xdg.portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-hyprland];
        configPackages = [pkgs.hyprland];
      };

      services.flatpak.enable = true;

      nix-flatpak.packages = [
        "flathub:app/org.mozilla.firefox/x86_64/stable"
      ];
    };

    # expose nix-flatpak if you want to re-use it elsewhere
    # inherit nix-flatpak;
  };
}
