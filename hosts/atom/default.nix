{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ./hardware.nix
    ./btrbk.nix

    ../common/global
    ../common/users/matt
    ../common/optional/slskd

    ../common/optional/borgbackup.nix
    ../common/optional/cockpit.nix
    ../common/optional/gamemode.nix
    ../common/optional/kwallet.nix
    ../common/optional/lidarr.nix
    ../common/optional/nh.nix
    ../common/optional/niri.nix
    ../common/optional/nix-ld.nix
    ../common/optional/thunar.nix
    ../common/optional/steam.nix
  ];

  networking = {
    hostName = "atom";
    networkmanager.enable = true;
  };

  boot = {
    kernelModules = ["i915"];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelPatches = lib.singleton {
      name = "config";
      patch = null;
      structuredExtraConfig = with lib.kernel; {
        ACPI_DEBUG = yes;
      };
    };
    kernel.sysctl = {
      "net.ipv4.ip_unprivileged_port_start" = 0;
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    plymouth = {
      enable = true;
      theme = "cuts_alt";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["cuts_alt"];
        })
      ];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
  };

  console = {
    keyMap = "pl2";
    font = "ter-powerline-v16b";
    packages = [pkgs.powerline-fonts];
  };

  security = {
    rtkit.enable = true;
    polkit.enable = lib.mkDefault false;
  };
  security.pam.services = {
    i3lock = {
      enable = true;
      text = ''
        auth    include login
        account include login
        session include login
      '';
    };
  };

  programs.adb.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  sops.templates."hetzner-ssh-config" = {
    content = ''
      Host hetzner
        HostName ${config.sops.placeholder."hetzner/hostname"}
        Port ${config.sops.placeholder."hetzner/port"}
        User ${config.sops.placeholder."hetzner/username"}
        ServerAliveInterval 60
        ServerAliveCountMax 2
        IdentityFile /root/.ssh/id_rsa_hetzner
    '';
    owner = "root";
    group = "root";
    mode = "0400";
  };

  programs.ssh = {
    knownHosts = {
      "hetzner" = {
        hostNames = [config.sops.placeholder."hetzner/hostname"];
        publicKey = config.sops.secrets."hetzner/ssh_public_key".path;
      };
    };
  };

  system.activationScripts.rootSshConfig = ''
    mkdir -p /root/.ssh
    cat > /root/.ssh/config << 'EOF'
        Include ${config.sops.templates."hetzner-ssh-config".path}
    EOF
    chmod 400 /root/.ssh/config
    chown root:root /root/.ssh/config
  '';

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    docker = {
      storageDriver = "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  system.stateVersion = "25.05";
}
