{ pkgs, lib, ... }:
let
  amnezia-gui = pkgs.stdenv.mkDerivation rec {
    pname = "amnezia-gui";
    version = "4.8.7.2";

    src = pkgs.fetchurl {
      url = "https://github.com/amnezia-vpn/amnezia-client/releases/download/4.8.7.2/AmneziaVPN_4.8.7.2_linux_x64.tar.zip";
      sha256 = "ce8261783b7760d3c51d085fe275ae7cb173fb4251a015f268387a9aeca77f6b";
    };

    nativeBuildInputs = [ pkgs.unzip ];

    unpackPhase = ''
      unzip $src
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp AmneziaVPN $out/bin/amnezia-gui
      chmod +x $out/bin/amnezia-gui
    '';

    meta = with lib; {
      description = "Amnezia VPN GUI Client";
      homepage = "https://github.com/amnezia-vpn/amnezia-client";
      license = licenses.gpl3;
      platforms = platforms.linux;
    };
  };
in
{
  environment.systemPackages = [ amnezia-gui ];
}
