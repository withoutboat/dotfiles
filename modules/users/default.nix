{ users.users = {
    withoutboat = {
     shell = pkgs.zsh;
     isNormalUser = true;
     initialPassword = "temp123";
     extraGroups = [
       "wheel"
       "networkmanager"
       "audio"
     ];
    };
  };
}
