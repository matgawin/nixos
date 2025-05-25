{pkgs, ...}: {
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";

      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    # user.services.gnome-keyring-daemon.enable = false;
    # user.services.gnome-keyring-daemon.wantedBy = pkgs.lib.mkForce [ ];
    # user.services.kwallet.enable = false;
    # user.services.kwallet.wantedBy = pkgs.lib.mkForce [ ];
    # services.gnome-keyring-daemon.enable = false;

    services.dbus.enable = true;

    services = {
      nix-daemon.serviceConfig = {
        MemoryHigh = "75%";
        MemoryMax = "85%";
      };
    };
  };
}
