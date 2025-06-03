{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.journal-management.homeManagerModule.default
  ];

  services.journal-management = rec {
    enable = true;
    journalDirectory = "${config.home.homeDirectory}/Journal/notes";
    enableTimestampMonitor = false;
    enableAutoCreation = true;
    autoCreationTime = "22:00";
    startDate = "2022-10-21";
    enableSopsSupport = true;
    sopsConfig = "${journalDirectory}/.sops.yaml";
    sopsAgeKeyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
