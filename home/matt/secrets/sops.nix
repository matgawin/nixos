{
  config,
  lib,
  ...
}: {
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = let
      defaultConf = {
        mode = "0400";
      };
      defaultSecrets = [
        "ssh/inlibro/hostname"
        "ssh/inlibro/port"
        "ssh/inlibro/user"

        "ssh/tigred1/hostname"
        "ssh/tigred1/port"
        "ssh/tigred1/user"

        "ssh/tigred2/hostname"
        "ssh/tigred2/port"
        "ssh/tigred2/user"

        "ssh/tigred3/hostname"
        "ssh/tigred3/port"
        "ssh/tigred3/user"

        "ssh/inlibro_cloud/hostname"
        "ssh/inlibro_cloud/port"
        "ssh/inlibro_cloud/user"

        "ssh/github/hostname"
        "ssh/github/user"

        "ssh/katana/hostname"
        "ssh/katana/port"
        "ssh/katana/user"

        "ssh/gitlab_katana/hostname"
        "ssh/gitlab_katana/port"
        "ssh/gitlab_katana/user"

        "ssh/cyberfolks/hostname"
        "ssh/cyberfolks/port"
        "ssh/cyberfolks/user"

        "ssh/hetzner_storage/hostname"
        "ssh/hetzner_storage/port"
        "ssh/hetzner_storage/user"

        "ssh_keys/id_rsa_inlibro"
        "ssh_keys/id_rsa_cloudways"
        "ssh_keys/github_personal"
        "ssh_keys/id_rsa_gitlab_katana"
        "ssh_keys/id_rsa_cyberfolks_rpms"
        "ssh_keys/id_rsa_hetzner"
      ];
    in
      lib.genAttrs defaultSecrets (path: defaultConf);
  };
}
