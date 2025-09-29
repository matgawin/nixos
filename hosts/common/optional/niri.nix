{pkgs, ...}: {
  imports = [
    ./sddm.nix
  ];
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    xwayland
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    config.niri = {
      default = ["gtk"];
      "org.freedesktop.impl.portal.Secret" = ["kwallet"];
    };
  };
}
