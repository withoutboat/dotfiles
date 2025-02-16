{
  config,
  pkgs,
  ...
}: let
  scheme = config.lib.stylix.colors {template = builtins.readFile ./style.colors.mustache;};

  playerctl = "${pkgs.playerctl}/bin/playerctl";
  light = "${pkgs.light}/bin/light";
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  helvum = "${pkgs.helvum}/bin/helvum";

  playerExec = pkgs.writeShellScriptBin "player-exec" ''
    current_song="$(${playerctl} metadata --player spotify --format '{{artist}} - {{title}}' 2> /dev/null)"
    if [ -n "$current_song" ]; then
      echo " $current_song"
    else
      echo ""
    fi
  '';
in {
  programs.waybar = {
    enable = true;

    style = with config.stylix.fonts; ''
      @import "${scheme}";

      * {
        border-radius: 0px;
        min-height: 20px;
        font-weight: 500;
        font-family: ${sansSerif.name}, "Symbols Nerd Font";
        font-size: 14px;
      }

      ${builtins.readFile ./style.css}
    '';

    systemd.enable = true;

    settings = let
      colors = config.lib.stylix.colors.withHashtag;
    in {
      bar = {
        # Configuration & Setup
        layer = "top";
        position = "top";
        output = builtins.map (m: m.name) (builtins.filter (m: !m.noBar) config.monitors);
        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["custom/player"];
        modules-right = ["tray" "cpu" "memory" "backlight" "pulseaudio" "network" "battery" "clock"];

        # Modules
        "hyprland/window" = {
          format = "{}";
        };

        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "󰎤";
            "2" = "󰎧";
            "3" = "󰎪";
            "4" = "󰎭";
            "5" = "󰎱";
            "6" = "󰎳";
            "7" = "󰎶";
            "8" = "󰎹";
            "9" = "󰎼";
            "urgent" = "󰀧";
            "focused" = "󱗜";
            "default" = "󱗜";
          };
        };

        cpu = {
          interval = 3;
          format = "<span color='${colors.base0B}'>  </span>{usage}%";
          format-alt = "<span color='${colors.base0B}'>  </span>{icon}";
          format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
        };

        memory = {
          interval = 3;
          format = "<span color='${colors.base0B}'>  </span>{}%";
          format-alt = "<span color='${colors.base0B}'>  </span>{icon}";
          format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
          tooltip-format = "{used:0.1f}GiB/{total:0.1f}GiB total ({swapUsed:0.1f}GiB/{swapAvail:0.1f}GiB swap)";
        };

        network = {
          interval = 3;
          format-wifi = "<span color='${colors.base0B}'>  </span>{signalStrength}%";
          format-ethernet = "<span color='${colors.base0B}'>󰈀  </span>{ifname}";
          format-linked = "<span color='${colors.base0B}'>󰌙 </span>(No IP)";
          format-disconnected = "";
          format-alt = "<span color='${colors.base0B}'>󰛴 </span>{bandwidthDownBits} <span color='${colors.base0B}'>󰛶 </span>{bandwidthUpBits}";
          tooltip-format = ''
            Address: {ipaddr}/{cidr}
            Gateway: {gwaddr} ({netmask})
            Interface: {ifname}'';
          tooltip-format-wifi = ''
            Address: {ipaddr}/{cidr}
            Gateway: {gwaddr} ({netmask})
            Interface: {ifname}
            ESSID: {essid} ({signalStrength}% [{signaldBm}dBm])'';
        };

        backlight = {
          format = "<span color='${colors.base0B}'>{icon} </span>{percent}%";
          format-alt = "<span color='${colors.base0B}'>{icon}</span>";
          format-icons = ["󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];

          on-scroll-up = "${light} -A 1";
          on-scroll-down = "${light} -U 1";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          interval = 15;
          format = "<span color='${colors.base0B}'>{icon} </span>{capacity}%";
          format-alt = "<span color='${colors.base0B}'>{icon}</span>";
          format-icons = {
            default = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            charging = ["󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
          };
        };

        clock = {
          format = "<span color='${colors.base0B}'> </span>{:%I:%M%p}";
          format-alt = "<span color='${colors.base0B}'> </span>{:%a, %b %e}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          timezone = "Europe/Brussels";
        };

        pulseaudio = {
          format = "<span color='${colors.base0B}'>{icon} </span>{volume}%";
          tooltip = false;
          format-muted = "<span color='${colors.base0B}'>󰖁</span>";
          on-click = "${pamixer} -t";
          on-click-right = "${pavucontrol}";
          on-click-middle = "${helvum}";
          on-scroll-up = "${pamixer} -i 5";
          on-scroll-down = "${pamixer} -d 5";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
        };

        "custom/player" = {
          interval = 2;
          exec = "${playerExec}/bin/player-exec";
          tooltip = false;
          escape = true;

          on-click = "${playerctl} --player spotify play-pause";
          on-scroll-up = "${playerctl} --player spotify volume 0.1+";
          on-scroll-down = "${playerctl} --player spotify volume 0.1-";
        };
      };
    };
  };
}
