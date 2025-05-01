{pkgs, ...}: {
  imports = [
    ./picom.nix
    ./i3.nix
    ./polybar.nix

    ./rofi
  ];

  home.packages = [
    (pkgs.writeShellScriptBin "fetch-bing-wallpaper" ''
      mkdir -p $HOME/.wallpapers
      ${pkgs.curl}/bin/curl -s "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1" |
      ${pkgs.jq}/bin/jq -r '.images[0].url' |
      xargs -I {} ${pkgs.curl}/bin/curl -s "https://bing.com{}" -o $HOME/.wallpapers/bing-wallpaper.jpg &&
      ${pkgs.feh}/bin/feh --bg-scale $HOME/.wallpapers/bing-wallpaper.jpg
    '')
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
