{ pkgs, ... }:
{
  age.rekey = {
    hostPubkey = "/etc/ssh/ssh_host_ed25519.pub";

    masterIdentities = [ "/home/withoutboat/.ssh/id_ed25519.pub" ];

    # storageModel = "derivation";
  };
}
