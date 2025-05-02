{
  imports = [
    ./sddm.nix
  ];
  services = {
    xserver = {
      windowManager.i3 = {
        enable = true;
      };
    };
  };
}
