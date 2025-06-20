{
  description = "Home manager flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
            url = "github:Mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    # Applying the configuration happens from the .dotfiles directory so the
    # relative path is defined accordingly. This has potential of causing issues.
    vim-plugins = {
      url = "path:/etc/nixos/tmp/dotfiles/modules/nvim/plugins";
    };
    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      vim-plugins,
      nur,
      zjstatus,
	sops-nix,
    }@inputs:
    let
      inherit (self) outputs;

      overlays = [
        nur.overlays.default
        vim-plugins.overlay
        (final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; })
      ];
    in
    {
      nixosConfigurations = {
        mac-cero = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = overlays; }
            ./hosts/mac-cero
          ];
          specialArgs = { inherit inputs outputs overlays; };
        };
      };
    };
}
