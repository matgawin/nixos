{
  config,
  lib,
  pkgs,
  ...
}: {
  services.jackett = {
    enable = false;
    port = 9117;
    openFirewall = false;
    user = "matt";
    group = "users";
  };
  services.nzbget = {
    enable = false;
    user = "matt";
    group = "users";
    settings = {
      MainDir = "/home/matt/Downloads/nzbget";
    };
  };
  services.prowlarr = {
    enable = true;
    openFirewall = false;
    settings = {
      server = {
        urlbase = "localhost";
        port = 8787;
        bindaddress = "*";
      };
    };
  };
  services.lidarr = {
    enable = true;
    openFirewall = false;
    user = "matt";
    group = "users";
    settings = {
      server = {
        urlbase = "localhost";
        port = 8686;
        bindaddress = "*";
      };
    };
  };
  services.radarr = {
    enable = true;
    openFirewall = false;
    user = "matt";
    group = "users";
    settings = {
      server = {
        urlbase = "localhost";
        port = 7878;
        bindaddress = "*";
      };
    };
  };
  services.sonarr = {
    enable = true;
    openFirewall = false;
    user = "matt";
    group = "users";
    settings = {
      server = {
        urlbase = "localhost";
        port = 7979;
        bindaddress = "*";
      };
    };
  };
  services.jellyfin = {
    enable = false;
    openFirewall = true;
    user = "matt";
    group = "users";
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
  services.navidrome = {
    enable = false;
    openFirewall = true;
    user = "matt";
    group = "users";
    settings = {
      Address = "0.0.0.0";
      Port = 4533;
      MusicFolder = "/storage/quark/Media/Music";
    };
  };
}
