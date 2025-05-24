{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./atuin.nix
    ./broot.nix
    ./cj.nix
    ./direnv.nix
    ./easyeffects.nix
    ./espanso.nix
    ./flameshot.nix
    ./gammastep.nix
    ./git.nix
    ./glance.nix
    ./jj.nix
    ./kdeconnect.nix
    ./nm-applet.nix
    ./playerctl.nix
    ./syncthing.nix
    ./television.nix
    ./tmux.nix
    ./visidata.nix
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
    bat
    btop
    brave
    bun
    cargo-binstall
    claude-code
    distrobox
    duf
    dust
    eza
    fastfetch
    fd
    freerdp
    freetube
    gimp
    hurl
    hyperfine
    inotify-tools
    jq
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
    ripgrep
    rustup
    scrcpy
    simple-scan
    sioyek
    spotify
    streamlink
    telegram-desktop
    thunderbird
    veracrypt
    virt-manager
    vlc
    vscode
    wine64
    wireshark
  ];
}
