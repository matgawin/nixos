{pkgs, ...}: let
  zen-browser = import ./zen-browser.nix {inherit pkgs;};
in {
  home.packages = [
    zen-browser
  ];
}
