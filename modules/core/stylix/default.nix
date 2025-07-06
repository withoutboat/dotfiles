{
  pkgs,
  host,
config,
  ...
}:  {
  # Styling Options
  stylix = {
  enable = true;

 # theme = "catppuccin-frappe";
 # base16Scheme = {
 #   src = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
 # };

  base16Scheme = {
    base00 = "303446"; # base
    base01 = "292c3c"; # mantle
    base02 = "414559"; # surface0
    base03 = "51576d"; # surface1
    base04 = "626880"; # surface2
    base05 = "c6d0f5"; # text
    base06 = "f2d5cf"; # rosewater
    base07 = "babbf1"; # lavender
    base08 = "e78284"; # red
    base09 = "ef9f76"; # peach
    base0A = "e5c890"; # yellow
    base0B = "a6d189"; # green
    base0C = "81c8be"; # teal
    base0D = "8caaee"; # blue
    base0E = "ca9ee6"; # mauve
    base0F = "eebebe"; # flamingokj:w

    };

  image = host.stylixImage;

  polarity = "dark";

  opacity.terminal = 1.0;

  cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  fonts = {
    monospace = {
      package = pkgs.nerd-fonts.blex-mono;
      name = "BlexMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.nerd-fonts.blex-mono;
      name = "BlexMono Nerd Font";
    };
    serif = {
      package = pkgs.nerd-fonts.blex-mono;
      name = "BlexMono Nerd Font";
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
    sizes = {
      applications = 12;
      terminal = 15;
      desktop = 11;
      popups = 12;
    };
  };
};
}
