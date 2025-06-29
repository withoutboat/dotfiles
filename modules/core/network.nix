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
    path = "/etc/amnezia/amneziawg.conf";
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    wireguard-tools
    openresolv
  ];

  #  systemd.services.amneziawg-up = {
  #    description = "Bring up AmneziaWG tunnel";
  #    wantedBy = ["multi-user.target"];
  #    after = ["install-amneziawg-conf.service"];
  #    serviceConfig = {
  #      Type = "oneshot";
  #      ExecStart = "${pkgs.amneziawg-tools}/bin/awg-quick up /etc/amnezia/amneziawg0.conf";
  #      RemainAfterExit = true;
  #    };
  #  };

  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    networkmanager.dns = "none";
    nat = {
      enable = true;
      externalInterface = "wlp4s0";
      internalInterfaces = ["amneziawg"];
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443 59010 59011 8080];
      allowedUDPPorts = [59010 59011 51820];
    };
  };
}
