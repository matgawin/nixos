{ lib, pkgs, ... }:
let
  isX86_64Linux = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
in
{
  home.packages =
    with pkgs;
    [
      polkit_gnome
    ]
    ++ lib.optionals isX86_64Linux [
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
      st
    ];
}
