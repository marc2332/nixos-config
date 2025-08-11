{ pkgs, ... }:

{
  accounts.email.accounts = {
    "mespinsanz@gmail.com" = {
      address = "mespinsanz@gmail.com";
      userName = "mespinsanz@gmail.com";
      realName = "Marc Espin Sanz";
      primary = true;
      imap.host = "imap.gmail.com";
      imap.port = 993;
      imap.tls.enable = true;
      thunderbird = {
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
      thunderbird = {
        enable = true;
        profiles = [ "Marc" ];
      };
    };
  };

  # Thunderbird
  programs.thunderbird = {
    enable = true;
    profiles = {
      "Marc" = {
        isDefault = true;
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
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive";
      Restart = "yes";
    };
  };
}
