{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
        serif = [
          "Noto Serif"
          "Source Han Serif"
        ];
        sansSerif = [
          "Noto Sans"
          "Source Han Sans"
        ];
      };
    };
    fontDir.enable = true;
  };
}
