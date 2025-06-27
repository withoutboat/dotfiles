{
  pkgs,
  host,
  config,
  ...
}: {
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
  systemd.services.nm-wireguard-import = {
    description = "Import and activate WireGuard (wg0) via NetworkManager";
    after = ["network.target" "sops-nix.service"];
    requires = ["sops-nix.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      set -e
      if ! nmcli connection show wg0 &>/dev/null; then
        nmcli connection import type wireguard file ${config.sops.secrets."wg0.conf".path}
      fi
      nmcli connection up wg0 || true
      nmcli connection modify wg0 connection.autoconnect yes
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
      ];
    };
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet];
}
