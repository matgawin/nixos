{
  config,
  lib,
  outputs,
  inputs,
  ...
}: {
  imports =
    [
      inputs.sops-nix.homeManagerModules.sops
      inputs.dankMaterialShell.homeModules.dankMaterialShell.default
      ./secrets/sops.nix

      ./desktop
      ./programs
      ./scripts
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = lib.mkDefault "matt";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "25.05";
}
