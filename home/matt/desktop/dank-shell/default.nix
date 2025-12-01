{...}: let
  defaults = builtins.fromJSON (builtins.readFile ./defaults.json);
in {
  programs = {
    dankMaterialShell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      default.settings = defaults;
      enableSystemMonitoring = true;
      enableClipboard = true;
      enableBrightnessControl = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
      enableSystemSound = true;
    };
  };
}
