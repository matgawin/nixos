{
  pkgs,
  config,
  ...
}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 19;
        spacing = 2;

        modules-left = ["niri/workspaces" "niri/window"];
        modules-center = ["clock"];
        modules-right = [
          "custom/playerctl"
          "custom/prev"
          "custom/next"
          "tray"
          "pulseaudio"
          "memory"
          "cpu"
        ];

        "niri/workspaces" = {
          format = "{name}";
          all-outputs = false;
        };

        "niri/window" = {
          format = "{title}";
          max-length = 80;
          separate-outputs = true;
        };

        "clock" = {
          format = "{:%Y-%m-%d %H:%M}";
          interval = 60;
        };

        "memory" = {
          format = "RAM {}%";
          interval = 2;
          on-click = "NO_TMUX=1 ${pkgs.alacritty}/bin/alacritty --class QuickShell -e btop -p 2";
        };

        "cpu" = {
          format = "CPU {usage}%";
          interval = 2;
          on-click = "NO_TMUX=1 ${pkgs.alacritty}/bin/alacritty --class QuickShell -e btop -p 1";
        };

        "pulseaudio" = {
          format = "{icon}{volume}%";
          format-muted = " ";
          format-icons = {
            default = [" " " " " "];
          };
          on-click = "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        "tray" = {
          spacing = 5;
        };

        "custom/playerctl" = {
          exec = "${pkgs.playerctl}/bin/playerctl metadata --format '{{ artist }}|{{ title }}' 2>/dev/null || echo ''";
          exec-if = "${pkgs.playerctl}/bin/playerctl status 2>/dev/null";
          interval = 3;
          on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
          format = " {} ";
          max-length = 35;
        };
        "custom/prev" = {
          format = "󰒮 ";
          on-click = "${pkgs.playerctl}/bin/playerctl previous";
          max-length = 2;
        };
        "custom/next" = {
          format = "󰒭 ";
          on-click = "${pkgs.playerctl}/bin/playerctl next";
          max-length = 2;
        };
      };
    };

    style = let
      fonts = config.fontProfiles.monospace;
    in ''
      * {
        font-family: "${fonts.name}";
        font-size: ${toString fonts.size}pt;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background-color: #2E3440;
        color: #ECEFF4;
      }

      #workspaces button {
        padding: 0 8px;
        color: #D8DEE9;
        background-color: transparent;
        min-width: 0px;
        padding: 5px;
        margin: 0;
      }

      #workspaces button.active {
        background-color: #81A1C1;
        color: #D8DEE9;
      }

      #workspaces button.urgent {
        background-color: #BF616A;
      }

      #workspaces button:hover {
        background-color: #3B4252;
      }

      #window,
      #clock,
      #memory,
      #cpu,
      #pulseaudio,
      #custom-playerctl {
        padding: 0 8px;
        color: #ECEFF4;
      }

      #memory,
      #cpu {
        color: #88C0D0;
      }

      #pulseaudio.muted {
        color: #666666;
      }

      #tray {
        padding: 0 8px;
      }

      #custom-playerctl {
        color: #88C0D0;
      }
    '';
  };
}
