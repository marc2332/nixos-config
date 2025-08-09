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
  ];

  # VM <-> Host Clipboard
  services.spice-vdagentd.enable = true;
}
