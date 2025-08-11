{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../default.nix
    # Programs
    ../../programs/jellyfin.nix
    ../../programs/steam.nix
    ../../programs/solaar.nix
    ../../programs/nodejs.nix
    # Services
    ../../services/cups.nix
  ];

  networking.hostName = "pc";

  # Cups
  services.printing.enable = true;

  # Network
  networking = {
    interfaces.ens3 = {
      ipv4.addresses = [
        {
          address = "192.168.1.157";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "192.168.1.1";
      interface = "ens3";
    };
  };
}
