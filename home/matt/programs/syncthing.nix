{pkgs, ...}: {
  services.syncthing = {
    enable = true;
    package = pkgs.syncthing;

    settings = let
      thinkpad = "thinkpad";
      docs = "Documents";
      down = "Downloads";
      pict = "Pictures";
    in {
      devices = {
        ${thinkpad} = {
          id = "WJ4BVKT-PURATQS-XSKFK22-RXIHKRB-GWEOUJ7-U3FSBH7-HTD75QK-IMT43AS";
          addresses = [
            "tcp://192.168.0.8:22000"
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
      };
      options = {
        localAnnounceEnabled = true;
        globalAnnounceEnabled = false;
        relaysEnabled = false;
        urAccepted = -1;
      };
    };
    tray = {
      enable = true;
    };
  };
}
