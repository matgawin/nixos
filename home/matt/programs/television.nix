{
  programs.television = {
    enable = true;

    enableZshIntegration = true;
    settings = {
      ui = {
        use_nerd_font_icons = true;
      };
      keybindings = {
        quit = ["esc" "ctrl-c"];
      };
    };
  };
}
