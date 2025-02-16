{ outputs, pkgs, ... }:
{
  imports =
    []
    ++ (builtins.attrValues outputs.homeManagerModules);

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
	pkgs.vim
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;
}
