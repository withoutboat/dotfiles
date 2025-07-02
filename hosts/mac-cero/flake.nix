{
  description = "mac-cero host flake";

  outputs = _: {
    nixosModules = {
      default = {
        imports = [
          ./hardware.nix
          ./host-packages.nix
        ];
      };
    };
  };
}
