{
  description = "marc nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-25.05";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    declarative-jellyfin.url = "github:Sveske-Juice/declarative-jellyfin";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      home-manager,
      declarative-jellyfin,
      fenix,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      packages.x86_64-linux.default = [
        fenix.packages.x86_64-linux.minimal.toolchain
      ];

      # NixOS
      nixosConfigurations = {
        laptop-hp = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            declarative-jellyfin.nixosModules.default
            ./os/configuration.nix
            ./os/laptop-hp/hardware-configuration.nix
            ./os/laptop-hp/configuration.nix
          ];
        };

        vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            declarative-jellyfin.nixosModules.default
            ./os/configuration.nix
            ./os/vm/hardware-configuration.nix
            ./os/vm/configuration.nix
            { networking.hostName = "vm"; }
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [ fenix.overlays.default ];
              }
            )
          ];
        };
      };

      # Home Manager
      homeConfigurations = {
        "marc@laptop-hp" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/home.nix ];
        };

        "marc@vm" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/home.nix ];
        };
      };
    };
}
