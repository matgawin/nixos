{pkgs, ...}: {
  home.packages = let
    player = "${pkgs.playerctl}/bin/playerctl";
    polybar-music-info = pkgs.writeShellScriptBin "polybar-music-info" ''
      #!${pkgs.bash}/bin/bash
      player_status="$(${player} status 2> /dev/null)"
      if [[ "$player_status" = "Playing" || "$player_status" = "Paused" ]]; then
          echo "$(${player} metadata artist) - $(${player} metadata title)"
      else
          echo ""
      fi
    '';
  in [
    polybar-music-info
  ];
}
