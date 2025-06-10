{ pkgs, config, ... }:
{ 
  sops.secrets.primary.neededForUsers = true;
  users.mutableUser = false;
  
  users.users = {
    withoutboat = {
     shell = pkgs.zsh;
     hashedPasswordFile = config.sops.secret.primary.path;
     isNormalUser = true;
     extraGroups = [
       "wheel"
       "networkmanager"
       "audio"
     ];
    };
  };
}
