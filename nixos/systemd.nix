{ pkgs, ... }:
{
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    slices.anti-hungry.sliceConfig = {
      CPUAccounting = true;
      CPUQuota = "75%";
      MemoryAccounting = true;
      MemoryHigh = "50%";
      MemoryMax = "75%";
    };
    services = {
      nix-daemon.serviceConfig.Slice = "anti-hungry.slice";
      nixos-upgrade.serviceConfig.Slice = "anti-hungry.slice";
    };
  };
}
