{
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../../systems/nixos
  ];

  home-manager = {
    useUserPackages = true;
    users.withoutboat = import ../../home.nix;
  };
}
