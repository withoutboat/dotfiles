{config, ...}: let
  sopsFile = ../../secrets/wg.yaml;
in {
  sops = {
    secrets = {
      "wg:private_key" = {
        inherit sopsFile;
      };
      "wg:preshared_key" = {
        inherit sopsFile;
      };
    };
  };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["10.8.1.16/32"];
      privateKeyFile = config.sops.secrets."wg:private_key".path;

      peers = [
        {
          publicKye = "KugBNJzEl9dRNt6CUyuh9qcmEiIgiaHaXD/K6TSoanY=";
          presharedKeyFile = config.sops.secrets."wg:preshared_key".path;
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = "38.180.215.214:40633";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
