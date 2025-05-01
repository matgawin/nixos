{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.meslo-lg
      nerd-fonts.fira-code
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "MesloLGS Nerd Font Mono"
          "Fira Code Nerd Font Mono"
        ];
        serif = [
          "MesloLGS Nerd Font"
          "Fira Code Nerd Font"
        ];
        sansSerif = [
          "MesloLGS Nerd Font"
          "Fira Code Nerd Font"
        ];
      };
    };
    fontDir.enable = true;
  };
}
