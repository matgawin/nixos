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
        # Alt arrow to switch panes
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # Shift arrow to switch windows
        bind -n S-Left  previous-window
        bind -n S-Right next-window

        set-option -sa terminal-features ',xterm-246color:RGB'
        set-option -sa terminal-overrides ",screen-256color:RGB"
        set -g default-terminal 'screen-256color'

        # Start windows and panes at 1, not 0
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        # quickly open a new window
        bind N new-window

        setw -g monitor-activity on
        set -g visual-activity on
        setw -g mode-keys vi

        # set-window-option -g window-status-current-style bg=yellow
        set -g mouse on

        set -g @catppuccin_flavour 'mocha'

        set -g @continuum-restore 'on'

        set-hook -g after-new-session '
          selectp -t 0
          send-keys -t 0 "fortune | cowsay -W 80 -s" ENTER
        '
    '';
  };
}
