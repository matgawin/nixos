{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    settings = {
      inactive-opacity = 0.98;
      active-opacity = 1;
      frame-opacity = 0.8;
      shadow = false;
      dbe = false;
    };
  };
}
