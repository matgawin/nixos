{ pkgs, ... }:
{
  imports = [
    ./atuin.nix
    ./git.nix
    ./neovim.nix
    ./tmux.nix
    ./zed.nix
    ./zoxide.nix
    ./zsh.nix
  ];

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
    bitwarden
    bitwarden-cli
    bottom
    brave
    broot
    bun
    cargo-binstall
    claude-code
    distrobox
    duf
    dust
    eza
    fastfetch
    flameshot
    freetube
    gimp
    lazygit
    lutris
    nextdns
    nil
    nixd
    nixfmt-rfc-style
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
    tailscale
    telegram-desktop
    thunderbird
    vale
    virt-manager
    vlc
    wine64
    wireshark
  ];
}
