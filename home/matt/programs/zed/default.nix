{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.zed-editor.packages.${pkgs.system}.default
  ];
  # programs.zed-editor = {
  #   enable = true;
  # };
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
