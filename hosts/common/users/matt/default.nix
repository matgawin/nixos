{ pkgs, config, ... }:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users.matt = {
      initialPassword = "pass";
      packages = [ pkgs.home-manager ];
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = ifTheyExist [
        "networkmanager"
        "wheel"
        "git"
        "podman"
        "docker"
        "wireshark"
        "libvirtd"
      ];
    };
  };
}
