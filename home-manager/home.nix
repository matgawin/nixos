{ ... }:
{
  imports = [
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix

    ./packages.nix
  ];

  nixpkgs = {
    overlays = [
      # Or define it inline, for example:
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "matt";
    homeDirectory = "/home/matt";
  };

  programs = {
    home-manager.enable = true;
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "25.05";
}
