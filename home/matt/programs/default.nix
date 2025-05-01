{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./atuin.nix
    ./broot.nix
    ./git.nix
    ./jj.nix
    ./tmux.nix
    ./zoxide.nix
    ./zsh.nix

    ./neovim
    ./zed
  ];

  programs = {
    home-manager.enable = true;
  };

  home.packages = with pkgs; [
    alejandra
    bitwarden
    bitwarden-cli
    bottom
    brave
    bun
    cargo-binstall
    claude-code
    distrobox
    duf
    dust
    easyeffects
    eza
    fastfetch
    flameshot
    freerdp
    freetube
    gimp
    hurl
    hyperfine
    lazygit
    lutris
    nil
    nixd
    nodejs
    podman
    podman-compose
    podman-desktop
    podman-tui
    polkit_gnome
    protonup-qt
    protonvpn-cli
    protonvpn-gui
    qbittorrent
    rustup
    scrcpy
    sioyek
    spotify
    st
    telegram-desktop
    thunderbird
    vale
    veracrypt
    virt-manager
    vscode
    wine64
    wireshark
  ];
}
