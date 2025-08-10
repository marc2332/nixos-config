{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../common/jellyfin.nix
    ../common/solaar.nix
    ../common/nodejs.nix
  ];

  # VM <-> Host Clipboard
  services.spice-vdagentd.enable = true;
}
