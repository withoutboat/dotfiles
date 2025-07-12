{
  pkgs,
  host,
  config,
  ...
}: {
  sops.secrets.awg_private_key = {
    sopsFile = ../../secrets/amneziawg0.yaml;
    mode = "0400";
    owner = "root";
    key = "private_key";
  };

  sops.secrets.awg_preshared_key = {
    sopsFile = ../../secrets/amneziawg0.yaml;
    mode = "0400";
    owner = "root";
    key = "preshared_key";
  };

  sops.secrets.wifi_password = {
    sopsFile = ../../secrets/wifi.yaml;
    mode = "0400";
    owner = "root";
    key = "${host.wifiKey}";
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  networking = {
    hostName = "${host.name}";
    networkmanager = {
      enable = true;
      connections = [
        {
          connection.id = "${host.wifiSsid}";
          connection.type = "802-11-wireless";
          "802-11-wireless" = {
            ssid = host.wifiSsid;
            mode = "infrastraction";
          };
          "802-11-wireless-security" = {
            key-mgmt = "wpa-psk";
            psk-file = config.sops.secrets.wifi_password.path;
          };
          ipv4.mehtod = "auto";
          ipv6.mehtod = "auto";
        }
      ];
    };

    wg-quick.interfaces.awg = {
      type = "amneziawg";
      address = ["10.8.1.15/32"];
      privateKeyFile = config.sops.secrets.awg_private_key.path;
      dns = ["1.1.1.1" "1.0.0.1"];
      peers = [
        {
          publicKey = "KugBNJzEl9dRNt6CUyuh9qcmEiIgiaHaXD/K6TSoanY=";
          presharedKeyFile = config.sops.secrets.awg_preshared_key.path;
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = "38.180.215.214:40633";
          persistentKeepalive = 25;
        }
      ];
      extraOptions = {
        Jc = 2;
        Jmin = 10;
        Jmax = 50;
        S1 = 60;
        S2 = 112;
        H1 = 376055570;
        H2 = 1639697511;
        H3 = 909075871;
        H4 = 834856207;
      };
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443 59010 59011 8080];
      allowedUDPPorts = [59010 59011 51820];
    };
  };
}
