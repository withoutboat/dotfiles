{ overlays, inputs, lib, ... }: {
  imports = [
    ./modules/cli.nix
    ./modules/firefox
 #   ./modules/fonts.nix
    ./modules/git
    ./modules/nu
    ./modules/nvim
    ./modules/programming.nix
    ./modules/system-management
    ./modules/zellij
    ./modules/zsh
    ./modules/chromium
    ./modules/telegram
    ./modules/age-keygen
  ];

  programs.home-manager.enable = true;
  programs.zsh.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate =
              pkg:
              builtins.elem (lib.getName pkg) [
                "zoom"
                "unrar"
                "codeium"
                "terraform"
                # browser extensions
                "onepassword-password-manager"
                "okta-browser-plugin"
              ];
    };
    overlays = overlays;
  };

  home = {
    username = "withoutboat";
    homeDirectory = "/home/withoutboat";
    stateVersion = "24.11";
  };
}
