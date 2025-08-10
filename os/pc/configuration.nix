{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../common/jellyfin.nix
    ../common/steam.nix
    ../common/solaar.nix
    ../common/nodejs.nix
  ];

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
