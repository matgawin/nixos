{pkgs}: let
  version = "0.229.0";
  zedCodeTarball = pkgs.fetchurl {
    url = "https://github.com/zed-industries/zed/releases/download/v${version}/zed-linux-x86_64.tar.gz";
    hash = "sha256-GA9N6veqUTo/BmSOPsqtJwv/zGRUHoV/HnA4EHGpCMs=";
  };
in
  pkgs.stdenv.mkDerivation rec {
    pname = "zed-editor";
    inherit version;
    src = zedCodeTarball;
    nativeBuildInputs = with pkgs; [
      makeWrapper
      autoPatchelfHook
    ];

    buildInputs = with pkgs; [
      libGL
      libxkbcommon
      wayland
      libX11
      libXcursor
      libXi
      libXrandr

      alsa-lib

      fontconfig
      freetype

      vulkan-loader
      stdenv.cc.cc.lib
    ];
    meta = {
      description = "Zed Editor";
      homepage = "https://github.com/zed-industries/zed/releases/tag/v${version}";
      mainProgram = "zed";
    };

    unpackPhase = ''
      runHook preUnpack
      tar -xzf $src --strip-components=1
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp -r . $out/

      makeWrapper $out/libexec/zed-editor $out/bin/zed \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}"

      runHook postInstall
    '';
  }
