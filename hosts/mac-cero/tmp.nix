{
  inputs,
  outputs,
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../systmes/nixos
  ];

  

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.mark = import ../home.nix;
  };
}
