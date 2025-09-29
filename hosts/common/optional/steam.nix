{pkgs, ...}: {
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        MANGOHUD = true;
        GDK_BACKEND = "x11";
        QT_QPA_PLATFORM = "xcb";
        SDL_VIDEODRIVER = "x11";
        DISPLAY = ":0";
        _JAVA_AWT_WM_NONREPARENTING = "1";
      };
    };

    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;

    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };
}
