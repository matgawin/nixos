{
  config,
  lib,
  outputs,
  ...
}: {
  imports =
    [
      ./services.nix

      ./desktop
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

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "25.05";
}
