{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ./hardware.nix

    ../common/global
    ../common/users/matt

    ../common/optional/i3.nix
    ../common/optional/kwallet.nix
    ../common/optional/nh.nix
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
      extraStructuredConfig = with lib.kernel; {
        ACPI_DEBUG = yes;
      };
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

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "gtk";
  };

  console = {
    keyMap = "pl2";
    font = "ter-powerline-v16b";
    packages = [pkgs.powerline-fonts];
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
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

  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  system.stateVersion = "25.05";
}
