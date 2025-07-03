{host, ...}: {
  services.xserver = {
    enable = false;
    xkb = {
      layout = "${host.keyboardLayout}";
      variant = "";
    };
  };
}
