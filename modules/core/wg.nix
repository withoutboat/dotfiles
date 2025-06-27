{config, ...}: let
  sopsFile = ../../secrets/wg.yaml;
in {
  sops = {
    secrets = {
      "wg:private_key" = {
        inherit sopsFile;
      };
      "wg:public_key" = {
        inherit sopsFile;
      };
      "wg:preshared_key" = {
        inherit sopsFile;
      };
      "wg:endpoint" = {
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
          publicKye = builtins.readFile config.sops.secrets."wg:public_key".path;
          presharedKeyFile = config.sops.secrets."wg:preshared_key".path;
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = builtins.readFile config.sops.secrets."wg:endpoint".path;
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
