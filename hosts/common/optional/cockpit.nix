{lib, ...}: {
  services.cockpit = {
    enable = true;
    openFirewall = false;
    port = 9191;
    settings = {
      WebService = {
        LoginTo = false;
        AllowUnencrypted = true;
        Origins = lib.mkForce "http://localhost:9191";
      };
    };
  };
}
