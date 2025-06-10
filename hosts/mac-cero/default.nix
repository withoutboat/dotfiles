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
    system = system;
    extraSpecialArgs = {
      inherit inputs outputs overlays;
    };
    useUserPackages = true;
    users.withoutboat = import ../../home.nix;
  };
}
