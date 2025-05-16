{pkgs, ...}: let
  astronaut-theme = pkgs.callPackage ./sddm-theme.nix {
    inherit pkgs;
  };
in
  with pkgs; {
    services.displayManager = {
      sddm = {
        enable = true;
        theme = "astronaut";
        package = kdePackages.sddm;
        extraPackages = [
          astronaut-theme
          kdePackages.qtmultimedia
          kdePackages.qtvirtualkeyboard
          catppuccin-cursors.mochaDark
        ];
        settings = {
          Theme = {
            ThemeDir = "${astronaut-theme}/share/sddm/themes";
            CursorTheme = "catppuccin-mocha-dark-cursors";
            CursorSize = "24";
          };
          General = {
            DisplayServer = "x11";
            Greeter = "${kdePackages.sddm}/bin/sddm-greeter-qt6";
          };
        };
      };
      defaultSession = "none+i3";
    };
  }
