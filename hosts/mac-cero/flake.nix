{
  config,
  lib,
  ...
}: let
  variables = import ./variables.nix;
in {
  options = {
    host = lib.mkOption {
      type = lib.types.attrs;
      default = variables;
      description = "Configuration variables for mac-cero host.";
    };
  };

  config = {
    imports = [
      ./hardware.nix
      ./host-packages.nix
    ];
  };
}
