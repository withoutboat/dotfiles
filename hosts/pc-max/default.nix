{
  inputs,
  outputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ./configuration.nix
    ../../modules/nvidia
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    users.mark = import ./home.nix;
  };
}
