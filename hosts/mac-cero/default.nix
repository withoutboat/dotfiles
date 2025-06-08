{
  inputs,
  overlays.
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
      inherit inputs overlays;
    };
    useUserPackages = true;
    users.withoutboat = import ../../home.nix;
  };
}
