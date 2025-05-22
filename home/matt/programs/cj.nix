{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.journal-management.homeManagerModule.default
  ];

  services.journal-management = {
    enable = true;
    journalDirectory = "${config.home.homeDirectory}/Journal/notes";
    enableTimestampMonitor = true;
    enableAutoCreation = true;
    autoCreationTime = "22:00";
  };
}
