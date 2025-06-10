{
  inputs,
  overlays,
  outputs,
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
      inherit inputs outputs overlays;
    };
    useUserPackages = true;
    users.withoutboat = import ../../home.nix;
  };
}
