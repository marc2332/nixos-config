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
    ./gnome.nix
    ./programs.nix
    ./security.nix
    ./users.nix
  ];

  # nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/marc/nixos-config";
  };

  # Other
  services.openssh.enable = true;
  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    # Remote desktop
    gnome-remote-desktop
    gnome-keyring
    gnome-session
    libsecret

    # GNOME
    gnomeExtensions.dash-to-dock

    # Nix formatting
    pkgs.nixfmt-rfc-style

    # Helix Editor
    wl-clipboard

    # VSC
    vscode

    # Git Signing
    gnupg
    pinentry-gnome3

    # Wezterm
    wezterm

    # Fonts
    cascadia-code
    inter
  ];

  # Apps I dont want
  environment.gnome.excludePackages = with pkgs; [
    cheese
    gnome-music
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-calendar
    gnome-tour
    yelp
    gn
    iagno
    hitori
    simple-scan
    geary
    epiphany
    decibels
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
