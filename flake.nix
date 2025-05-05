{
  description = "Personal nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";

    zed-editor = {
      url = "github:zed-industries/zed/v0.185.10";
      inputs.nixpkgs.follows = "nixpkgs";
      flake = true;
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    inherit lib;
    homeManagerModules = import ./modules/home-manager;

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # NixOS configuration entrypoint
    # 'nixos-rebuild --flake .#atom'
    nixosConfigurations = {
      atom = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/atom
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.matt = import ./home/matt/atom.nix;
            };
          }
        ];
      };
    };
  };
}
