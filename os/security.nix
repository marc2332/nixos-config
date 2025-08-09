{
  config,
  lib,
  pkgs,
  ...
}:

{
  # GNOME Keyring
  services.gnome.gnome-keyring = {
    enable = true;
  };
  security.pam.services.login.enableGnomeKeyring = true;

  # Firewall
  networking.firewall.allowedTCPPorts = [
    # RDP
    3389
    # SSH
    22
  ];
  networking.firewall.allowedUDPPorts = [
    3389
    22
  ];
}
