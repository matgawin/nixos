{
  inputs,
  pkgs,
  config,
  ...
}: let
  bwc = inputs.bubblewrap-claude.lib.${pkgs.stdenv.hostPlatform.system};

  baseProfile = {
    env = {
      EDITOR = "vim";
    };
    preStartHooks = [
      ''export ANTHROPIC_AUTH_TOKEN="$(${pkgs.coreutils}/bin/cat ${config.sops.secrets."anthropic/api_key".path})"''
    ];
    args = [
      "--ro-bind ${config.sops.secrets."anthropic/api_key".path} ${config.sops.secrets."anthropic/api_key".path}"
    ];
  };
  mkProfile = name: {inherit name;} // baseProfile;

  claude-sandbox = bwc.mkSandbox (bwc.deriveProfile bwc.base (mkProfile "claude-sandbox"));
  claude-sandbox-nix = bwc.mkSandbox (bwc.deriveProfile bwc.profiles.nix (mkProfile "claude-sandbox-nix"));
  claude-sandbox-python = bwc.mkSandbox (bwc.deriveProfile bwc.profiles.python (mkProfile "claude-sandbox-python"));

  newGoProfile = bwc.deriveProfile bwc.profiles.go (mkProfile "go");
  claude-sandbox-go = bwc.mkSandbox (bwc.deriveProfile newGoProfile {
    name = "claude-sandbox-go";
    packages = with pkgs; [
      gofumpt
      golangci-lint
      gcc
    ];
    env = {
      CGO_ENABLED = "1";
    };
  });

  svelte-sandbox = bwc.mkSandbox (bwc.deriveProfile bwc.base (bwc.deriveProfile (mkProfile "") {
    name = "svelte-sandbox";
    packages = with pkgs; [
      nodejs
      bun
      supabase-cli
      typescript
      nodePackages.eslint
      nodePackages.prettier
      pgcli
      postgresql
      docker
      docker-compose
    ];
  }));
in {
  home.packages = [
    claude-sandbox
    claude-sandbox-nix
    claude-sandbox-go
    claude-sandbox-python
    svelte-sandbox
  ];
}
