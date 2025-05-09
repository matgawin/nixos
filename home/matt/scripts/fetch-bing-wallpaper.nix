{pkgs, ...}: {
  home.packages = let
    bash = "${pkgs.bash}/bin/bash";
    curl = "${pkgs.curl}/bin/curl";
    jq = "${pkgs.jq}/bin/jq";
    feh = "${pkgs.feh}/bin/feh";
    btlscr = "${pkgs.betterlockscreen}/bin/betterlockscreen";

    url = "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1";
    dir = "$HOME/.wallpapers";
    file = "${dir}/bing-wallpaper.jpg";

    fetch-bing-wallpaper = pkgs.writeShellScriptBin "fetch-bing-wallpaper" ''
      #!${bash}
      mkdir -p ${dir}

      if [ ! -f ${file} ] || [ $(( $(date +%s) - $(date -r ${file} +%s) )) -gt 43200 ]; then
        ${curl} -s "${url}" | ${jq} -r '.images[0].url' | xargs -I {} ${curl} -s "https://bing.com{}" -o ${file}
        touch ${file}
      fi

      ${feh} --bg-scale ${file}
      ${btlscr} -u ${file}
    '';
  in [
    fetch-bing-wallpaper
  ];
}
