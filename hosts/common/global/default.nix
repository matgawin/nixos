{
  inputs,
  outputs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./packages.nix
    ./nix.nix
    ./locale.nix
    ./systemd.nix
    ./services.nix
    ./fonts.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };
  home-manager.backupFileExtension = "home-manager-backup";

  nixpkgs = {
    overlays = [
      # (final: prev: {
      #   dwm = prev.dwm.overrideAttrs (old: { src = /home/matt/dwm ;});
      # })
      # (final: prev: {
      #   slstatus = prev.slstatus.overrideAttrs (old: { src = /home/matt/slstatus ;});
      # })
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  networking.firewall = {
    enable = true;
    # ports for kde connect
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    trustedInterfaces = ["tailscale0"];
    checkReversePath = "loose";
    # Allow SSH and XRDP
    allowedTCPPorts = [22 3389];
    allowPing = true;
    logReversePathDrops = true;
  };

  services.speechd.enable = lib.mkForce false;
}
