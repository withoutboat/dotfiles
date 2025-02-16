{ lib, ... }:
{
  imports = [ ];

  nixpkgs.config = {

    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "zoom"
        "unrar"
        "terraform"
        "codeium"
        # browser extensions
        "onepassword-password-manager"
        "okta-browser-plugin"
      ];
  };

  nixpkgs.overlays = [
    nur.overlay
    vim-plugins.overlay
    (final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; })
  ];

  home = {
    username = "mark";
    homeDirectory = "/home/mark";
  };

  home.packages = [
  ];

  home.file = {
  };

  programs = {
    firefox.enable = true;
  };
}
