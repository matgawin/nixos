# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "matt";
    homeDirectory = "/home/matt";
    packages = with pkgs; [
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
      thunderbird
      lutris
      steam
      lynx
      keybase-gui
      scrcpy
      joplin-desktop
      vale
      vscode
      tor-browser-bundle-bin
      qemu
      virt-manager
      gcc
      tldr
    ];
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

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
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    shellAliases = {
      ls = "eza -lTFah -L 1 --group-directories-first";
      edit = "nvim";
      vi = "nvim";
      vim = "nvim";
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
      # plugins = [ "zsh-fzf-tab" "zsh-autosuggestions" "z" "colored-man-pages" "git" "tmux" "docker" "node" "zsh-syntax-highlighting" ];
      plugins = [ "z" "colored-man-pages" "git" "tmux" "docker" "node" ];
      theme = "agnoster";
    };
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName  = "Mateusz Gawin";
    userEmail = "matrix.gaw@gmail.com";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
