{ pkgs, lib, ... }:
{
  programs.amnezia-vpn.enable = true;
  environment.systemPackages = [ pkgs.amnezia-vpn ];
}
