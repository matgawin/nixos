{pkgs}: let
  version = "1.16.4b";
  zenTarball = pkgs.fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.xz";
    hash = "sha256-H+MIFHnHMyfHCkt0xEeBtCx5a+khS/Klgx+tXmeSxBs=";
  };
in
  pkgs.stdenv.mkDerivation rec {
    pname = "zen-browser";
    inherit version;
    src = zenTarball;

    nativeBuildInputs = with pkgs; [
      makeWrapper
      autoPatchelfHook
      wrapGAppsHook
    ];

    buildInputs = with pkgs; [
      gtk3
      glib
      nss
      nspr
      atk
      at-spi2-atk
      libdrm
      expat
      libxcb
      libxkbcommon
      xorg.libX11
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXrandr
      mesa
      alsa-lib
      dbus-glib
      ffmpeg
      libva
      pciutils
      systemd
    ];

    runtimeDependencies = with pkgs; [
      udev
      libva
      mesa
    ];

    dontConfigure = true;
    dontBuild = true;

    unpackPhase = ''
      runHook preUnpack
      mkdir -p $out
      tar -xf $src -C $out --strip-components=1
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      makeWrapper $out/zen $out/bin/zen-browser \
        --set MOZ_LEGACY_PROFILES 1 \
        --set MOZ_ALLOW_DOWNGRADE 1 \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}" \
        --prefix PATH : ${pkgs.lib.makeBinPath [pkgs.ffmpeg]}

      mkdir -p $out/share/applications
      cat > $out/share/applications/zen-browser.desktop << EOF
      [Desktop Entry]
      Name=Zen Browser
      Comment=Experience tranquillity while browsing the web
      Exec=$out/bin/zen-browser %U
      Icon=$out/browser/chrome/icons/default/default128.png
      Type=Application
      Categories=Network;WebBrowser;
      MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss +xml;application/rdf    +xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/c    hrome;video/webm;application/x-xpinstall;
      StartupNotify=true
      StartupWMClass=zen-alpha
      EOF

      runHook postInstall
    '';

    meta = {
      description = "Zen Browser - Experience tranquillity while browsing the web";
      homepage = "https://zen-browser.app/";
      mainProgram = "zen-browser";
    };
  }
