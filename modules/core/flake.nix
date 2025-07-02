{
  description = "Core system module flake for withoutboat/dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    stylix,
    nix-flatpak,
    sops-nix,
    ...
  }: {
    nixosModules.default = {
      imports = [
        stylix.nixosModules.stylix
        sops-nix.nixosModules.sops
        nix-flatpak.nixosModules.nix-flatpak
        ./flatpak.nix
        ./stylix.nix
        ./sops.nix
        ./doas.nix
        ./fonts.nix
        ./hardware.nix
        ./network.nix
        ./nfs.nix
        ./nh.nix
        ./packages.nix
        ./printing.nix
        ./sddm.nix
        # (
        #   if config.host.displayManager == "tui"
        #   then ./greetd.nix
        #   else ./sddm.nix
        # )
        ./security.nix
        ./services.nix
        ./steam.nix
        ./syncthing.nix
        ./system.nix
        ./thunar.nix
        ./user.nix
        ./virtualisation.nix
        ./xserver.nix
      ];
    };
  };
}
