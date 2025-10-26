{pkgs, ...}: let
  atuin-desktop = import ./desktop.nix {inherit pkgs;};
in {
  home.packages = [
    atuin-desktop
  ];
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      inline_height = 20;
      keymap_mode = "vim-normal";
      enter_accept = true;
      style = "compact";
      history_filter = [
        "^fortune"
        "^cowsay"
      ];
    };
  };
}
