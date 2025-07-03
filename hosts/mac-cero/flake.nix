{
  description = "mac-cero host flake";

  outputs = _: {
    nixosModules = {
      default = {
        lib,
        config,
        ...
      }: {
        imports = [
          ./hardware.nix
          ./host-packages.nix
        ];

        options.host.variables = lib.mkOption {
          type = lib.types.attrs;
          default = {};
          description = "Host-specific arbitrary variables available everywhere";
        };

        config = {
          host.variables = import ./variables.nix;
        };
      };
    };
  };
}
