{
  services = {
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+i3";
    };
    xserver = {
      windowManager.i3 = {
        enable = true;
      };
    };
  };
}
