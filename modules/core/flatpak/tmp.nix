{pkgs}: {
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    configPackages = [pkgs.hyprland];
  };

  services.flatpak.enable = true;

  nix-flatpak.packages = [
    "flathub:app/org.mozilla.firefox/x86_64/stable"
  ];
}
