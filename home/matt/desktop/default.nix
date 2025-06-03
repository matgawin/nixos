{pkgs, ...}: {
  imports = [
    ./dunst.nix
    ./i3.nix
    ./picom.nix
    ./polybar.nix
    ./stylix.nix

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
