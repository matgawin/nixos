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
      hashedPassword = "$y$j9T$YrHIMO2Drso6fg6xJTSan1$PULS1MCCH4HmwWRJCVMZCE1bp.PU/HDZFkG.440vw/6";
      packages = [pkgs.home-manager];
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = ifTheyExist [
        "docker"
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
