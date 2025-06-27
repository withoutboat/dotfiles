{
  config,
  pkgs,
  lib,
  ...
}: let
  sshKey = "${config.home.homeDirectory}/entrypoint/sops";
  destDir = "${config.home.homeDirectory}/.config/sops/age";
  destKey = "${destDir}/keys.txt";
  sshToAgeBin = "${pkgs.ssh-to-age}/bin/ssh-to-age";
in {
  home.packages = with pkgs; [
    ssh-to-age
    age
    sops
  ];

  home.activation.generateAgeKey = lib.hm.dag.entryAfter ["writeBoundary"] ''
    set -euo pipefail

    if [ ! -x "${sshToAgeBin}" ]; then
      echo "ssh-to-age not found at ${sshToAgeBin}, please install it."
      exit 1
    fi

    if [ ! -f "${sshKey}" ]; then
      echo "SSH public key not found at ${sshKey}, skipping age key generation."
      exit 0
    fi

    mkdir -p "${destDir}"
    "${sshToAgeBin}" -private-key -i ${sshKey} > "${destKey}"
    chmod 600 "${destKey}"
  '';
}
