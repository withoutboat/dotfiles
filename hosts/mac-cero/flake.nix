{config, ...}: {
  config = {
    imports = [
      ./hardware.nix
      ./host-packages.nix
    ];
  };
}
