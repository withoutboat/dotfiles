{config, ...}: let
  sopsFile = ../../secrets/wg.yaml;
in {
  sops = {
    secrets = {
      "wg:private_key" = {
        inherit sopsFile;
        key = "private_key";
      };
      "wg:preshared_key" = {
        inherit sopsFile;
        key = "preshared_key";
      };
    };
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      address = ["10.8.1.16/32"];
      privateKeyFile = config.sops.secrets."wg:private_key".path;
      dns = ["1.1.1.1" "1.0.0.1"];

      peers = [
        {
          publicKey = "KugBNJzEl9dRNt6CUyuh9qcmEiIgiaHaXD/K6TSoanY=";
          presharedKeyFile = config.sops.secrets."wg:preshared_key".path;
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = "38.180.215.214:40633";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
