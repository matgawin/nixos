{pkgs, ...}: {
  imports = [
    ./niri.nix
    ./stylix.nix

    ./dank-shell
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
