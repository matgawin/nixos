{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      inline_height = 20;
      keymap_mode = "vim-normal";
      dotfiles.enabled = true;
    };
  };
}
