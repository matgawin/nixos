{ inputs, outputs, lib, config, pkgs, ... }: 
let
  fetchBranch = user-repo: branch: builtins.fetchTarball {
    url = "https://api.github.com/repos/${user-repo}/tarball/${branch}";
    sha256 = "1qmiz656ggl7xnrfggvvbs9wgay9l2lr876x622krx4s8x088w2v";
  };
  fetchMaster = user-repo: fetchBranch user-repo "main";
in {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "aarch64-linux";
    overlays = [
      (final: prev: {
        dwm = prev.dwm.overrideAttrs (old: {
          src = /home/matt/Projects/dwm-titus;
	  # src = builtins.fetchGit {
          #   url = "https://github.com/ChrisTitusTech/dwm-titus.git";
          #   ref = "main";
	  #   rev = "4ffe7f7af6282f540e488febacb153aa2edf1903";
          # };
	  # installPhase = ''
	  #     make PREFIX=$out install
	  #     # If dwm-titus needs to be installed to /usr/share/xsessions/
	  #     install -Dm644 $src/dwm.desktop $out/share/xsessions/dwm.desktop
	  # '';
        });
      })
      # (final: prev: {
      #   slstatus = prev.slstatus.overrideAttrs (old: { src = /home/matt/slstatus ;});
      # })
    ];
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override {fonts = ["Meslo"];})
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Meslo LG M Regular Nerd Font Complete Mono"];
        serif = ["Noto Serif" "Source Han Serif"];
        sansSerif = ["Noto Sans" "Source Han Sans"];
      };
    };
  };
  
  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;
  networking.hostName = "nix";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  services.getty.greetingLine = "";
  services.getty.helpLine = lib.mkForce ''<<< \l >>>'';

  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  services.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.session = [
  #   {
  #     name = "xsession";
  #     start = ''
  #       slstatus &
  #     '';
  #   }
  # ];

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "pl";
    xkb.variant = "";
  };

  console.keyMap = "pl2";
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  users.users = {
    matt = {
      initialPassword = "pass";
      isNormalUser = true;
      description = "Matt";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  services.xrdp = {
    enable = true;
    defaultWindowManager = "dwm";
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    tmux
    xfce.thunar
    neofetch
    unzip
    ack
    gawk
    curl
    eza
    fzf
    fd
    gimp
    nextdns
    firefox
    wget
    git
    sioyek
    vlc
    xclip
    solaar
    flameshot
    dmenu
  ];

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # xdg.portal = {
  #   enable = true;
  #   config.common.default = "*";
  #   extraPortals = [pkgs.xdg-desktop-portal-gtk];
  # };

  security.polkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  system.stateVersion = "23.11";
}
