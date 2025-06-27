{host, ...}: let
  inherit
    (import ../../hosts/${host}/variables.nix)
    alacrittyEnable
    ghosttyEnable
    tmuxEnable
    waybarChoice
    weztermEnable
    vscodeEnable
    ;
in {
  imports =
    [
      waybarChoice
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
      ./rofi
      ./qt.nix
      ./scripts
      ./starship.nix
      ./starship-ddubs-1.nix
      ./stylix.nix
      ./swappy.nix
      ./swaync.nix
      ./telegram.nix
      ./virtmanager.nix
      ./xdg.nix
      ./yazi
      ./zoxide.nix
      ./zsh
    ]
    ++ (
      if vscodeEnable
      then [./vscode.nix]
      else []
    )
    ++ (
      if weztermEnable
      then [./wezterm.nix]
      else []
    )
    ++ (
      if ghosttyEnable
      then [./ghostty.nix]
      else []
    )
    ++ (
      if tmuxEnable
      then [./tmux.nix]
      else []
    )
    ++ (
      if alacrittyEnable
      then [./alacritty.nix]
      else []
    );

  sops = {
    defaultSopsFile = ../../secrets/wg.yaml;
    age = {
      sshKeyPaths = ["/home/withoutboat/personal/entrypoint/sops"];
    };
    secrets.test = {
      sopsFile = ../../secrets/wg.yaml;
      key = "entrypoint";
      paht = "%r/test.txt";
    };
  };
}
