{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.continuum
      tmuxPlugins.resurrect
      tmuxPlugins.catppuccin
    ];
    extraConfig = ''

    '';
  };
}
