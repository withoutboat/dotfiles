{
  pkgs,
  host,
  config,
  ...
}: let
  wgInterface = "amneziawg";
  secretName = "wg0.conf";
  secretPath = config.sops.secrets."${secretName}".path;
in {
  sops = {
    secrets = {
      ${secretName} = {
        sopsFile = ../../secrets/wg0.conf;
        mode = "0400";
        owner = "root";
        format = "binary";
      };
    };
  };

  services.resolved.enable = true;

  systemd.services.amneziawg-config = {
    description = "Install AmneziaWG WireGuard configuration (with max debugging)";
    wantedBy = ["multi-user.target"];
    before = ["wg-quick-${wgInterface}.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      set -x

      # Check secret path
      if [ -e "${secretPath}" ]; then
        echo "[$(date)] Secret exists at: ${secretPath}"
      else
        echo "[$(date)] ERROR: Secret missing at: ${secretPath}"
        ls -l $(dirname "${secretPath}")
        exit 1
      fi

      # Ensure /etc/wireguard exists
      mkdir -pv /etc/wireguard
      # Install config
      install -v -m 600 -o root -g root "${secretPath}" /etc/wireguard/${wgInterface}.conf

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
    configFile = "/etc/wireguard/${wgInterface}.conf";
    autostart = true;
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet wireguard-tools];
}
