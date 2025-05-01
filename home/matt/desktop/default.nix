{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [

  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      keybindings = {
        "Mod4-Return" = "exec konsole";
        "Mod4-d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "Mod4-x" = "kill";
        "Mod4-h" = "focus left";
        "Mod4-j" = "focus down";
        "Mod4-k" = "focus up";
        "Mod4-l" = "focus right";
        "Mod4-Shift-h" = "move left";
        "Mod4-Shift-j" = "move down";
        "Mod4-Shift-k" = "move up";
        "Mod4-Shift-l" = "move right";
        "Mod4-r" = "mode resize";
      };

      workspaceOutputAssign = [
        # { workspace = "1"; output = "primary"; }
        # { workspace = "2"; output = "primary"; }
      ];

      startup =
        [
          {
            command = "${pkgs.picom}/bin/picom";
            always = true;
            notification = false;
          }
        ];

      assigns = {
        "1" = [{class = "^Brave$";}];
        "2" = [{class = "^zed$";}];
        "3" = [{class = "^konsole$";}];
      };

      extraConfig = ''
        # hide_edge_borders both
      '';
    };
  };
}
