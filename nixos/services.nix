{ lib, ... }:
{
  services = {
    getty = {
      greetingLine = "";
      helpLine = lib.mkForce ''<<< \l >>>'';
    };
    # displayManager.sddm.enable = true;
    # desktopManager.plasma6.enable = true;
    flatpak.enable = true;
    xserver = {
      enable = true;
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

}
