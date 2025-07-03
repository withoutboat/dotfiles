{
  description = "mac-cero host flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = _: let
    system = "x86_64-linux";
    config = import ./variables.nix;
  in {
    inherit config;
    inherit system;

    nixosModules.default = {...}: {
      imports = [
        ./hardware.nix
        ./host-packages.nix
      ];
    };
  };
}
