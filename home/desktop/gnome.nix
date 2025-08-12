{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  dconf.settings = {
    # Wallpaper
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/marc/wallpapers/sky.jpg";
      picture-uri-dark = "file:///home/marc/wallpapers/sky.jpg";
    };
    # Peripherals
    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
    };
    # Shell
    "org/gnome/shell" = {
      # Dock apps
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "org.wezfurlong.wezterm.desktop"
        "org.gnome.Nautilus.desktop"
        "thunderbird.desktop"
      ];

      # Enable GNOME Extensions
      enabled-extensions = [
        pkgs.gnomeExtensions.dash-to-dock.extensionUuid
        pkgs.gnomeExtensions.rounded-window-corners-reborn.extensionUuid
      ];
    };
    # Desktop Preferences
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };
    # Desktop Keybinds
    "org/gnome/desktop/wm/keybinds" = {
      show-desktop = "['<Super>d']";
    };
    # Dash To Dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      dash-max-icon-size = 30;
      show-trash = false;
      always-center-icons = false;
      dock-position = "LEFT";
      dock-fixed = true;
      extend-height = true;
      scroll-action = "cycle-windows";
      click-action = "focus-minimize-or-previews";
      ustom-theme-shrink = true;
    };
  };
}
