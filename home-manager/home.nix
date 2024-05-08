{ inputs, outputs, lib, config, pkgs, ... }: 
let
  isX86_64Linux = pkgs.hostPlatform == "x86_64-linux";
in{
  imports = [
    # ./nvim.nix
  ];

  nixpkgs = {
    overlays = [
      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "matt";
    homeDirectory = "/home/matt";
    packages = with pkgs; [
      polkit_gnome
      vscode
      gcc
      tldr
    ] ++ lib.optional isX86_64Linux [
      brave
      remmina
      bitwarden
      bitwarden-cli
      protonmail-bridge
      protonvpn-gui
      protonvpn-cli
      spotify
      calibre
      qbittorrent
      telegram-desktop
      freetube
      steam
      thunderbird
      lynx
      keybase-gui
      tor-browser-bundle-bin
      scrcpy
      joplin-desktop
      virt-manager
      qemu
      vale
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    # configure = {
    #   packages.myVimPackage = with pkgs.vimPlugins; {
    #     start = [ LazyVim ];
    #   };
    # };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    shellAliases = {
      ls = "eza -lTah -L 1 --group-directories-first -F always";
      edit = "nvim";
      pf = "fzf --exact --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down";
      clip = "xclip -sel clip";
    };
    history = {
      ignoreDups = true;
      size = 100000;
      save = 100000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "zsh-fzf-tab" "zsh-autosuggestions" "z" "colored-man-pages" "git" "tmux" "docker" "node" "zsh-syntax-highlighting" ];
      # plugins = [ "z" "colored-man-pages" "git" "tmux" "docker" "node" ];
      theme = "agnoster";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
	opacity = 0.9;
	decorations = "none";
      };
      font = {
	size = 9;
      };
    };
  };

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName  = "Mateusz Gawin";
    userEmail = "matrix.gaw@gmail.com";
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.11";
}
