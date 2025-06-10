{ pkgs, config, ... }:
{ 
#  sops.secrets.primary.neededForUsers = true;
#  users.mutableUsers = false;
  
  users.users = {
    withoutboat = {
     shell = pkgs.zsh;
#     hashedPasswordFile = config.sops.secrets.primary.path;
     isNormalUser = true;
     extraGroups = [
       "wheel"
       "networkmanager"
       "audio"
     ];
    };
  };
}
