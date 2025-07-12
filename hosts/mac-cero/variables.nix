{
  users = ["withoutboat"];
  name = "mac-cero";

  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "Vladimr Markov";
  gitEmail = "withoutboat@gmail.com";

  wifiSsid = "TP-Link_53A8";
  wifiKey = "prot";

  # Set Displau Manager
  # `tui` for Text login
  # `sddm` for graphical GUI
  # SDDM background is set with stylixImage
  displayManager = "sddm";

  # Emable/disable bundled applications
  tmuxEnable = false;
  alacrittyEnable = false;
  weztermEnable = false;
  ghosttyEnable = true;
  vscodeEnable = false;

  # P10K or starship prompt (not enabled yet)
  userPrompt = "starship";

  # Hyprland Settings
  # ex: extraMonitorSettings = "monitor = Virtual-1,1920x1080@60,auto,1";
  # ex: extraMonitorSettings = "monitor = HDMI-A-1,1920x1080@60,auto,1";
  # You can configure multiple monitors. Create a new line for each one.
  extraMonitorSettings = "

    ";

  # Waybar Settings
  clock24h = true;

  # Program Options
  # Set Default Browser (google-chrome-stable for google-chrome)
  browser = "brave";

  # Available Options:
  # Kitty, ghostty, wezterm
  terminal = "ghostty"; # Set Default System Terminal

  keyboardLayout = "us";
  consoleKeyMap = "us";

  # Enable NFS
  enableNFS = true;

  # Enable Printing Support
  printEnable = false;

  # Enable Thunar GUI File Manager
  # Yazi is default File Manager
  thunarEnable = true;

  # Themes, waybar and animation.
  #  Only uncomment your selection
  # The others much be commented out.

  # Set Stylix Image
  # This will set your color palette
  # Default background
  # Add new images to ~/zaneyos/wallpapers
  # stylixImage = ../../wallpapers/mountainscapedark.jpg;
  stylixImage = ../../wallpapers/AnimeGirlNightSky.jpg;
  #stylixImage = ../../wallpapers/Anime-Purple-eyes.png;
  #stylixImage = ../../wallpapers/Rainnight.jpg;
  #stylixImage = ../../wallpapers/zaney-wallpaper.jpg;
  #stylixImage = ../../wallpapers/nix-wallpapers-strips-logo.jpg;
  #stylixImage = ../../wallpapers/beautifulmountainscape.jpg;

  # Set Waybar
  #  Available Options:
  #waybarChoice = ../../modules/home/waybar/waybar-curved.nix;
  #waybarChoice = ../../modules/home/waybar/waybar-ddubs.nix;
  #waybarChoice = ../../modules/home/waybar/waybar-ddubs-2.nix;
  #waybarChoice = ../../modules/home/waybar/waybar-simple.nix;
  #waybarChoice = ../../modules/home/waybar/Jerry-waybar.nix;
  #waybarChoice = ../../modules/home/waybar/waybar-nekodyke.nix;

  # Set Animation style
  # Available options are:
  # animations-def.nix  (default)
  # animations-end4.nix (end-4 project very fluid)
  # animations-dynamic.nix (ml4w project)
  # animations-moving.nix (ml4w project)
  animChoice = ../../modules/home/hyprland/animations-def.nix;
  #animChoice = ../../modules/home/hyprland/animations-end4.nix;
  #animChoice = ../../modules/home/hyprland/animations-dynamic.nix;
  #animChoice = ../../modules/home/hyprland/animations-moving.nix;
}
