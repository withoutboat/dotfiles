{
  inputs,
  overlays,
  outputs,
  system,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../../systems/nixos
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs system overlays;
    };
    useUserPackages = true;
    users.withoutboat = import ../../home.nix;
  };
}
