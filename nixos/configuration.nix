{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./nix.nix
    ./hardware.nix
    ./systemd.nix
    ./services.nix
    ./packages.nix
    ./fonts.nix

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

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
  };

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

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
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
    };
  };

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05";
}
