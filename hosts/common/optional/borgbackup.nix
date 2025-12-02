{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    borgbackup
  ];

  services.borgbackup.jobs = {
    "hetzner-backup" = {
      repo = "ssh://hetzner/./backups/atom";

      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat ${config.sops.secrets."borgbackup/passphrase".path}";
      };

      paths = [
        "/storage/quark/Snapshots"
        "/storage/quark/Pixel6a/seed_vault"
      ];

      exclude = [
        "*.tmp"
        "*/.cache"
        "*/cache"
        "*/Cache"
        "*/node_modules"
        "*/.npm"
        "*/.cargo"
        "*/.cargo-*"
      ];

      startAt = [
        "Tue 20:00"
        "Fri 20:00"
      ];

      compression = "zstd,3";

      prune.keep = {
        daily = 7;
        weekly = 4;
        monthly = 6;
        yearly = 2;
      };

      extraCreateArgs = [
        "--stats"
        "--progress"
        "--checkpoint-interval"
        "1800" # Checkpoint every 30 minutes
        "--filter"
        "AME"
      ];
    };
  };
}
