{ users.users = {
     withoutboat = {
       isNormalUser = true;
        extraGroups = [
           "wheel"
           "networkmanager"
           "audio"
        ];
     };
  };
}
