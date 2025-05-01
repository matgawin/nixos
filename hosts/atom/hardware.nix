{pkgs, ...}: {
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
        pkgs.runCommand "intel-vpu-firmware-${model}-${version}" {} ''
          mkdir -p "$out/lib/firmware/intel/vpu"
          cp '${firmware}' "$out/lib/firmware/intel/vpu/vpu_${model}_v${version}.bin"
        ''
    )
  ];

  hardware.enableRedistributableFirmware = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
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
}
