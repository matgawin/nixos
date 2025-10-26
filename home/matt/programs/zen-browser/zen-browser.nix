{pkgs}: let
  version = "1.17.10b";
  zenTarball = pkgs.fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.xz";
    hash = "sha256-tesKOE57xgltmEgnCEZ5eN6IIuiap+yspFtz9U048R8=";
  };
in
  pkgs.stdenv.mkDerivation rec {
    pname = "zen-browser";
    inherit version;
    src = zenTarball;

    nativeBuildInputs = with pkgs; [
      makeWrapper
      autoPatchelfHook
      wrapGAppsHook3
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
      xorg.libXrender
      xorg.libXi
      xorg.libXtst
      xorg.libxshmfence
      mesa
      libGL
      libGLU
      libglvnd
      alsa-lib
      dbus-glib
      ffmpeg
      libva
      libva-utils
      pciutils
      systemd
      fontconfig
      freetype
    ];

    runtimeDependencies = with pkgs; [
      udev
      libva
      libGL
      libglvnd
      vulkan-loader
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
      libraryPath="${pkgs.lib.makeLibraryPath (buildInputs ++ runtimeDependencies)}"

      makeWrapper $out/zen $out/bin/zen-browser \
        --set MOZ_LEGACY_PROFILES 1 \
        --set MOZ_ALLOW_DOWNGRADE 1 \
        --set MOZ_ENABLE_WAYLAND 1 \
        --set MOZ_USE_XINPUT2 1 \
        --set GTK_USE_PORTAL 1 \
        --prefix LD_LIBRARY_PATH : "$libraryPath" \
        --prefix LD_LIBRARY_PATH : "${pkgs.mesa}/lib" \
        --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib" \
        --prefix PATH : ${pkgs.lib.makeBinPath [pkgs.ffmpeg pkgs.libva-utils]} \
        --set LIBVA_DRIVER_NAME "auto" \
        --set VDPAU_DRIVER "auto" \
        --set __GL_THREADED_OPTIMIZATIONS 1 \
        --set MOZ_ACCELERATED 1 \
        --set MOZ_WEBRENDER 1

      mkdir -p $out/share/applications
      cat > $out/share/applications/zen-browser.desktop << EOF
      [Desktop Entry]
      Name=Zen Browser
      Comment=Experience tranquillity while browsing the web
      Exec=$out/bin/zen-browser %U
      Icon=$out/browser/chrome/icons/default/default128.png
      Type=Application
      Categories=Network;WebBrowser;
      MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
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
