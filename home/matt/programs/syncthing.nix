{pkgs, ...}: {
  services.syncthing = {
    enable = true;
    package = pkgs.syncthing;

    settings = let
      thinkpad = "thinkpad";
      pixel6a = "Pixel 6a";
      pixel9a = "Pixel 9a";

      docs = "Documents";
      down = "Downloads";
      pict = "Pictures";
      vault6a = "Pixel6Vault";
      vault9a = "Pixel9Vault";
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
        ${pixel9a} = {
          id = "2VTN2WH-MSC2VCL-SG5MZIZ-46JXUQS-P25MXZP-NLKFFFB-UNSOVI2-JLMKTQP";
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
        ${vault6a} = {
          id = "0cami-x2wjp";
          label = "${vault6a}";
          path = "/storage/quark/Pixel6a/seed_vault";
          type = "receiveonly";
          devices = [
            "${pixel6a}"
          ];
        };
        ${vault9a} = {
          id = "8x20r-zota6";
          label = "${vault9a}";
          path = "/storage/quark/Pixel9a/seed_vault";
          type = "receiveonly";
          devices = [
            "${pixel9a}"
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
