{ config, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    shellAliases = {
      edit = "nvim";
      pf = "fzf --exact --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down";
      clip = "xclip -sel clip";
      reload = "~/.zshrc";
    };
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
        "jj"
        "aliases"
      ];
      theme = "agnoster";
    };
  };
}
