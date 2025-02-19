{pkgs, ...}: {
  imports = [
    ./kitty.nix
    ./mako.nix
    ./swaylock.nix
    ./waybar
    ./wofi.nix
  ];

  home = {
    packages = with pkgs; [
      grim
      imv
      mimeo
      waypipe
      slurp
      xfce.thunar
      wf-recorder
      wl-clipboard
      wl-mirror
      ydotool
    ];

    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_QPA_PLATFORM = "wayland";
      LIBSEAT_BACKEND = "logind";
    };
  };
}
