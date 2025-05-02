{pkgs, ...}: let
  astronaut-theme = pkgs.callPackage ./sddm-theme.nix {
    inherit pkgs;
  };
in {
  services.displayManager = {
    sddm = {
      enable = true;
      theme = "astronaut";
      package = pkgs.kdePackages.sddm;
      extraPackages = [
        astronaut-theme
        pkgs.kdePackages.qtmultimedia
        pkgs.kdePackages.qtvirtualkeyboard
      ];
      settings = {
        Theme = {
          ThemeDir = "${astronaut-theme}/share/sddm/themes";
        };
        General = {
          DisplayServer = "x11";
          Greeter = "${pkgs.kdePackages.sddm}/bin/sddm-greeter-qt6";
        };
      };
    };
    defaultSession = "none+i3";
  };
}
