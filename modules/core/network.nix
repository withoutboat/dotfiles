{
  pkgs,
  host,
  config,
  ...
}: {
  sops.secrets.amneziawg = {
    sopsFile = ../../secrets/wg0.conf;
    mode = "0400";
    owner = "root";
    format = "binary";
  };

  services.resolved.enable = true;

  boot.extraModulePackages = with pkgs; [amneziawg];
  boot.kernelModules = ["amneziawg"];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  systemd.services.amneziawg-setup = {
    description = "Setup AmneziaWG Kernel Module with config";
    wantedBy = ["multi-user.target"];
    after = ["network-online.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = ''
        # Adjust the config path as necessary
        cat ${config.sops.secrets.amneziawg.path} > /dev/amneziawg
      '';
    };
  };

  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
    nat = {
      enable = true;
      externalInterface = "wlp4s0";
      internalInterfaces = ["amneziawg0"];
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443 59010 59011 8080];
      allowedUDPPorts = [59010 59011 51820];
    };
  };
}
