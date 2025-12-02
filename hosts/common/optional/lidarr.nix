{
  pkgs,
  config,
  ...
}: let
  enableArr = true;
  enableJellyfin = true;
  enableCloudflared = false;
  enableNavidrome = false;
in {
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
    enable = enableArr;
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
    enable = enableArr;
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
    enable = enableArr;
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
    enable = enableArr;
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
  services.jellyseerr = {
    enable = false;
    port = 7676;
    openFirewall = false;
    configDir = "/var/lib/jellyseerr/config";
  };
  services.jellyfin = {
    enable = enableJellyfin;
    openFirewall = false;
    user = "matt";
    group = "users";
  };

  services.cloudflared = {
    enable = enableJellyfin && enableCloudflared;
    tunnels = {
      "jellyfin" = {
        certificateFile = config.sops.secrets.cloudflared_cert.path;
        credentialsFile = config.sops.secrets.cloudflared_jellyfin_credentials.path;
        default = "http_status:404";
        ingress = {
          "jellyfin.matgaw.in" = "http://localhost:8096";
        };
      };
    };
  };

  services.navidrome = {
    enable = enableNavidrome;
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
