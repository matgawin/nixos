{pkgs, ...}: {
  home.packages = let
    killConfirm = pkgs.writeShellScriptBin "kill-with-confirm" ''
      timestamp_file="/tmp/kill-confirm-timestamp-$USER"
      current_time=$(${pkgs.coreutils}/bin/date +%s%3N)

      if [[ -f "$timestamp_file" ]]; then
        last_time=$(${pkgs.coreutils}/bin/cat "$timestamp_file" 2>/dev/null || echo "0")
        time_diff=$((current_time - last_time))

        if [[ $time_diff -le 500 && $time_diff -ge 0 ]]; then
          if ${pkgs.procps}/bin/pgrep -x niri > /dev/null; then
            ${pkgs.niri}/bin/niri msg action close-window
          elif ${pkgs.procps}/bin/pgrep -x i3 > /dev/null; then
            ${pkgs.i3}/bin/i3-msg kill
          else
            ${pkgs.i3}/bin/i3-msg kill
          fi
          ${pkgs.coreutils}/bin/rm -f "$timestamp_file"
          exit 0
        fi
      fi

      echo "$current_time" > "$timestamp_file"
    '';
  in [
    killConfirm
  ];
}
