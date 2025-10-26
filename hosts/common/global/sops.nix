{lib, ...}: {
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      keyFile = "/etc/sops/age/atom-age-key.txt";
    };

    secrets = let
      defaultConf = {
        owner = "root";
        group = "root";
        mode = "0400";
      };
      defaultSecrets = [
        "borgbackup/passphrase"
        "hetzner/hostname"
        "hetzner/username"
        "hetzner/port"
      ];
      customSecrets = {
        "user/matt_password" =
          defaultConf
          // {
            neededForUsers = true;
          };
        "slskd-env" =
          defaultConf
          // {
            neededForUsers = true;
          };
        "hetzner/ssh_public_key" =
          defaultConf
          // {
            mode = "0644";
          };
      };
    in
      lib.genAttrs defaultSecrets (path: defaultConf) // customSecrets;
  };
}
