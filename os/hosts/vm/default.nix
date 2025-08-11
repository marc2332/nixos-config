{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../default.nix
    # Programs
    ../../programs/jellyfin.nix
    ../../programs/solaar.nix
    ../../programs/nodejs.nix
  ];

  networking.hostName = "vm";

  # VM <-> Host Clipboard
  services.spice-vdagentd.enable = true;

  # Boot
  boot = {
    plymouth = {
      enable = true;
      theme = "blockchain";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "blockchain" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;

  };
}
