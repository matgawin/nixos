## Basic Usage
### Switching to a Host

To switch to a host configuration (e.g., "atom"):
```bash
sudo nixos-rebuild switch --flake .#atom
# or with nh
nh os switch -a -H atom . # add -u to update flake inputs
```
This will apply the NixOS configuration defined for the "atom" host.

### Switching Home Configuration
To switch home manager configuration for the user "matt":
```bash
home-manager switch --flake .#matt@atom
# or with nh
nh home switch -a -c matt@atom . # add -u to update flake inputs
```

---

### Testing Configuration
To verify any flake changes without applying them:
```bash
nix flake check
```

To test a configuration without switching to it:
```bash
nixos-rebuild test --flake .#atom
# or with nh
nh os test -a -H atom . # add -u to update flake inputs
```

### Building Configuration
To build a configuration without applying it (will be applied on next boot):
```bash
nixos-rebuild build --flake .#atom
# or with nh
nh os build -a -H atom . # add -u to update flake inputs
```
Or to build vm for testing:
```bash
nixos-rebuild build-vm --flake .#atom
```
then run:
```bash
QEMU_OPTS="-smp 4 -m 4096 -vga virtio" ./result/bin/run-*-vm
```
(QEMU_OPTS are for more resources)

---

## Updating the Flake
### Update Everything
To update all inputs in the flake:
```bash
nix flake update
```

### Update Specific Input
To update a specific input (e.g., nixpkgs):
```bash
nix flake update nixpkgs
```

For another example, to update the zed-editor input:
```bash
nix flake update zed-editor
```

## Modifying Configuration
### Adding a New Host

1. Create a new directory under `hosts/` for your host (e.g., `hosts/newhost/`)
2. Create a `default.nix` file in that directory with your host configuration
3. Generate a hardware configuration with `nixos-generate-config` and place it in the host directory
4. Add the host to the `nixosConfigurations` attribute in `flake.nix`:

```nix
nixosConfigurations = {
  atom = nixpkgs.lib.nixosSystem { ... };

  newhost = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [
      ./hosts/newhost
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          users.yourusername = import ./home/yourusername/newhost.nix;
        };
      }
    ];
  };
};
```

### Adding a New User Configuration

1. Create a new directory under `home/` for your user if it doesn't exist
2. Create a configuration file for your user and host (e.g., `home/yourusername/newhost.nix`)
3. Import the necessary modules and configure your home environment
4. Make sure to reference your home configuration in the host's entry in `flake.nix`

### Modifying Existing Configuration

- **System-wide settings**: Edit the relevant files in the `hosts/` directory
- **User-specific settings**: Edit the relevant files in the `home/` directory
- **Common modules**: Edit or add files in the `modules/` directory

### Working with Programs

Many programs are configured in the `home/matt/programs/` directory. To modify a program's configuration:

1. Edit the relevant file in `home/matt/programs/` or create prog directory for new user
2. For adding a new program, create a new file and import it in `home/<user>/programs/default.nix`

## Structure

```
nixos-flake/
├── flake.nix            # Main flake configuration
├── hosts/               # Host-specific configurations
│   ├── atom/            # Configuration for 'atom' host
│   └── common/          # Common configurations shared across hosts
├── home/                # Home-manager configurations
│   └── matt/            # Configuration for user 'matt'
│       ├── atom.nix
│       ├── desktop/
│       └── programs/    # Program-specific configurations
└── modules/             # Custom modules
    └── home-manager/    # Home-manager modules
```

## Formatting

You can format the Nix code with:

```bash
nix fmt
```

This uses the formatter configured in `flake.nix`.

## Notes

- This configuration uses the unstable channel of NixOS
- Home Manager is integrated directly into the system configuration
- Several custom modules are provided for home-manager