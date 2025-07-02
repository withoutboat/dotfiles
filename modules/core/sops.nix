{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sops
  ];

  services.sops = {
    defaultSopsFile = ../../../secrets/system.yaml;
    validateSopsFiles = true;

    age = {
      sshKeyPaths = ["/home/withoutboat/entrypoint/sops"];
    };
  };
}
