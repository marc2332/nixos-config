{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];
  
  # VM <-> Host Clipboard
  services.spice-vdagentd.enable = true;
}
