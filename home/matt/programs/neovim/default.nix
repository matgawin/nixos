{pkgs, ...}: let
  nvimConfigPatched = pkgs.stdenv.mkDerivation {
    pname = "lazyvim-starter-patched";
    version = "main";
    src = pkgs.fetchgit {
      url = "https://github.com/LazyVim/starter.git";
      rev = "refs/heads/main";
      sha256 = "sha256-QrpnlDD4r1X4C8PqBhQ+S3ar5C+qDrU1Jm/lPqyMIFM=";
    };
    patches = [
      ./lazyvim-custom.patch
    ];
    installPhase = ''
      cp -R . $out
    '';
  };
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim" = {
    source = nvimConfigPatched;
    recursive = true;
  };
}
