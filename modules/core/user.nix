{
  pkgs,
  inputs,
  username,
  host,
  profile,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) gitUsername;
  home = "/home/${username}";
in {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
    useUserPackages = true;
    useGlobalPkgs = false;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs username host profile;};
    users.${username} = {
      imports = [./../home];
      home = {
        username = "${username}";
        homeDirectory = "${home}";
        stateVersion = "23.11";
      };
    };
  };

  sops.secrets."ssh_private_key_${username}" = {
    owner = username;
    mode = "0600";
    path = "${home}/.ssh/id_ed25519";
    sopsFile = ../../secrets/ssh_keys.yaml;
    key = "ssh_private_key";
  };

  sops.secrets."ssh_public_key_${username}" = {
    owner = username;
    mode = "0600";
    path = "${home}/.ssh/id_ed25519.pub";
    sopsFile = ../../secrets/ssh_keys.yaml;
    key = "ssh_public_key";
  };

  systemd.user.services.import-ssh-to-gpg = {
    description = "Import SSH key into GPG and add keygrip to sshcontrol";
    after = ["default.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        set -euo pipefail

        ssh_key="${home}/.ssh/id_ed25519"

        if [ -f "$ssh_key" ]; then
          # Import SSH key to GPG if not already present
          if ! gpg --with-keygrip --list-secret-keys | grep -q "$(ssh-keygen -lf "$ssh_key" | awk '{print $2}')" 2>/dev/null; then
            echo "Importing SSH key to GPG..."
            gpg --batch --import "$ssh_key" || true
          fi

          # Add keygrip to sshcontrol if needed
          keygrip=$(gpg --with-keygrip --import-options show-only --import "$ssh_key" 2>/dev/null | awk '/Keygrip/ {print $3}')
          if [ -n "$keygrip" ] && ! grep -q "$keygrip" "${home}/.gnupg/sshcontrol" 2>/dev/null; then
            echo "Adding keygrip $keygrip to ${home}/.gnupg/sshcontrol"
            mkdir -p "${home}/.gnupg"
            echo "$keygrip" >> "${home}/.gnupg/sshcontrol"
            chmod 700 "${home}/.gnupg"
            chmod 600 "${home}/.gnupg/sshcontrol"
          fi
        fi
      '';
      RemainAfterExit = "yes";
    };
    wantedBy = ["default.target"];
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
