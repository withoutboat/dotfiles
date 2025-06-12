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
          agenix-rekey.overlays.default
          nur.overlays.default
          vim-plugins.overlay
          (final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; })
        ];

      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = overlays; });

      
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

      agenix-rekey = agenix-rekey.configure {
        userFlake = self;
        nixosConfigurations = self.nixosConfigurations;
      };

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              agenix-rekey               
            ];
          };
        }
      );
    };
}
