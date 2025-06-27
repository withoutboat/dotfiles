{
  pkgs,
  host,
  config,
  ...
}: let
  amneziawgSecret = config.sops.secrets."wgO.conf".path;
  wgInterface = "amneziawg";
in {
  sops = {
    secrets = {
      "wg0.conf" = {
        sopsFile = ../../secrets/wg0.conf;
        mode = "0400";
        owner = "root";
        format = "binary";
      };
    };
  };

  services.resolved.enable = true;

  systemd.services.amneziawg-config = {
    description = "Install AmneziaWG WireGuard configuration";
    wantedBy = ["multi-user.target"];
    before = ["wg-quick-${wgInterface}.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      install -m 600 -o root -g root ${amneziawgSecret} /etc/wireguard/${wgInterface}.conf
    '';
  };

  networking = {
    hostName = "${host}";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
    #   timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        8080
      ];
      allowedUDPPorts = [
        59010
        59011
        51820
      ];
    };
  };
  networking.wg-quick.interfaces.${wgInterface} = {
    autostart = true;
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet wireguard-tools];
}
