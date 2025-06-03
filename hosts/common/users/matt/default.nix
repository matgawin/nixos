{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users.matt = {
      # mkpasswd -m yescrypt
      hashedPasswordFile = "${config.sops.secrets."user/matt_password".path}";
      packages = [pkgs.home-manager];
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = ifTheyExist [
        "gamemode"
        "git"
        "libvirtd"
        "lp"
        "networkmanager"
        "podman"
        "scanner"
        "wheel"
        "wireshark"
      ];
    };
  };
}
