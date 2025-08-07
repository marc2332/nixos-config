{
  config,
  lib,
  pkgs,
  ...
}:

let
  gitPGP = "/home/marc/secrets/git-gpg.pgp";
in
{
  

  # Allow non-free packages
  nixpkgs.config.allowUnfree = true;


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
  
  home-manager.users.marc = {
    home.stateVersion = "25.05";

    # Nushell Shell
    programs.nushell = {
      enable = true;
      extraConfig = ''
        $env.config = {
          show_banner: false,
        }
      '';
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };

    # Helix Editor
    programs.helix = {
      enable = true;
    };

    # Folders
    home.activation.createFolders = ''
      mkdir -p ~/Projects

      mkdir -p ~/Series
      mkdir -p ~/Movies

      mkdir -p ~/Pictures
      mkdir -p ~/Videos
    '';

    
    dconf.settings = {
      "org/gnome/desktop/peripherals/touchpad" = {
        disable-while-typing = false;
      };
    };

    # Git
    

    # Git
    programs.git = {
      enable = true;
      userName = "Marc Espin";
      userEmail = "marc@mespin.me";
      signing = {
        signByDefault = true;
        key = "976B56A90E382E6D58ECD4E10C052B1BE73F39F0";
      };
    };
  };

}
