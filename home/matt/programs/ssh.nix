{config, ...}: {
  sops.templates."ssh-hosts-config" = {
    content = ''
      Host *
        ForwardAgent no
        AddKeysToAgent yes
        Compression no
        HashKnownHosts no
        UserKnownHostsFile ~/.ssh/known_hosts
        ControlMaster auto
        ControlPersist 10m
        ControlPath ~/.ssh/cm-%r@%h:%p
        ServerAliveInterval 60
        ServerAliveCountMax 2

      Host inlibro
        HostName ${config.sops.placeholder."ssh/inlibro/hostname"}
        Port ${config.sops.placeholder."ssh/inlibro/port"}
        User ${config.sops.placeholder."ssh/inlibro/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_inlibro".path}

      Host tigred1
        HostName ${config.sops.placeholder."ssh/tigred1/hostname"}
        Port ${config.sops.placeholder."ssh/tigred1/port"}
        User ${config.sops.placeholder."ssh/tigred1/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_cloudways".path}

      Host tigred2
        HostName ${config.sops.placeholder."ssh/tigred2/hostname"}
        Port ${config.sops.placeholder."ssh/tigred2/port"}
        User ${config.sops.placeholder."ssh/tigred2/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_cloudways".path}

      Host tigred3
        HostName ${config.sops.placeholder."ssh/tigred3/hostname"}
        Port ${config.sops.placeholder."ssh/tigred3/port"}
        User ${config.sops.placeholder."ssh/tigred3/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_cloudways".path}

      Host inlibro_cloud
        HostName ${config.sops.placeholder."ssh/inlibro_cloud/hostname"}
        Port ${config.sops.placeholder."ssh/inlibro_cloud/port"}
        User ${config.sops.placeholder."ssh/inlibro_cloud/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_cloudways".path}

      Host github.com
        HostName ${config.sops.placeholder."ssh/github/hostname"}
        User ${config.sops.placeholder."ssh/github/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/github_personal".path}

      Host katana
        HostName ${config.sops.placeholder."ssh/katana/hostname"}
        Port ${config.sops.placeholder."ssh/katana/port"}
        User ${config.sops.placeholder."ssh/katana/user"}
        IdentitiesOnly yes
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

      Host hetzner
        HostName ${config.sops.placeholder."ssh/hetzner_storage/hostname"}
        Port ${config.sops.placeholder."ssh/hetzner_storage/port"}
        User ${config.sops.placeholder."ssh/hetzner_storage/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_hetzner".path}

      Host hetzner-dokploy
        HostName ${config.sops.placeholder."ssh/hetzner_dokploy/hostname"}
        Port ${config.sops.placeholder."ssh/hetzner_dokploy/port"}
        User ${config.sops.placeholder."ssh/hetzner_dokploy/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_hetzner".path}

      Host hetzner-frontend
        HostName ${config.sops.placeholder."ssh/hetzner_frontend/hostname"}
        Port ${config.sops.placeholder."ssh/hetzner_frontend/port"}
        User ${config.sops.placeholder."ssh/hetzner_frontend/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_hetzner".path}
        ProxyJump hetzner-dokploy
        Compression yes

      Host hetzner-frontend-postgres
        HostName ${config.sops.placeholder."ssh/hetzner_frontend/hostname"}
        Port ${config.sops.placeholder."ssh/hetzner_frontend/port"}
        User ${config.sops.placeholder."ssh/hetzner_frontend/user"}
        IdentityFile ${config.sops.secrets."ssh_keys/id_rsa_hetzner".path}
        ProxyJump hetzner-dokploy
        LocalForward 5432 localhost:5432
        Compression yes
    '';
    mode = "0400";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    includes = [
      config.sops.templates."ssh-hosts-config".path
    ];
  };
}
