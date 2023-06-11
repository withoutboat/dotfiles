{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # CLI tools / Terminal facification
    arandr
    bashmount
    dig
    docker-compose
    dua
    fx
    gnumake
    graphviz
    hexyl
    jq
    ngrok
    openvpn
    tokei
    unrar
    unzip
    # Build failing on MacOS
    /* wireshark */
    pgcli
    dogdns
    drone-cli

    ruff

    # Moar colors
    starship
    zsh-syntax-highlighting

    # Searching/Movement helpers
    ripgrep
    zoxide

    # system info
    bottom
    neofetch

    # Nix itself
    nix
  ];
}
