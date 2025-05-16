{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    activeOpacity = 1.0;
    inactiveOpacity = 0.98;
    opacityRules = [
      "100:fullscreen"
      "100:name *= 'FreeTube'"
    ];
    shadow = false;
    settings = {
      dbe = false;
    };
  };
}
