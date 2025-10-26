{
  lib,
  pkgs,
  ...
}: {
  services = {
    btrfs = {
      autoScrub = {
        enable = true;
        interval = "weekly";
        fileSystems = ["/"];
      };
    };
    getty = {
      greetingLine = "";
      helpLine = lib.mkForce ''<<< \l >>>'';
    };
    blueman.enable = true;
    nextdns.enable = true;
    flatpak.enable = true;
    tailscale = {
      enable = true;
      openFirewall = true;
    };
    xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "pl";
      };
    };
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    printing = {
      drivers = with pkgs; [
        epson-escpr2
      ];
      enable = true;
    };
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    xrdp = {
      enable = false;
      defaultWindowManager = "i3";
      openFirewall = true;
      extraConfDirCommands = ''
        substituteInPlace $out/xrdp.ini \
          --replace "max_bpp=32" "max_bpp=24" \
          --replace "; allow_channels=true" "allow_channels=true" \
          --replace "; allow_multimon=true" "allow_multimon=true" \
          --replace "; security_layer=tls" "security_layer=tls" \
          --replace "; ssl_protocols=TLSv1.2, TLSv1.3" "ssl_protocols=TLSv1.2, TLSv1.3" \
          --replace "; tcp_keepalive=true" "tcp_keepalive=1" \
          --replace "; tls_ciphers=HIGH" "tls_ciphers=HIGH" \
          --replace "; autorun=xrdp1" "autorun=true"
      '';
    };
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    upower.enable = true;
  };
}
