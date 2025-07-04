{...}: {
  imports = [
    ./hardware.nix
    ./host-packages.nix
  ];

  #  home-manager = {
  #    useGlobalPkgs = true;
  #    extraSpecialArgs = {inherit host;};
  #    users = builtins.listToAttrs (
  #      map (user: {
  #        name = user;
  #        value = {
  #          #      imports = [./../../modules/home/default.nix];
  #          home = {
  #            username = user;
  #            homeDirectory = "/home/${user}";
  #            stateVersion = host.homeStateVersion or "23.11";
  #          };
  #        };
  #      })
  #      host.users
  #    );
  #  };
}
