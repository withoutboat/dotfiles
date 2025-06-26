{...}: {
  imports = [
    ./hardware.nix
    ./host-packages.nix
    ./../../profiles/intel
    ./../../modules/core
  ];
}
