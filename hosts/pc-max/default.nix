{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ../../modules/nvidia.nix
  ];

  home-manager = {
    users.mark = import ./home.nix;
  };
}
