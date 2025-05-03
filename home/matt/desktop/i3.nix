{
  pkgs,
  lib,
  config,
  ...
}: {
  xsession.windowManager.i3 = {
    enable = true;
    config = let
      mod = "Mod4";
    in
      lib.mkOptionDefault {
        modifier = "${mod}";
        menu = "${pkgs.rofi}/bin/rofi -show drun";
        bars = [
          {
            id = "top";
            command = "pkill polybar || sleep 0.5 && ${pkgs.polybar}/bin/polybar -l error -r top &";
            position = "top";
            mode = "dock";
          }
        ];
        terminal = "${pkgs.alacritty}/bin/alacritty";
        workspaceAutoBackAndForth = true;
        defaultWorkspace = "workspace number 1";

        fonts = {
          names = [config.fontProfiles.monospace.name];
          size = config.fontProfiles.monospace.size * 1.0;
        };

        gaps = {
          inner = 2;
          outer = 2;
          smartGaps = true;
          smartBorders = "no_gaps";
        };

        window = {
          border = 1;
          hideEdgeBorders = "smart";
          titlebar = false;
        };

        startup = [
          {
            command = "${pkgs.picom}/bin/picom";
            always = true;
            notification = false;
          }
          {
            command = "fetch-bing-wallpaper";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.blueman}/bin/blueman-applet";
            always = false;
            notification = false;
          }
          {
            command = "${pkgs.fcitx5}/bin/fcitx5";
            always = true;
            notification = false;
          }
          {
              command = "sleep 5 && ${pkgs.kdePackages.kdeconnect-kde}/bin/kdeconnect-indicator";
              always = true;
              notification = false;
          }
        ];

        workspaceOutputAssign = [
          # { workspace = "1"; output = "primary"; }
          # { workspace = "2"; output = "primary"; }
        ];

        keybindings = {
          "${mod}+Return" = "exec \"$(NO_TMUX=1 alacritty)\"";
          "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
          "${mod}+x" = "kill";
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+e" = "exit";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";
          "${mod}+r" = "mode resize";

          "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+s" = "layout stacking";
          "${mod}+t" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          "${mod}+m" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+a" = "focus parent";
          "${mod}+v" = "split v";
          "${mod}+b" = "split h";

          "${mod}+Shift+x" = "exec ${pkgs.betterlockscreen}/bin/betterlockscreen -l blur";
          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          # Keychron additional keys
          "Ctrl+F1" = "workspace number 1";
          "Ctrl+F2" = "workspace number 2";
          "Ctrl+F3" = "workspace number 3";
          "Ctrl+F4" = "workspace number 4";
          "Ctrl+F5" = "workspace number 5";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";
        };

        modes = {
          resize = {
            "h" = "resize shrink width 10 px or 10 ppt";
            "j" = "resize grow height 10 px or 10 ppt";
            "k" = "resize shrink height 10 px or 10 ppt";
            "l" = "resize grow width 10 px or 10 ppt";
            "Escape" = "mode default";
            "Return" = "mode default";
          };
        };

        colors = {
          focused = {
            border = "#88C0D0";
            background = "#2E3440";
            text = "#ECEFF4";
            indicator = "#81A1C1";
            childBorder = "#88C0D0";
          };
          focusedInactive = {
            border = "#5E81AC";
            background = "#3B4252";
            text = "#D8DEE9";
            indicator = "#5E81AC";
            childBorder = "#5E81AC";
          };
          unfocused = {
            border = "#4C566A";
            background = "#2E3440";
            text = "#D8DEE9";
            indicator = "#4C566A";
            childBorder = "#4C566A";
          };
          urgent = {
            border = "#BF616A";
            background = "#2E3440";
            text = "#ECEFF4";
            indicator = "#BF616A";
            childBorder = "#BF616A";
          };
          placeholder = {
            border = "#81A1C1";
            background = "#2E3440";
            text = "#ECEFF4";
            indicator = "#81A1C1";
            childBorder = "#81A1C1";
          };
          background = "#2E3440";
        };
      };
    extraConfig = ''
      for_window [urgent="latest" class="Brave"] focus
      for_window [urgent="latest" class="alacritty"] focus
      for_window [urgent="latest" class="Zed"] focus
    '';
  };
}
