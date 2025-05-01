{pkgs, ...}: {
  imports = [
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

  home.packages = with pkgs; [
    (st.overrideAttrs (oldAttrs: {
      src = pkgs.fetchgit {
        url = "https://github.com/siduck/st.git";
        rev = "refs/heads/main";
        sha256 = "sha256-wohkmDsm26kqFGQKuY6NuBQsifT7nZNgrLqLFsU+Vog=";
      };
      buildInputs =
        oldAttrs.buildInputs
        ++ [
          glib
          harfbuzz
          gd
        ];
    }))
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
    eza
    easyeffects
    fastfetch
    flameshot
    freerdp
    freetube
    gimp
    hurl
    hyperfine
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
    veracrypt
    virt-manager
    vlc
    vscode
    wine64
    wireshark
  ];
}
