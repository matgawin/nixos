{pkgs, ...}: let
  zed-editor = import ./zed.nix {inherit pkgs;};
in {
  home.packages = [
    zed-editor
  ];

  home.activation = {
    copyZedConfig = ''
      destDir="$HOME/.config/zed"
      srcDir="${./.}"

      mkdir -p "$destDir"

      for file in "$srcDir"/*.json; do
        baseFile=$(basename "$file")
        destFile="$destDir/$baseFile"

        if [ -e "$destFile" ]; then
            cp -f "$destFile" "$destFile.bak"
        fi

        cp -f "$file" "$destDir/"
        chmod +w "$destDir/$baseFile"
      done
    '';
  };
}
