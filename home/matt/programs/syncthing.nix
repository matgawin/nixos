{pkgs, ...}: {
  services.syncthing = {
    enable = true;
    package = pkgs.syncthing;

    settings = let
      thinkpad = "thinkpad";
      pixel6a = "Pixel 6a";

      docs = "Documents";
      down = "Downloads";
      pict = "Pictures";
      vault = "Pixel6Vault";
    in {
      devices = {
        ${thinkpad} = {
          id = "WJ4BVKT-PURATQS-XSKFK22-RXIHKRB-GWEOUJ7-U3FSBH7-HTD75QK-IMT43AS";
          addresses = [
            "dynamic"
          ];
        };
        ${pixel6a} = {
          id = "HNFI7RW-SH2EFAD-6RTWAKI-PE3DMMD-CEGZ3RD-DXGBQW3-Q5VXUI5-B6IJ2QS";
          addresses = [
            "dynamic"
          ];
        };
      };
      folders = let
        versioning = {
          enabled = true;
          type = "simple";
          params = {
            keep = "5";
            cleanoutDays = "30";
          };
        };
      in {
        ${docs} = {
          id = "xypfy-vlheo";
          label = "${docs}";
          path = "~/${docs}";
          type = "sendreceive";
          devices = [
            "${thinkpad}"
          ];
          versioning = versioning;
        };
        ${down} = {
          id = "bszp7-pteua";
          label = "${down}";
          path = "~/${down}";
          type = "sendreceive";
          devices = [
            "${thinkpad}"
          ];
          versioning = versioning;
        };
        ${pict} = {
          id = "l4kon-jnnev";
          label = "${pict}";
          path = "~/${pict}";
          type = "sendreceive";
          devices = [
            "${thinkpad}"
          ];
          versioning = versioning;
        };
        ${vault} = {
          id = "0cami-x2wjp";
          label = "${vault}";
          path = "/storage/quark/Pixel6a/vault";
          type = "receiveonly";
          devives = [
            "${pixel6a}"
          ];
        };
      };
      options = {
        localAnnounceEnabled = true;
        globalAnnounceEnabled = false;
        relaysEnabled = true;
        urAccepted = -1;
      };
    };
    tray = {
      enable = true;
    };
  };
}
