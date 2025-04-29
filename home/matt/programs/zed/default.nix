{ inputs, lib, config, ... }: let
    mkMutableSymlink = path: config.lib.file.mkOutOfStoreSymlink (
        config.xdg.configFile + lib.strings.removePrefix (toString inputs.self) (toString path)
    );
in
{
  programs.zed-editor = {
    enable = true;
  };

  xdg.configFile."zed/settings.json".source = mkMutableSymlink ./settings.json;
  xdg.configFile."zed/keymap.json".source = mkMutableSymlink ./keymap.json;
  xdg.configFile."zed/tasks.json".source = mkMutableSymlink ./tasks.json;
}
