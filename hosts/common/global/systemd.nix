{pkgs, ...}: {
  systemd = {
    # user.services.polkit-gnome-authentication-agent-1 = {
    #   description = "polkit-gnome-authentication-agent-1";
    #   wantedBy = ["graphical-session.target"];
    #   wants = ["graphical-session.target"];
    #   after = ["graphical-session.target"];
    #   serviceConfig = {
    #     Type = "simple";
    #     ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    #     Restart = "on-failure";
    #     RestartSec = 1;
    #     TimeoutStopSec = 10;
    #   };
    # };

    # user.services.gnome-keyring-daemon.enable = false;
    # user.services.gnome-keyring-daemon.wantedBy = pkgs.lib.mkForce [ ];
    # user.services.kwallet.enable = false;
    # user.services.kwallet.wantedBy = pkgs.lib.mkForce [ ];
    # services.gnome-keyring-daemon.enable = false;
    # services.kwallet.enable = false;

    slices.anti-hungry.sliceConfig = {
      CPUAccounting = true;
      CPUQuota = "75%";
      MemoryAccounting = true;
      MemoryHigh = "50%";
      MemoryMax = "75%";
    };

    services.dbus.enable = true;
    services."trigger-lockscreen@matt" = {
      description = "Lock screen when going to sleep/suspend";
      before = ["sleep.target" "suspend.target"];
      wantedBy = ["sleep.target" "suspend.target"];
      serviceConfig = {
        Type = "simple";
        User = "matt";
        ExecStart = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock";
        TimeoutSec = "infinity";
        Environment = "DISPLAY=:0";
      };
    };
    services = {
      nix-daemon.serviceConfig.Slice = "anti-hungry.slice";
      nixos-upgrade.serviceConfig.Slice = "anti-hungry.slice";
    };
  };
}