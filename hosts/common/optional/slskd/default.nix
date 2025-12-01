{
  config,
  pkgs,
  ...
}: let
  wrappers = import ./wrappers.nix {inherit pkgs;};
  inherit (wrappers) slskdWrapper slskdRestartWrapper updatePortSet;
in {
  networking.firewall.extraCommands = ''
    ${pkgs.ipset}/bin/ipset create slskd-ports bitmap:port range 1024-65535 2>/dev/null || true
    ${pkgs.iptables}/bin/iptables -A nixos-fw -p tcp -m set --match-set slskd-ports dst -j nixos-fw-accept 2>/dev/null || true
  '';

  networking.firewall.extraStopCommands = ''
    ${pkgs.ipset}/bin/ipset destroy slskd-ports 2>/dev/null || true
  '';

  systemd.services.slskd = {
    description = "slskd - A modern client-server application for the Soulseek file sharing network";
    after = ["network.target" "firewall.service" "slskd-update-port.service"];
    requires = ["slskd-update-port.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "simple";
      User = "matt";
      Group = "users";

      IPAddressAllow = ["localhost" "10.0.0.0/8" "192.168.0.0/16"];

      Environment = ["DOTNET_USE_POLLING_FILE_WATCHER=1"];
      EnvironmentFile = config.sops.secrets.slskd-env.path;

      StateDirectory = "slskd";
      StateDirectoryMode = "0750";

      ExecStart = "${slskdWrapper}";

      Restart = "always";
      RestartSec = "60s";
      StartLimitBurst = 0;

      ReadOnlyPaths = ["/storage/quark/Media"];
      ReadWritePaths = [
        "/storage/quark/Downloads"
        "/storage/quark/Downloads/incomplete"
      ];

      LockPersonality = true;
      NoNewPrivileges = true;
      PrivateDevices = true;
      PrivateMounts = true;
      PrivateTmp = true;
      PrivateUsers = true;
      ProtectClock = true;
      ProtectControlGroups = true;
      ProtectHome = "read-only";
      ProtectHostname = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectProc = "invisible";
      ProtectSystem = "strict";
      RemoveIPC = true;
      RestrictNamespaces = true;
      RestrictSUIDSGID = true;
    };
  };

  systemd.paths.slskd-port-watcher = {
    description = "Watch ProtonVPN port file for changes";
    wantedBy = ["multi-user.target"];
    pathConfig = {
      PathModified = "/run/user/1000/Proton/VPN/forwarded_port";
      Unit = "slskd-restart.service";
    };
  };

  systemd.services.slskd-update-port = {
    description = "Update slskd firewall port";
    after = ["firewall.service"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${updatePortSet}";
    };
  };

  systemd.services.slskd-restart = {
    description = "Restart slskd when ProtonVPN port changes";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${slskdRestartWrapper}";
    };
  };
}
