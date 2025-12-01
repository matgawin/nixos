{pkgs, ...}: let
  yamlFormat = pkgs.formats.yaml {};
in
  yamlFormat.generate "slskd.yml" {
    web = {
      port = 5030;
      host = "0.0.0.0";
      url_base = "/";
      https = {
        disabled = true;
      };
      logging = false;
    };

    soulseek = {
      listen_ip_address = "10.2.0.2";
      description = ''
        A slskd user. https://github.com/slskd/slskd
        Leechers are capped at 1 file at a time and 100 kb/s.
      '';
      diagnostic_level = "Info";
    };

    shares = {
      directories = [
        "/storage/quark/Media"
      ];
      cache = {
        storage_mode = "memory";
        workers = 16;
      };
    };

    directories = {
      downloads = "/storage/quark/Downloads";
      incomplete = "/storage/quark/Downloads/incomplete";
    };

    global = {
      upload = {
        slots = 4;
        speed_limit = 2147483647;
      };
      download = {
        slots = 500;
        speed_limit = 2147483647;
      };
    };

    groups = {
      default = {
        upload = {
          priority = 500;
          strategy = "roundrobin";
          slots = 10;
        };
      };
      leechers = {
        thresholds = {
          files = 1;
          directories = 1;
        };
        upload = {
          priority = 999;
          strategy = "roundrobin";
          slots = 1;
          speed_limit = 100;
        };
        limits = {
          queued = {
            files = 15;
            megabytes = 150;
          };
          daily = {
            files = 30;
            megabytes = 300;
            failures = 10;
          };
          weekly = {
            files = 150;
            megabytes = 1500;
            failures = 30;
          };
        };
      };
    };

    retention = {
      transfers = {
        upload = {
          succeeded = 1440;
          errored = 30;
          cancelled = 5;
        };
        download = {
          succeeded = 1440;
          errored = 20160;
          cancelled = 5;
        };
      };
      files = {
        complete = 20160;
        incomplete = 43200;
      };
    };

    logger = {
      disk = false;
      no_color = false;
    };

    flags = {
      no_version_check = true;
    };

    remote_configuration = false;
    remote_file_management = false;
  }
