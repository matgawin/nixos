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
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "matt";
    homeDirectory = "/home/matt";
    packages = with pkgs; [
      polkit_gnome
    ] ++ lib.optional isX86_64Linux [
      brave
      bitwarden
      bitwarden-cli
      protonvpn-gui
      protonvpn-cli
      spotify
      qbittorrent
      telegram-desktop
      freetube
      thunderbird
      scrcpy
      virt-manager
      vale
      tmux
      tailscale
      fastfetch
      protonup-qt
      lutris
      wine64
      wireshark
      rustup
      broot
      neovim
      duf
      dust
      bottom
      cargo-binstall
      zed-editor
      eza
      atuin
      claude-code
      bun
      nodejs
      gimp
      nextdns
      sioyek
      podman
      podman-tui
      podman-desktop
      podman-compose
      distrobox
      vlc
      flameshot
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
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
      theme = "agnoster";
    };
  };

  programs.st = {
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

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
  programs.virt-manager.enable = true;

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "25.05";
}
