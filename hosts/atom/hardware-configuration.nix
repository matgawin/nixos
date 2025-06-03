{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  boot.initrd.luks.devices = {
    "crypted" = {
      device = "/dev/disk/by-uuid/aabeb896-6235-48dd-815a-44271b1e014b";
      allowDiscards = true;
    };
    "storage-crypted" = {
      device = "/dev/disk/by-uuid/13cc4e51-63e8-4692-96cf-d8ce5c6053b5";
      allowDiscards = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/2562fc07-b9d1-4156-941e-766e4fbe46bc";
    fsType = "btrfs";
    options = ["subvol=root" "compress=zstd" "noatime" "discard=async"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8322-F400";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/2562fc07-b9d1-4156-941e-766e4fbe46bc";
    fsType = "btrfs";
    options = ["subvol=home" "compress=zstd" "noatime" "discard=async"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/2562fc07-b9d1-4156-941e-766e4fbe46bc";
    fsType = "btrfs";
    options = ["subvol=nix" "compress=zstd" "noatime" "discard=async"];
  };

  fileSystems."/storage/quark" = {
    device = "/dev/disk/by-uuid/76ac3b24-3104-487f-af12-d5054e3b8fff";
    fsType = "btrfs";
    options = ["compress=zstd" "noatime" "discard=async" "nofail"];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16384; # Size in MB (16GB)
    }
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 5;
  };

  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp87s0.useDHCP = lib.mkDefault true;
  networking.interfaces.enp88s0.useDHCP = lib.mkDefault true;
  networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
  networking.interfaces.wlp89s0f0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
