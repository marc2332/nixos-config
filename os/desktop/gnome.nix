{
  config,
  lib,
  pkgs,
  ...
}:

{
  # GNOME
  services.xserver = {
    enable = true;
    xkb.layout = "es";
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;
  };
  services.displayManager.defaultSession = "gnome";
  services.displayManager.sessionPackages = [ pkgs.gnome-session.sessions ];
  # GNOME Remote Desktop
  services.gnome.gnome-remote-desktop.enable = true;
  systemd.services.gnome-remote-desktop = {
    wantedBy = [ "graphical.target" ];
  };

  xdg = {
    mime.enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common = {
        "default" = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Access" = [ "gtk" ];
        "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    # Remote desktop
    gnome-remote-desktop
    gnome-keyring
    gnome-session
    libsecret

    # Extensions
    gnomeExtensions.dash-to-dock
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

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
