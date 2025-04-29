{ config, lib, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    defaultKeymap = "viins";
    history = {
      ignoreDups = true;
      size = 100000;
      save = 100000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "z"
        "colored-man-pages"
        "git"
        "tmux"
        "docker"
        "node"
        "aliases"
      ];
      theme = "agnoster";
    };
    initContent = lib.mkOrder 2100 ''
      alias -g edit=nvim
      alias -g pf="fzf --exact --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"
      alias -g clip="xclip -sel clip"
      alias -g reload="source ~/.zshrc"
      alias -g br=broot
      export EDITOR=nvim
      export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'

      COMPLETION_WAITING_DOTS="true"
      HIST_STAMPS="dd/mm/yyyy"

      if [[ "''\${NO_TMUX}" != "1" ]]; then
          # If not running interactively, do not do anything
          # [[ $- != *i* ]] && return
          # Otherwise start tmux
          [[ -z "$TMUX" ]] && tmux
      fi
    '';
  };
}
