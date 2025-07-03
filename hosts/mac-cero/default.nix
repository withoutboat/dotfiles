{host, ...}: {
  imports = [
    ./hardware.nix
    ./host-packages.nix
  ];

  home-manager.users = builtins.listToAttrs (
    map (user: {
      name = user;
      value = {
        home.stateVersion = host.homeStateVersion or "23.11";
        home.homeDirectory = "/home/${user}";
      };
    })
    host.users
  );
}
