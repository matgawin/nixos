{pkgs, ...}:
with pkgs; {
  home.pointerCursor = {
    enable = true;
    name = "catppuccin-mocha-dark-cursors";
    package = catppuccin-cursors.mochaDark;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = let
    nightfox = nightfox-gtk-theme.override {
      colorVariants = ["dark"];
      sizeVariants = ["compact"];
      themeVariants = ["default"];
      tweakVariants = ["nord"];
      iconVariants = ["Duskfox"];
    };
    extra = {
      gtk-application-prefer-dark-theme = true;
    };
  in {
    enable = true;
    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
      package = catppuccin-cursors.mochaDark;
      size = 24;
    };
    theme = {
      name = "Nightfox-Dark-Compact-Nord";
      package = nightfox;
    };
    gtk3.extraConfig = extra;
    gtk4.extraConfig = extra;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "kvantum";
      package = kdePackages.qtstyleplugin-kvantum;
    };
  };
}
