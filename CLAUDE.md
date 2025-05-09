# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands
- `nix develop` or `nix-shell` - Bootstrap development environment
- `nixos-rebuild --flake .#atom` - Build main system configuration
- `home-manager --flake .#matt@atom` - Build home-manager configuration
- `nix flake update` - Update flake inputs
- `nix flake check` - Verify flake integrity

## Code Style Guidelines
- Use attribute sets consistently for configurations
- Separate hardware-specific configuration from system configuration
- Keep related configurations together in logical sections
- Use descriptive variable names
- Mark work-in-progress with TODO comments
- Maintain separation between system packages and user packages
- Use overlays for custom package modifications
- Follow nixpkgs conventions for option naming

## Structure
- `flake.nix` - Main entry point defining inputs and outputs
- `hosts/atom/` - System configuration for main machine
- `home/` - User environment configuration
