{pkgs, ...}: {
  home.packages = let
    player = "${pkgs.playerctl}/bin/playerctl";

    playerctl-status = pkgs.writeShellScriptBin "playerctl-status" ''
      #!${pkgs.bash}/bin/bash
      player_status="$(${player} status 2> /dev/null)"
      if [[ "$player_status" = "Playing" || "$player_status" = "Paused" ]]; then
          exit 0
      else
          exit 1
      fi
    '';
  in [
    playerctl-status
  ];
}
