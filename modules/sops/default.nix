{ pkgs, inputs, ... }:
{
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = true;

    age  = {
     sshKeyPaths = [ "/home/withoutboat/.ssh/id_ed25519" ];
     keyFile = "/var/lib/sops-nix/key.txt";
     generateKey = true;
    };

    secrets = {
      primary = {};
    };
  };

  

  
}
