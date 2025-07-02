{
  description = "mac-cero host flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {sops-nix, ...}: {
    nixosModules = {
      default = {
        imports = [
          sops-nix.nixosModules.sops
          ./hardware.nix
          ./host-packages.nix
        ];
      };
    };
  };
}
