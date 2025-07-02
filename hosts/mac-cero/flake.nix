{
  description = "mac-cero host flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

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
