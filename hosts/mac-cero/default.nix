{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    ./hardware.nix
    ./host-packages.nix
    ./../../profiles/intel
    ./../../modules/core
  ];
}
