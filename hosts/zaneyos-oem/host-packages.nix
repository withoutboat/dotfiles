{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nodejs
    atop
    bottom
    dua
    fd
    gping
    lunarvim
    luarocks
    mc
    mission-center
    resources
    ncdu
    gdu
    ugrep
    waypaper
    dysk
  ];
}
