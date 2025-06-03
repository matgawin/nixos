# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands
- `nix develop` or `nix-shell` - Bootstrap development environment
- `nixos-rebuild --flake .#atom` - Build and switch to system configuration
- `nixos-rebuild build --flake .#atom` - Build system configuration without switching
- `home-manager --flake .#matt@atom switch` - Build and switch to home-manager configuration
- `home-manager --flake .#matt@atom build` - Build home-manager configuration without switching
- `nix flake update` - Update all flake inputs
- `nix flake lock --update-input <input>` - Update specific flake input
- `nix flake check` - Verify flake integrity and evaluate all outputs
- `alejandra .` - Format all Nix files (formatter defined in flake outputs)

## Architecture Overview

This is a personal NixOS flake configuration with a modular structure supporting multiple hosts and users.

### Flake Structure
- **Inputs**: Uses nixpkgs-unstable, home-manager, hardware detection, sops-nix for secrets, and custom packages (zed-editor, nix-gl, journal-management)
- **Outputs**: Defines nixosConfigurations for system configs and homeConfigurations for user environments
- **Systems**: Supports aarch64-linux, i686-linux, x86_64-linux

### Configuration Hierarchy
```
hosts/
├── atom/                    # Main machine configuration
│   ├── default.nix         # Host-specific settings and imports
│   ├── hardware.nix        # Hardware-specific configuration
│   ├── hardware-configuration.nix  # Auto-generated hardware config
│   └── btrbk.nix          # Backup configuration
├── common/
│   ├── global/             # Base system configuration for all hosts
│   │   ├── default.nix    # Imports all global modules
│   │   ├── nix.nix        # Nix daemon and flake settings
│   │   ├── packages.nix   # System-wide packages
│   │   ├── services.nix   # Essential system services
│   │   ├── sops.nix       # Secret management configuration
│   │   └── ...           # Other global configs
│   ├── optional/          # Optional system features
│   │   ├── i3.nix        # i3 window manager
│   │   ├── steam.nix     # Gaming configuration
│   │   ├── borgbackup.nix # Borg backup service
│   │   └── ...           # Other optional modules
│   └── users/matt/        # User account configuration
└── secrets/               # Encrypted secrets managed by sops

home/matt/
├── atom.nix              # Machine-specific home configuration
├── desktop/              # Desktop environment configuration
│   ├── i3.nix           # i3wm configuration
│   ├── polybar.nix      # Status bar configuration
│   ├── picom.nix        # Compositor settings
│   └── ...              # Other desktop components
├── programs/             # Application configurations
│   ├── default.nix      # Imports all programs + package list
│   ├── zed/             # Zed editor configuration
│   ├── neovim/          # Neovim configuration
│   └── ...              # Individual program configs
└── scripts/              # Custom shell scripts as Nix derivations

modules/home-manager/     # Custom home-manager modules
```

## Key Configuration Patterns

### Host Configuration
- Each host inherits from `hosts/common/global` for base system config
- Optional features imported selectively from `hosts/common/optional`
- Hardware-specific settings isolated in separate files
- Uses nixos-hardware modules for automatic hardware optimization

### Home Manager Integration
- Integrated at system level via nixosModules
- User configurations in `home/` with machine-specific entry points
- Programs configured declaratively with dotfiles managed by Nix
- Custom modules extend home-manager functionality

### Secret Management
- Uses sops-nix for encrypted secret management
- Age keys defined in `.sops.yaml` for admin and host access
- Secrets stored in `hosts/secrets/secrets.yaml`
- Integration allows secure deployment of sensitive configuration

### Package Management
- System packages in `hosts/common/global/packages.nix`
- User packages in `home/matt/programs/default.nix`
- Overlays available in `hosts/common/global/default.nix` for custom package modifications
- Flake inputs provide access to bleeding-edge packages

## Development Workflow
- Test changes with `nixos-rebuild build` before switching
- Use `nix flake check` to validate configuration syntax
- Home manager changes can be tested independently
- Format code with `alejandra .` before committing

## Secret Operations
- `sops hosts/secrets/secrets.yaml` - Edit encrypted secrets
- Age keys must be properly configured for secret access
- Secrets automatically deployed during system rebuilds