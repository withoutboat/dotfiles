{
  inputs,
  outputs,
overlays,
nixpkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ./configuration.nix
    ../../modules/nvidia
  ];

nixpkgs.config.allowUnfree = true;

  home-manager = {
      useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs outputs overlays;
    };
    users.mark = import ./home.nix;
  };
}
