{pkgs, ...}: let
  slskdConfig = import ./slskd-config.nix {inherit pkgs;};

  user = "matt";
  portFile = "/run/user/$USER_UID/Proton/VPN/forwarded_port";
  slskdWrapper = pkgs.writeShellScript "slskd-wrapper" ''
    set -e

    USER_UID=$(id -u matt)
    PORT_FILE="${portFile}"

    if [ -f "$PORT_FILE" ] && [ -s "$PORT_FILE" ]; then
      PORT=$(cat "$PORT_FILE")
      echo "Using ProtonVPN port: $PORT"

      ${pkgs.slskd}/bin/slskd --no-connect --slsk-listen-port "$PORT" --app-dir /var/lib/slskd --config ${slskdConfig}
    else
      echo "Error: Port file not found at $PORT_FILE"
    fi
  '';

  slskdRestartWrapper = pkgs.writeShellScript "restart-slskd-if-port-exists" ''
    set -e

    sleep 2
    USER_UID=$(id -u matt)
    PORT_FILE="${portFile}"
    if [ -f "$PORT_FILE" ] && [ -s "$PORT_FILE" ]; then
      PORT=$(cat "$PORT_FILE")

      ${pkgs.systemd}/bin/systemctl restart slskd-update-port.service
      STATE=$(${pkgs.systemd}/bin/systemctl show -p ActiveState --value slskd.service)
      if [ "$STATE" = "active" ] || [ "$STATE" = "activating" ]; then
        echo "Port file has content ($PORT), restarting slskd with new port..."
        ${pkgs.systemd}/bin/systemctl restart slskd.service
      else
        echo "slskd service is stopped (state: $STATE), skipping restart (manually stopped)"
      fi
    else
      echo "Port file missing or empty, skipping restart (VPN likely disconnected)"
    fi
  '';

  updatePortSet = pkgs.writeShellScript "update-slskd-port" ''
    set -e

    USER_UID=$(id -u matt)
    PORT_FILE="${portFile}"

    if [ -f "$PORT_FILE" ] && [ -s "$PORT_FILE" ]; then
      PORT=$(cat "$PORT_FILE")
      echo "Updating slskd-ports set with port: $PORT"

      ${pkgs.ipset}/bin/ipset flush slskd-ports
      ${pkgs.ipset}/bin/ipset add slskd-ports "$PORT"
    else
      ${pkgs.ipset}/bin/ipset flush slskd-ports
      echo "Error: Port file not found at $PORT_FILE"
    fi
  '';
in {
  inherit slskdWrapper slskdRestartWrapper updatePortSet;
}
