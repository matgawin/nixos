{pkgs}: let
  version = "0.1.10";
  atuinDesktopDeb = pkgs.fetchurl {
    url = "https://github.com/atuinsh/desktop/releases/download/v${version}/Atuin_Desktop_0.1.10_amd64.deb";
    hash = "sha256-eZgs3dAXlbp4koIQyrzhuswEljeQLd2qVU+TEek0OIw=";
  };
in
  pkgs.stdenv.mkDerivation rec {
    pname = "atuin-desktop";
    inherit version;
    src = atuinDesktopDeb;
    nativeBuildInputs = with pkgs; [
      makeWrapper
      autoPatchelfHook
      dpkg
    ];

    buildInputs = with pkgs; [
      webkitgtk_4_1
      gtk3
      cairo
      gdk-pixbuf
      glib
      dbus
      openssl_3
      librsvg
      libsoup_3
    ];

    meta = {
      description = "Atuin Desktop";
      homepage = "https://github.com/atuinsh/desktop/releases/tag/v${version}";
      mainProgram = "atuin-desktop";
    };

    unpackPhase = ''
      runHook preUnpack
      dpkg-deb -x $src .
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      mkdir -p $out/lib
      mkdir -p $out/share/applications
      mkdir -p $out/share/icons/hicolor

      install -Dm755 usr/bin/atuin-desktop $out/bin/atuin-desktop

      cp -r "usr/lib/Atuin Desktop" "$out/lib/"

      install -Dm644 "usr/share/applications/Atuin Desktop.desktop" $out/share/applications/atuin-desktop.desktop

      cp -r usr/share/icons/hicolor/* $out/share/icons/hicolor/

      substituteInPlace $out/share/applications/atuin-desktop.desktop \
        --replace "Exec=atuin-desktop" "Exec=$out/bin/atuin-desktop" \
        --replace "Icon=atuin-desktop" "Icon=atuin-desktop"

      wrapProgram $out/bin/atuin-desktop \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}"

      runHook postInstall
    '';
  }
