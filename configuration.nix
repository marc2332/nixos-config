{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Allow non-free packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ./jellyfin.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Other
  services.openssh.enable = true;
  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    # Remote desktop
    gnome-remote-desktop
    gnome-keyring
    gnome-session
    libsecret

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
  ];

  # Users
  users.users.marc = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkManager"
      "video"
    ];
    description = "Marc";
    shell = pkgs.nushell;
    initialPassword = "initialPassword";
  };

  # Firefox
  programs.firefox = {
    enable = true;
  };
  environment.etc."firefox/policies/policies.json".text = lib.mkForce ''
    {
      "policies": {
        "OfferToSaveLogins": false
      }
    }
  '';

  # Generic programs
  documentation.nixos.enable = false;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # Root User
  home-manager.users.root = {
    home.stateVersion = "25.05";
    programs = {
      helix.enable = true;
    };
  };

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
  # GNOME Keyring
  services.gnome.gnome-keyring = {
    enable = true;
  };
  security.pam.services.login.enableGnomeKeyring = true;

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

  #  networking.networkmanager.enable = true;
  #  networking.useDHCP = true;
  #networking.wireless.enable = true;
  # services.networking.dhcpcd.enable = false;

  #boot.loader.systemd-boot.enable = true;

  #boot.loader.grub.device = "nvme0n1";

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
