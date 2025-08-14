{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Allow non-free packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ./boot.nix
    ./security.nix
    ./users.nix
    # DE
    ./desktop/gnome.nix
    # Programs
    ./programs/nh.nix
  ];

  # Other
  services.openssh.enable = true;
  hardware.graphics.enable = true;
  documentation.nixos.enable = false;

  environment.systemPackages = with pkgs; [
    # Nix formatting
    pkgs.nixfmt-rfc-style

    # Git Signing
    gnupg
    pinentry-gnome3

    # Fonts
    cascadia-code
    inter
  ];

  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "en_US.UTF-8";

  system.activationScripts.hideRootUserFromGdm.text = ''
        echo "
    [User]
    SystemAccount=true
    " > /var/lib/AccountsService/users/root
  '';

  # DO NOT CHANGE!
  system.stateVersion = "25.05";
}
