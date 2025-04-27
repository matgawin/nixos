{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):

      # (final: prev: {
      #   dwm = prev.dwm.overrideAttrs (old: { src = /home/matt/dwm ;});
      # })
      # (final: prev: {
      #   slstatus = prev.slstatus.overrideAttrs (old: { src = /home/matt/slstatus ;});
      # })
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    gc.automatic = true;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  boot = {
    kernelModules = [ "i915" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelPatches = lib.singleton {
      name = "config";
      patch = null;
      extraStructuredConfig = with lib.kernel; {
        ACPI_DEBUG = yes;
      };
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware.firmware = [
    (
      let
        model = "37xx";
        version = "0.0";

        firmware = pkgs.fetchurl {
          url = "https://github.com/intel/linux-npu-driver/raw/v1.16.0/firmware/bin/vpu_${model}_v${version}.bin";
          hash = "sha256-DInj6Ee+NXdDjamngUda5KUg4jePtxXenqxD5rwnU/s=";
        };
      in
      pkgs.runCommand "intel-vpu-firmware-${model}-${version}" { } ''
        mkdir -p "$out/lib/firmware/intel/vpu"
        cp '${firmware}' "$out/lib/firmware/intel/vpu/vpu_${model}_v${version}.bin"
      ''
    )
  ];

  hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # vpl-gpu-rt
      libvdpau-va-gl
      intel-media-driver
      intel-compute-runtime
      vaapiIntel
      vaapiVdpau
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
  };

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

  services = {
    getty.greetingLine = "";
    getty.helpLine = lib.mkForce ''<<< \l >>>'';
    xserver.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    flatpak.enable = true;
    xserver = {
      xkb = {
        variant = "";
        layout = "pl";
      };
    };
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xrdp.enable = true;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };
  };

  # services.xserver.windowManager.dwm.enable = true;
  # services.xserver.desktopManager.session = [
  #   {
  #     name = "xsession";
  #     start = ''
  #       slstatus &
  #     '';
  #   }
  # ];

  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Meslo LG M Regular Nerd Font Complete Mono"];
        serif = ["Noto Serif" "Source Han Serif"];
        sansSerif = ["Noto Sans" "Source Han Sans"];
      };
    };
    fontDir.enable = true;
  };

  # Configure console keymap
  console.keyMap = "pl2";

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    groups.libvirtd.members = [ "matt" ];
    users = {
      matt = {
        initialPassword = "pass";
        isNormalUser = true;
        description = "Matt";
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = [
          # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
        ];
        extraGroups = [ "networkmanager" "wheel" ];
      };
    };
  };

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # slstatus
    zsh
    gcc
    xfce.thunar
    unzip
    ack
    gawk
    curl
    fzf
    fd
    ripgrep
    firefox
    wget
    git
    xclip
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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

  system.stateVersion = "25.05";
}
