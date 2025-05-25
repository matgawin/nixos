{pkgs, ...}: {
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        MANGOHUD = true;
      };
    };

    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;

    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };
}
