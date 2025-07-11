{lib, ...}: {
  programs.gh.enable = true;

  home.activation.importEnvSecrets = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -f /run/secrets/environment.env ]; then
      set -a
      source /run/secrets/environment.env
      set +a
    fi
  '';

  imports = [
    ./waybar/waybar-ddubs.nix
    #./waybar/waybar-ddubs-2.nix
    ./scripts
    ./rofi
    ./yazi
    ./zsh
    ./age-agent.nix
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
    # ./nvf.nix
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
    #./vscode.nix
    ./ghostty.nix
  ];
}
