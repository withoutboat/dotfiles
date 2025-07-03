{pryme, ...}: {
  services.syncthing = {
    enable = false;
    user = "${pryme}";
    dataDir = "/home/${pryme}";
    configDir = "/home/${pryme}/.config/syncthing";
  };
}
