{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs.kdePackages; [
    kwalletmanager
    kwallet
    kwallet-pam
  ];

  security.pam.services = {
    login.enableKwallet = true;
    sddm.enableKwallet = lib.mkIf (config.services.xserver.displayManager.sddm.enable or false) true;
    i3lock.enableKwallet = true;
  };
}
