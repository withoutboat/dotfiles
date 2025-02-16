{
  users = {
    users = {
      mark = {
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager"];
      };
    };
  };

  security.sudo.wheelNeedsPassword = false;
}
