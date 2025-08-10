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
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { inherit system; };
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

      devShells.x86_64-linux = with pkgs; {
        default =
          let
            toolchain =
              (fenix.packages.x86_64-linux.fromToolchainName {
                name = "stable";
                sha256 = "+9FmLhAOezBZCOziO0Qct1NOrfpjNsXxc/8I0c7BdKE=";
              }).toolchain;
          in
          mkShell {
            packages = [ toolchain ];

            shellHook = ''
              if [[ -n "$SHELL_LABEL" ]]; then
                  export SHELL_LABEL="''${SHELL_LABEL},rust-stable"
              else
                  export SHELL_LABEL="rust-stable"
              fi
              exec nu
            '';
          };

        "rust-185" =
          let
            toolchain =
              (fenix.packages.x86_64-linux.fromToolchainName {
                name = "1.85";
                sha256 = "Hn2uaQzRLidAWpfmRwSRdImifGUCAb9HeAqTYFXWeQk=";
              }).toolchain;
          in
          mkShell {
            packages = [ toolchain ];

            shellHook = ''
              if [[ -n "$SHELL_LABEL" ]]; then
                  export SHELL_LABEL="''${SHELL_LABEL},rust-1.85"
              else
                  export SHELL_LABEL="rust-1.85"
              fi
              exec nu
            '';
          };
      };
    };
}
