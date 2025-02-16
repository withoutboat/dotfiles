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
    };

    # Applying the configuration happens from the .dotfiles directory so the
    # relative path is defined accordingly. This has potential of causing issues.
    vim-plugins = {
      url = "path:./modules/nvim/plugins";
    };
    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # MacOS specific inputs
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      nur,
      vim-plugins,
      nixpkgs,
      home-manager,
      zjstatus,

      darwin,
      nixpkgs-firefox-darwin,
      mac-app-util,
    }@inputs:
    let
      inherit (self) outputs;
      overlays = {
        # NOTE: Injecting colorscheme so that it is passed down all the imports
        _module.args = {
          colorscheme = import ./colorschemes/tokyonight.nix;
        };
        nixpkgs.overlays = [
          nur.overlay
          vim-plugins.overlay
          (final: prev: { zjstatus = zjstatus.packages.${prev.system}.default; })
        ];

      };

      home-macbook = {
        # Hack: Firefox does not work on mac so we have to depend on an overlay.
        nixpkgs.overlays = [ nixpkgs-firefox-darwin.overlay ];
        home.homeDirectory = "/Users/mark";
        home.username = "mark";
        imports = [ mac-app-util.homeManagerModules.default ];
        xdg.configFile."nix/nix.conf".text = ''
          experimental-features = nix-command flakes
        '';
      };

      home-linux = {
        home.homeDirectory = "/home/mark";
        home.username = "mark";
        imports = [
          # Desktop Environment
          ./modules/linux/desktop-environment.nix
          ./modules/linux/betterlockscreen
          ./modules/linux/colorscheme-based-background
          ./modules/linux/deadd
          ./modules/linux/eww
          ./modules/linux/gtk
          ./modules/linux/picom
          ./modules/linux/plasma-browser-integration
          ./modules/linux/rofi
          ./modules/linux/xidlehook
        ];
      };

    in
    {
      #  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      #    system = "x86_64-linux";
      #    modules = [ ./system/nixos/configuration.nix ];
      #  };

      nixosConfigurations = {
        pc-max = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            overlays
            ./hosts/pc-max
          ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      #      homeConfigurations = {
      #        nixos = home-manager.lib.homeManagerConfiguration {
      #          pkgs = nixpkgs.legacyPackages."x86_64-linux";
      #          modules = [
      #            overlays
      #            home-linux
      #          ];
      #        };
      #
      #        pc-max = home-manager.lib.homeManagerConfiguration {
      #          pkgs = nixpkgs.legacyPackages."x86_64-linux";
      #          modules = [
      #            overlays
      #            ./hosts/pc-max/home.nix
      #          ];
      #        };
      #
      #        srt-l02-sekhmet = home-manager.lib.homeManagerConfiguration {
      #          pkgs = nixpkgs.legacyPackages."x86_64-darwin";
      #          modules = [
      #            overlays
      #            home-macbook
      #          ];
      #        };
      #      };
      #
      darwinConfigurations."srt-l02-sekhmet" = darwin.lib.darwinSystem {
        pkgs = nixpkgs.legacyPackages."x86_64-darwin";
        modules = [
          ./modules/mac/configuration.nix
          ./modules/mac/yabai.nix
          ./modules/mac/skhd.nix
          ./modules/mac/homebrew.nix
        ];
      };
    };
}
