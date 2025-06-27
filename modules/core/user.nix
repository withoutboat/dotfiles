{
  pkgs,
  inputs,
  username,
  host,
  profile,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) gitUsername;
in {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = false;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs username host profile;};
    users.${username} = {
      imports = [./../home];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "23.11";
      };
    };
  };

  sops.secrets."ssh_private_key_${username}" = {
    owner = username;
    mode = "0600";
    path = "/home/${username}/.ssh/id_ed25519";
    sopsFile = ../../secrets/ssh_keys.yaml;
    key = "ssh_private_key";
  };

  sops.secrets."ssh_public_key_${username}" = {
    owner = username;
    mode = "0600";
    path = "/home/${username}/.ssh/id_ed25519.pub";
    sopsFile = ../../secrets/ssh_keys.yaml;
    key = "ssh_public_key";
  };

  systemd.user.services."${username}-ssh-add-config-ssh-private-key" = {
    wantedBy = ["default.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.openssh}/bit/ssh-add /home/${username}/.ssh/id_ed25519";
      Environment = "SSH_AUTH_SOCK=%t/ssh-agent";
    };
    after = ["ssh-agent.service"];
  };

  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "${gitUsername}";
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
  nix.settings.allowed-users = ["${username}"];
}
