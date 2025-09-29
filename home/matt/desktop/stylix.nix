{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.stylix.homeModules.stylix];

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/material-palenight.yaml";
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };

    fonts = {
      monospace = {
        name = "MesloLGM Nerd Font";
        package = pkgs.nerd-fonts.meslo-lg;
      };
      sansSerif = {
        name = "MesloLGM Nerd Font";
        package = pkgs.nerd-fonts.meslo-lg;
      };
      serif = {
        name = "MesloLGM Nerd Font";
        package = pkgs.nerd-fonts.meslo-lg;
      };
      sizes = {
        applications = 10;
        terminal = 10;
        desktop = 10;
        popups = 10;
      };
    };

    targets = {
      gtk.enable = true;
      kde.enable = true;
      qt.enable = true;

      alacritty.enable = false;
      bat.enable = false;
      rofi.enable = false;
      zed.enable = false;
      dunst.enable = false;
      neovim.enable = false;
      i3.enable = false;

      btop.enable = true;
      fcitx5.enable = true;
      spotify-player.enable = true;
      firefox.enable = true;
      vim.enable = true;
    };

    opacity = {
      applications = 1.0;
      terminal = 0.95;
      desktop = 1.0;
      popups = 1.0;
    };

    polarity = "dark";
  };
}
