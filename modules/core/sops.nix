{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sops
  ];

  sops = {
    defaultSopsFile = ../../../secrets/system.yaml;
    validateSopsFiles = true;

    age = {
      sshKeyPaths = ["/home/withoutboat/entrypoint/sops"];
    };
  };
}
