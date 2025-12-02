{pkgs, ...}: {
  imports = [
    ./niri.nix
    ./stylix.nix
    ./noctalia.nix
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
