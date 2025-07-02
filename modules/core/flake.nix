{
  description = "Core system module flake for withoutboat/dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flatpak = {
      url = "path:./flatpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    stylix,
    flatpak,
    ...
  }: {
    nixosModules.default = {config, ...}: {
      imports = [
        stylix.nixosModules.stylix
        flatpak.nixosModules.default
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
        (
          if config.host.displayManager == "tui"
          then ./greetd.nix
          else ./sddm.nix
        )
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
