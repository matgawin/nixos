{pkgs, ...}: {
  home.packages = with pkgs; [
    caffeine-ng
  ];
  systemd.user.services.caffeine = {
    Unit = {
      Description = "Caffeine inhibits automatic suspend";
      PartOf = ["graphical-session.target"];
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.caffeine-ng}/bin/caffeine";
      Restart = "on-failure";
      RestartSec = "5s";
      Type = "exec";
      Slice = "session.slice";
    };
  };
}
