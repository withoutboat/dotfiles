{host, ...}: {
  services = {
    printing = {
      enable = host.printEnable;
      drivers = [
        # pkgs.hplipWithPlugin
      ];
    };
    avahi = {
      enable = host.printEnable;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = host.printEnable;
  };
}
