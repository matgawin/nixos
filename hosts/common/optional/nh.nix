{
  programs.nh = {
    enable = true;
    clean = {
      enable = false;
      extraArgs = "--keep 10 --keep-since 7d";
    };
    flake = "/home/matt/Projects/nixos-flake";
  };
}
