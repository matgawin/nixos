{
  pkgs,
  config,
  ...
}: {
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };
    script = '''';
    config = {
      "colors" = {
        dark_bg = "#2E3440";
        light_bg = "#3B4252";
        ligter_bg = "#434C5E";
        lightest_bg = "#4C566A";
        darkest_fg = "#D8DEE9";
        medium_fg = "#E5E9F0";
        light_fg = "#ECEFF4";
        teal = "#8FBCBB";
        light_blue = "#88C0D0";
        medium_blue = "#81A1C1";
        dark_blue = "#5E81AC";
        red = "#BF616A";
        orange = "#D08770";
        yellow = "#EBCB8B";
        green = "#A3BE8C";
        purple = "#B48EAD";
        transparent = "#FF00000";

        background = "\${colors.dark_bg}";
        background-alt = "$\{colors.light_bg}";
        foreground = "a\${colors.light_fg}";
        primary = "\${colors.light_blue}";
        secondary = "\${colors.medium_blue}";
        alert = "\${colors.red}";
        disabled = "$\{colors.lightest_bg}";
      };

      "bar/top" = let
        mono = config.fontProfiles.monospace;
      in {
        monitor = "\${env:MONITOR:}";
        width = "100%";
        height = "18pt";
        radius = 0;
        background = "\${colors.background}";
        foreground = "\${colors.foreground}";
        bottom = false;
        line-size = "6pt";
        border-color = "#00000000";
        padding-left = 1;
        padding-right = 1;
        module-margin = 1;
        separator = "|";
        separator-foreground = "\${colors.darkest_fg}";
        modules-left = "xworkspaces xwindow";
        modules-center = "date";
        modules-right = "pulseaudio tray xkeyboard memory cpu";
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
        enable-ipc = true;
        font-0 = "${mono.name}:size=${toString mono.size};2";
      };

      "module/xworkspaces" = {
        type = "internal/xworkspaces";
        label-active = "%name%";
        label-active-background = "\${colors.medium_blue}";
        label-active-foreground = "\${colors.darkest_fg}";
        label-active-padding = 1;
        label-occupied = "%name%";
        label-occupied-padding = 1;
        label-urgent = "%name%";
        label-urgent-background = "\${colors.alert}";
        label-urgent-padding = 1;
        label-empty = "%name%";
        label-empty-foreground = "\${colors.disabled}";
        label-empty-padding = 1;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:60:...%";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume-prefix = "VOL ";
        format-volume-prefix-foreground = "\${colors.primary}";
        format-volume = "<label-volume>";
        label-volume = "%percentage%%";
        label-muted = "muted";
        label-muted-foreground = "\${colors.disabled}";
      };

      "module/xkeyboard" = {
        type = "internal/xkeyboard";
        blacklist-0 = "num lock";
        label-layout = "%layout%";
        label-layout-foreground = "\${colors.primary}";
        label-indicator-padding = 2;
        label-indicator-margin = 1;
        label-indicator-foreground = "\${colors.background}";
        label-indicator-background = "\${colors.secondary}";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = "RAM ";
        format-prefix-foreground = "\${colors.primary}";
        label = "%percentage_used:2%%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = "CPU ";
        format-prefix-foreground = "\${colors.primary}";
        label = "%percentage:2%%";
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%Y-%m-%d %H:%M:%S";
        label = "%date%";
        label-foreground = "\${colors.primary}";
      };

      "module/tray" = {
        type = "internal/tray";
        tray-spacing = 10;
      };

      "settings" = {
        screenchange-reload = true;
        pseudo-transparency = true;
      };
    };
  };
}
