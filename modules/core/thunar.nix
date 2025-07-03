{
  host,
  pkgs,
  ...
}: {
  programs = {
    thunar = {
      enable = host.thunarEnable;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer # Need For Video / Image Preview
  ];
}
