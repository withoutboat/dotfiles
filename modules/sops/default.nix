{ pkgs, inputs, ... }:
{
  sops = {
    defaultSopsFile = ../../secrets/system.yaml;
    validateSopsFiles = true;

    age = {
      keyFile = "/home/withoutbot/.config/sops/age/keys.txt";
    };
  };
}
