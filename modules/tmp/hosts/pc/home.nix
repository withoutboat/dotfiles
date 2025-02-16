{
  imports = [
    ../../configs
    ../../configs/hyprland
    ../../configs/theme.nix
  ];

  home = {
    username = "mark";
    homeDirectory = "/home/mark";
  };

  home.packages = [
  ];

  home.file = {
  };

  programs.firefox.enable = true;

  monitors = [
    {
      name = "eDP-1";
      width = 3840;
      height = 2160;
      scale = 0.5;
      refreshRate = 144;
    }
  ];
}
