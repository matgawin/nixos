{
  config,
  pkgs,
  ...
}: let
  font = "${config.fontProfiles.monospace.name} ${toString config.fontProfiles.monospace.size}";
in {
  programs.rofi = {
    enable = true;
    theme = ./style.rasi;
    font = font;
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };
}
