{pkgs, ...}: {
  services.dunst = {
    enable = true;
    package = pkgs.dunst;
    settings = {
      global = {
        follow = "mouse";
        width = "(111, 444)";
        height = "(0, 222)";
        origin = "top-right";
        offset = "(25, 50)";

        progress_bar_height = 5;
        progress_bar_min_width = 0;
        progress_bar_max_width = 444;
        progress_bar_frame_width = 0;

        transparency = 3;
        horizontal_padding = 11;
        frame_width = 1;
        frame_color = "#8aadf4";
        gap_size = 2;
        separator_color = "frame";
        idle_threshold = 120;
        highlight = "#8aadf4";

        font = "MesloLGS Nerd Font Mono 10";

        format = "<span size='x-large' font_desc='Cantarell,MesloLGS Nerd Font Mono 9' weight='bold' foreground='#f9f9f9'>%s</span>\n%b";

        show_age_threshold = 60;
        icon_position = "left";
        min_icon_size = 48;
        max_icon_size = 80;

        enable_recursive_icon_lookup = true;

        sticky_history = false;

        dmenu = "rofi -theme-str '@import \"action.rasi\"' -no-show-icons -no-lazy-grab -no-plugins -dmenu -mesg 'Context Menu'";

        browser = "brave";

        mouse_left_click = "close_current";
        mouse_middle_click = "context_all";
        mouse_right_click = "close_all";

        alignment = "center";
        markup = "full";
        always_run_script = true;

        corner_radius = 5;
      };

      urgency_low = {
        timeout = 3;
        background = "#24273a";
        foreground = "#cad3f5";
        highlight = "#8aadf4";
      };

      urgency_normal = {
        timeout = 6;
        background = "#24273a";
        foreground = "#cad3f5";
        highlight = "#8aadf4";
      };

      urgency_critical = {
        timeout = 0;
        background = "#24273a";
        foreground = "#cad3f5";
        highlight = "#8aadf4";
        frame_color = "#f5a97f";
      };
    };
  };
}
