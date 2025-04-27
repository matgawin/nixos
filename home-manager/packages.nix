{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (st.overrideAttrs (oldAttrs: {
      src = pkgs.fetchgit {
        url = "https://github.com/siduck/st.git";
        rev = "refs/heads/main";
        sha256 = "sha256-wohkmDsm26kqFGQKuY6NuBQsifT7nZNgrLqLFsU+Vog=";
      };
      buildInputs = oldAttrs.buildInputs ++ [
        glib
        harfbuzz
        gd
      ];
    }))
    polkit_gnome
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
    duf
    dust
    bottom
    cargo-binstall
    zed-editor
    eza
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
    nixd
    nil
    nixfmt-rfc-style
  ];
}
