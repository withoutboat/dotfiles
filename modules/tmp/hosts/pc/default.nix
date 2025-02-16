{
  inputs,
  outputs,
  ...
}: {
  imports = [
	./hardware-configuration.nix
	../../modules
	../../modules/nvidia.nix
	../../modules/audio.nix
	../../modules/gdm.nix
	../../modules/gnom.nix
	../../modules/x11.nix
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    users.mark = import ./home.nix;
  };

  networking.hostName = "nixos"; 
}
