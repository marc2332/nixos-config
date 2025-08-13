{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    # DE
    ./desktop/gnome.nix
    # Mail
    ./mail.nix
    # Programs
    ./programs/fenix.nix
    ./programs/gh.nix
    ./programs/git.nix
    ./programs/hx.nix
    ./programs/node.nix
    ./programs/nushell.nix
    ./programs/wezterm.nix
    ./programs/firefox.nix
    ./programs/gitui.nix
  ];

  # Allow non-free packages
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "marc";
    homeDirectory = "/home/marc";
  };

  home.packages = with pkgs; [
    # Nix Formatting
    nixfmt-tree
  ];

  # Home Manager
  programs.home-manager.enable = true;

  # Folders
  home.activation.createFolders = ''
    mkdir -p ~/Projects

    mkdir -p ~/Series
    mkdir -p ~/Movies

    mkdir -p ~/Services/docker    
    mkdir -p ~/Services/jellyfin
    mkdir -p ~/Services/protonmail-bridge
    mkdir -p ~/Services/thunderbird/Marc

    cp -r /home/marc/nixos-config/wallpapers /home/marc
  '';

  home.stateVersion = "25.05";
}
