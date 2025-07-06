{
  pkgs,
  host,
  pryme,
  config,
  ...
}: let
  home = "/home/${pryme}";
in {
  sops.secrets."ssh_private_key_${pryme}" = {
    owner = pryme;
    mode = "0600";
    path = "${home}/.ssh/id_ed25519";
    sopsFile = ../../secrets/ssh_keys.yaml;
    key = "ssh_private_key";
  };

  sops.secrets."ssh_public_key_${pryme}" = {
    owner = pryme;
    mode = "0600";
    path = "${home}/.ssh/id_ed25519.pub";
    sopsFile = ../../secrets/ssh_keys.yaml;
    key = "ssh_public_key";
  };

  sops.secrets.github_token = {
    sopsFile = ./../../secrets/system.yaml;
    key = "github_token"; 
    path = "${home}/.local/github_token";
  };

  users.mutableUsers = true;
  users.users.${pryme} = {
    isNormalUser = true;
    description = "${host.gitUsername}";
    extraGroups = [
      "adbusers"
      "docker"
      "libvirtd"
      "lp"
      "networkmanager"
      "scanner"
      "wheel"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = ["${pryme}"];
}
