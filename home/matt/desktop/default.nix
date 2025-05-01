{pkgs, ...}: {
  xserver = {
    displayManager = {
      lightdm.enable = true;
    };
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs (_: {
        src = pkgs.fetchgit {
          url = "https://github.com/Pixel2175/suckless.git";
          rev = "refs/heads/main";
          sha256 = "sha256-p7mbNHJJJL4sXMLAawhUPteb/Z7LskfBH5RClZfPOow=";
          sparseCheckout = [
            "dwm"
          ];
        };
        sourceRoot = "suckless/dwm";
      });
    };
  };
}
