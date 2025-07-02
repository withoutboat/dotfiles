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
    # Expose modules for the root flake to use
    nixosModules = {
      hardware = import ./hardware.nix;
      packages = import ./host-packages.nix;

      # Default module that combines everything
      default = {...}: {
        imports = [
          sops-nix.nixosModules.sops
          ./hardware.nix
          ./host-packages.nix
        ];
      };
    };
  };
}
