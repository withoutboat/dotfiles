{
  pkgs,
  inputs,
  username,
  host,
  profile,
  sops-nix,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) gitUsername;
  home = "/home/${username}";
in {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    sharedModules = [
      sops-nix.homeManagerModules.sops
    ];
    useUserPackages = true;
    useGlobalPkgs = false;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs username host profile;};
    users.${username} = {
      imports = [./../home];
      home = {
        username = "${username}";
        homeDirectory = "${home}";
        stateVersion = "23.11";
      };
    };
  };

  sops.secrets."ssh_private_key_${username}" = {
    owner = username;
    mode = "0600";
    path = "${home}/.ssh/id_ed25519";
    sopsFile = ../../secrets/ssh_keys.yaml;
    key = "ssh_private_key";
  };

  sops.secrets."ssh_public_key_${username}" = {
    owner = username;
    mode = "0600";
    path = "${home}/.ssh/id_ed25519.pub";
    sopsFile = ../../secrets/ssh_keys.yaml;
    key = "ssh_public_key";
  };

  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "${gitUsername}";
    extraGroups = [
      "adbusers"
      "docker"
      "libvirtd"
      "lp"
      "networkmanager"
      "scanner"
      "wheel"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
  nix.settings.allowed-users = ["${username}"];
}
