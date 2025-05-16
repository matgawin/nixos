{pkgs, ...}: {
  home.packages = let
    polybar = "${pkgs.polybar}/bin/polybar";

    polybar-multi-monitor = pkgs.writeShellScriptBin "polybar-multi-monitor" ''
      #!${pkgs.bash}/bin/bash
      for m in $(${polybar} --list-monitors | cut -d":" -f1); do
          MONITOR=$m ${polybar} -l error -r top &
      done
    '';
  in [
    polybar-multi-monitor
  ];
}
