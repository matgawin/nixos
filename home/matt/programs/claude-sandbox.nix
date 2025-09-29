{
  inputs,
  pkgs,
  config,
  ...
}: let
  bwc = inputs.bubblewrap-claude.lib.${pkgs.system};

  baseProfile = {
    url = "api.z.ai";
    ips = ["47.254.137.170"];
    env = {
      ANTHROPIC_BASE_URL = "https://api.z.ai/api/anthropic";
      API_TIMEOUT_MS = "3000000";
      ANTHROPIC_DEFAULT_HAIKU_MODEL = "glm-4.5-air";
      ANTHROPIC_DEFAULT_SONNET_MODEL = "glm-4.6";
      ANTHROPIC_DEFAULT_OPUS_MODEL = "glm-4.6";
    };
    preStartHooks = [
      ''export ANTHROPIC_AUTH_TOKEN="$(${pkgs.coreutils}/bin/cat ${config.sops.secrets."zai/api_key".path})"''
    ];
    args = [
      "--ro-bind ${config.sops.secrets."zai/api_key".path} ${config.sops.secrets."zai/api_key".path}"
    ];
  };
  mkProfile = name: {inherit name;} // baseProfile;

  claude-sandbox = bwc.mkSandbox (bwc.deriveProfile bwc.base (mkProfile "claude-sandbox"));
  claude-sandbox-nix = bwc.mkSandbox (bwc.deriveProfile bwc.profiles.nix (mkProfile "claude-sandbox-nix"));
  claude-sandbox-go = bwc.mkSandbox (bwc.deriveProfile bwc.profiles.go (mkProfile "claude-sandbox-go"));
in {
  home.packages = [
    claude-sandbox
    claude-sandbox-nix
    claude-sandbox-go
  ];
}
