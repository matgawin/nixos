{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./atuin.nix
    ./broot.nix
    ./easyeffects.nix
    ./flameshot.nix
    ./gammastep.nix
    ./git.nix
    ./glance.nix
    ./jj.nix
    ./kdeconnect.nix
    ./playerctl.nix
    ./syncthing.nix
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
    bottom
    brave
    bun
    cargo-binstall
    claude-code
    distrobox
    duf
    dust
    eza
    fastfetch
    freerdp
    freetube
    gimp
    hurl
    hyperfine
    keepassxc
    lazygit
    libsecret
    lutris
    nil
    nixd
    nodejs
    pavucontrol
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
