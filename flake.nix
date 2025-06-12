{
  description = "Home manager flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 

    agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    agenix-rekey = {
            url = "github:oddlama/agenix-rekey"; 
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
      agenix,
      agenix-rekey,
    }@inputs:
    let
      inherit (self) outputs;

      overlays = [
          nur.overlay
          vim-plugins.overlay
          (final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; })
        ];

      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        mac-cero = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
		       { nixpkgs.overlays = overlays; }
            ./hosts/mac-cero
          ];
          specialArgs = { inherit inputs outputs overlays; };
        };
      };
    };

    flake-utils.lib.eachDefaultSystem system: rec {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ agenix-rekey.overlays.default ];
        };
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.agenix-rekey ];
        };
      };
      
}
