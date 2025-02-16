{
  inputs,
  outputs,
  config,
  lib,
  ...
}: {
  imports = [
    ./boot.nix
    ./networking.nix
    ./users.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  services.printing.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = false;
      warn-dirty = false;
      trusted-users = ["mark"];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

# Set your time zone.
  time.timeZone = "Asia/Yekaterinburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };


  system.stateVersion = "24.11";
}
