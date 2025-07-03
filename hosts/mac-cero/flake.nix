{
  description = "mac-cero host flake";

  outputs = _: {
    config = import ./variables.nix;

    nixosModules.default = {...}: {
      imports = [
        ./hardware.nix
        ./host-packages.nix
      ];
    };
  };
}
