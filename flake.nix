{
  description = "marc nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-25.05";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      # NixOS
      nixosConfigurations = {
        laptop-hp = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            ./configuration.nix
            ./laptop-hp/hardware-configuration.nix
            ./laptop-hp/configuration.nix
          ];
        };

        vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            ./configuration.nix
            ./vm/hardware-configuration.nix
            ./vm/configuration.nix
            { networking.hostName = "vm"; }
          ];
        };
      };

      # Home Manager
      homeConfigurations = {
        "marc@laptop-hp" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home.nix ];
        };

        "marc@vm" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home.nix ];
        };
      };
    };
}
