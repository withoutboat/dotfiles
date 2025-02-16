{
  lib,
  nur,
  vim-plugins,
  zjstatus,
  ...
}:
{
  imports = [
    ../../modules/cli.nix
    ../../modules/firefox
    ../../modules/fonts.nix
    ../../modules/git
    ../../modules/nu
    ../../modules/nvim
    ../../modules/programming.nix
    ../../modules/system-management
    ../../modules/zellij
    ../../modules/zsh
  ];

  programs.home-manager.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "mark";
    homeDirectory = "/home/mark";
    stateVersion = "24.11";
  };
}
