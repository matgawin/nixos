{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with inputs.bubblewrap-claude.packages.${pkgs.system}; [
    claude-sandbox
    claude-sandbox-nix
    claude-sandbox-go
  ];
}
