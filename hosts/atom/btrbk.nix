{pkgs, ...}: {
  services.btrbk = {
    extraPackages = with pkgs; [
      btrbk
      btrfs-progs
      zstd
    ];
    instances = {
      "home" = {
        onCalendar = "Mon,Wed,Sat 00:00";

        settings = {
          timestamp_format = "long";
          stream_compress = "zstd";

          snapshot_preserve = "8d";
          snapshot_preserve_min = "4d";
          target_preserve = "8d";
          target_preserve_min = "4d";

          volume = {
            "/" = {
              subvolume = "home";
              target = "/storage/quark/Snapshots";
              snapshot_dir = "/var/btrbk_snapshots";
            };
          };
        };
      };
    };
  };
  systemd.tmpfiles.rules = [
    "d /storage/quark/Snapshots 0755 root root -"
    "d /var/btrbk_snapshots 0755 root root -"
  ];
}
