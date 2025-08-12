{ pkgs, ... }:

{
  imports = [
    ./external/thunderbird.nix
  ];

  accounts.email.accounts = {
    "mespinsanz@gmail.com" = {
      address = "mespinsanz@gmail.com";
      userName = "mespinsanz@gmail.com";
      realName = "Marc Espin Sanz";
      primary = true;
      imap.host = "imap.gmail.com";
      imap.port = 993;
      imap.tls.enable = true;
      aerc.imapAuth = "xoauth2";
      thunderbird-extra = {
        enable = true;
        profiles = [ "Marc" ];
      };
    };
    "marcespin@proton.me" = {
      address = "marcespin@proton.me";
      userName = "marcespin@proton.me";
      realName = "Marc Espin Sanz";
      imap.host = "127.0.0.1";
      imap.port = 1143;
      imap.tls.useStartTls = true;
      smtp.host = "127.0.0.1";
      smtp.port = 1025;
      thunderbird-extra = {
        enable = true;
        profiles = [ "Marc" ];
      };
    };
  };

  # Thunderbird
  programs.thunderbird-extra = {
    enable = true;
    profiles = {
      "Marc" = {
        isDefault = true;
        absolutePath = "/home/marc/Services/thunderbird/Marc";
      };
    };
  };

  # Proton Mail Bridge
  home.packages = with pkgs; [
    protonmail-bridge
  ];

  systemd.user.services.protonmail-bridge = {
    Unit = {
      Description = "Start Proton Mail Bridge";
      PartOf = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      Environment = [
        "XDG_CONFIG_HOME=/home/marc/Services/protonmail-bridge/config"
        "XDG_CACHE_HOME=/home/marc/Services/protonmail-bridge/cache"
        "XDG_DATA_HOME=/home/marc/Services/protonmail-bridge/data"
      ];
      ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive";
      Restart = "on-failure";
    };
  };
}
