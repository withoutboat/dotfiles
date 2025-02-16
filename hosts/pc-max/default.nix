{
  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../modules/nvidia.nix
    ../../modules/audio.nix
  ];

  home-manager = {
    users.mark = import ./home.nix;
  };

  networking = {
    hostName = "nixos";
  };

}
