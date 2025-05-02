{
  pkgs,
  fetchFromGitHub,
  ...
}: let
  theme = "astronaut";
in
  pkgs.stdenv.mkDerivation {
    pname = "sddm-astronaut-theme";
    version = "1.0";

    src = fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      rev = "bf4d01732084be29cedefe9815731700da865956";
      sha256 = "sha256-JMCG7oviLqwaymfgxzBkpCiNi18BUzPGvd3AF9BYSeo=";
    };

    postPatch = ''
      substituteInPlace metadata.desktop \
        --replace "ConfigFile=Themes/astronaut.conf" "ConfigFile=Themes/${theme}.conf"
    '';

    installPhase = ''
      mkdir -p $out/share/sddm/themes/astronaut
      cp -r ./* $out/share/sddm/themes/astronaut/
    '';
  }
