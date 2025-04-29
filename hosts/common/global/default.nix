{
  inputs,
  outputs,
  lib,
  ...
}:
{
  imports = [
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
  home-manager.backupFileExtension = ".home-manager-backup";

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
      allowUnfreePredicate = (_: true);
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
  };

  services.speechd.enable = lib.mkForce false;
}
