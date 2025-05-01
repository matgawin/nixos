{
  config,
  lib,
  outputs,
  ...
}: {
  imports =
    [
      # ./desktop
      ./programs
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  home = {
    username = lib.mkDefault "matt";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    keyboard = {
      layout = "pl";
      variant = "";
    };
  };

  programs = {
    home-manager.enable = true;
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "25.05";
}
