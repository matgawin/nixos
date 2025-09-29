{pkgs, ...}: {
  imports = [
    ./dunst.nix
    ./i3.nix
    ./niri.nix
    ./picom.nix
    ./polybar.nix
    ./stylix.nix
    ./waybar.nix

    ./rofi
  ];

  fontProfiles = {
    enable = true;
    monospace = {
      name = "MesloLGM Nerd Font";
      package = pkgs.nerd-fonts.meslo-lg;
      size = 10;
    };
    regular = {
      name = "MesloLGM Nerd Font";
      package = pkgs.nerd-fonts.meslo-lg;
      size = 10;
    };
  };
}
