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
    ../../programs/steam.nix
  ];

  networking.hostName = "laptop-hp";

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

  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    powerManagement.enable = true;
    nvidiaSettings = true;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Other
  services.libinput.touchpad.disableWhileTyping = false;

  # Network
  networking = {
    interfaces.ens3 = {
      ipv4.addresses = [
        {
          address = "192.168.1.156";
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
