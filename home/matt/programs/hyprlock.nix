{pkgs, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };
      background = [
        {
          path = "$HOME/.wallpapers/bing-wallpaper.jpg";
          blur_passes = 1;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "300, 40";
          # position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgba(91, 96, 120, 0.2)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 1;
          placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
          shadow_passes = 1;
          rounding = 0;
        }
      ];

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$TIME"'';
          color = "rgba(200, 200, 200, 0.8)";
          font_size = 55;
          font_family = "Fira Semibold";
          position = "0, 15";
          halign = "left";
          valign = "bottom";
        }
        {
          monitor = "";
          text = ''cmd[update:43200000] echo "$(date +"%A, %B %d")"'';
          color = "rgba(200, 200, 200, 0.8)";
          font_size = 12;
          font_family = "Fira Semibold";
          position = "5, 5";
          halign = "left";
          valign = "bottom";
        }
      ];
    };
  };

  home.packages = let
    wallpaper = "$HOME/.wallpapers/bing-wallpaper.jpg";
    lock-screen = pkgs.writeShellScriptBin "lock-screen" ''
      #!/usr/bin/env bash
      if [ ! -f "${wallpaper}" ]; then
        fetch-bing-wallpaper
      fi
      ${pkgs.hyprlock}/bin/hyprlock
    '';

    lock-and-suspend = pkgs.writeShellScriptBin "lock-and-suspend" ''
      #!/usr/bin/env bash
      if [ ! -f "${wallpaper}" ]; then
        fetch-bing-wallpaper
      fi
      ${pkgs.hyprlock}/bin/hyprlock &
      sleep 1
      systemctl suspend
    '';
  in [
    lock-screen
    lock-and-suspend
  ];
}
