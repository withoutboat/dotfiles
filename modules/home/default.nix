{host, ...}: {
  imports =
    [
      host.waybarChoice
      ./scripts
      ./rofi
      ./yazi
      ./zsh
      ./age-keygen.nix
      ./wlogout
      ./amfora.nix
      ./bash.nix
      ./bashrc-personal.nix
      ./bat.nix
      ./btop.nix
      ./cava.nix
      ./emoji.nix
      ./eza.nix
      ./fastfetch
      ./fzf.nix
      ./gh.nix
      ./git.nix
      ./gtk.nix
      ./htop.nix
      ./hyprland
      ./kitty.nix
      ./lazygit.nix
      ./nvf.nix
      ./qt.nix
      ./starship.nix
      ./starship-ddubs-1.nix
      ./stylix.nix
      ./swappy.nix
      ./swaync.nix
      ./telegram.nix
      ./virtmanager.nix
      ./xdg.nix
      ./zoxide.nix
    ]
    ++ (
      if host.vscodeEnable
      then [./vscode.nix]
      else []
    )
    ++ (
      if host.weztermEnable
      then [./wezterm.nix]
      else []
    )
    ++ (
      if host.ghosttyEnable
      then [./ghostty.nix]
      else []
    )
    ++ (
      if host.tmuxEnable
      then [./tmux.nix]
      else []
    )
    ++ (
      if host.alacrittyEnable
      then [./alacritty.nix]
      else []
    );

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
}
