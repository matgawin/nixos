{config, ...}: {
  sops.templates."ssh-hosts-config" = {
    content = ''
      Host inlibro
        HostName ${config.sops.placeholder."ssh/inlibro/hostname"}
        Port ${config.sops.placeholder."ssh/inlibro/port"}
        User ${config.sops.placeholder."ssh/inlibro/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_inlibro".path}
        ServerAliveInterval 60
        ServerAliveCountMax 2

      Host tigred1
        HostName ${config.sops.placeholder."ssh/tigred1/hostname"}
        Port ${config.sops.placeholder."ssh/tigred1/port"}
        User ${config.sops.placeholder."ssh/tigred1/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_cloudways".path}
        ServerAliveInterval 60
        ServerAliveCountMax 2

      Host tigred2
        HostName ${config.sops.placeholder."ssh/tigred2/hostname"}
        Port ${config.sops.placeholder."ssh/tigred2/port"}
        User ${config.sops.placeholder."ssh/tigred2/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_cloudways".path}
        ServerAliveInterval 60
        ServerAliveCountMax 2

      Host tigred3
        HostName ${config.sops.placeholder."ssh/tigred3/hostname"}
        Port ${config.sops.placeholder."ssh/tigred3/port"}
        User ${config.sops.placeholder."ssh/tigred3/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_cloudways".path}
        ServerAliveInterval 60
        ServerAliveCountMax 2

      Host inlibro_cloud
        HostName ${config.sops.placeholder."ssh/inlibro_cloud/hostname"}
        Port ${config.sops.placeholder."ssh/inlibro_cloud/port"}
        User ${config.sops.placeholder."ssh/inlibro_cloud/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_cloudways".path}
        ServerAliveInterval 60
        ServerAliveCountMax 2

      Host github.com
        HostName ${config.sops.placeholder."ssh/github/hostname"}
        User ${config.sops.placeholder."ssh/github/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/github_personal".path}

      Host katana
        HostName ${config.sops.placeholder."ssh/katana/hostname"}
        Port ${config.sops.placeholder."ssh/katana/port"}
        User ${config.sops.placeholder."ssh/katana/user"}
        ServerAliveInterval 60
        ServerAliveCountMax 2

      Host gitlab.ktn.global
        HostName ${config.sops.placeholder."ssh/gitlab_katana/hostname"}
        Port ${config.sops.placeholder."ssh/gitlab_katana/port"}
        User ${config.sops.placeholder."ssh/gitlab_katana/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_gitlab_katana".path}

      Host s101.cyber-folks.pl
        HostName ${config.sops.placeholder."ssh/cyberfolks/hostname"}
        Port ${config.sops.placeholder."ssh/cyberfolks/port"}
        User ${config.sops.placeholder."ssh/cyberfolks/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_cyberfolks_rpms".path}
        ServerAliveInterval 60
        ServerAliveCountMax 2

      Host hetzner
        HostName ${config.sops.placeholder."ssh/hetzner_storage/hostname"}
        Port ${config.sops.placeholder."ssh/hetzner_storage/port"}
        User ${config.sops.placeholder."ssh/hetzner_storage/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_hetzner".path}
        ServerAliveInterval 60
        ServerAliveCountMax 2
    '';
    mode = "0400";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    includes = [
      config.sops.templates."ssh-hosts-config".path
    ];

    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "yes";
        compression = false;
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
  };
}
