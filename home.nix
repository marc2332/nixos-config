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

  # Nushell Shell
  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config = {
        show_banner: false,
      }
    '';
  };

  # GitHub CLI
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

  # Wezterm
  home.file.".wezterm.lua".text = lib.mkForce ''
    local wezterm = require('wezterm')

    return {
      enable_scroll_bar = true,
      default_prog = { "nu" },
      color_scheme = "Brogrammer (Gogh)",
      use_fancy_tab_bar = true,
      font = wezterm.font("Cascadia Mono NF"),
      window_padding = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
      },
      window_decorations = "RESIZE",
      tab_max_width = 26,
      keys = {
        {
          key = '-',
          mods = 'ALT',
          action = wezterm.action.CloseCurrentPane { confirm = true },
        },
        {
          key = '+',
          mods = 'ALT',
          action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
          key = 'ç',
          mods = 'ALT',
          action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
          key = 'RightArrow',
          mods = 'ALT|SHIFT',
          action = wezterm.action.ActivateKeyTable {
            name = 'resize_pane',
            one_shot = false,
          },
        },
        {
          key = 'LeftArrow',
          mods = 'ALT|SHIFT',
          action = wezterm.action.ActivateKeyTable {
            name = 'resize_pane',
            one_shot = false,
          },
        },
        {
          key = 'LeftArrow',
          mods = 'ALT',
          action = wezterm.action.ActivateKeyTable {
            name = 'activate_pane',
            one_shot = false,
          },
        },
        {
          key = 'RightArrow',
          mods = 'ALT',
          action = wezterm.action.ActivateKeyTable {
            name = 'activate_pane',
            one_shot = false,
          },
        },
      },

      key_tables = {
        resize_pane = {
          {
            key = 'RightArrow',
            mods = 'ALT|SHIFT',
            action = wezterm.action.AdjustPaneSize { 'Right', 3 },
          },
          {
            key = 'LeftArrow',
            mods = 'ALT|SHIFT',
            action = wezterm.action.AdjustPaneSize { 'Left', 3 },
          },
        {
            key = 'UpArrow',
            mods = 'ALT|SHIFT',
            action = wezterm.action.AdjustPaneSize { 'Up', 3 },
          },
          {
            key = 'DownArrow',
            mods = 'ALT|SHIFT',
            action = wezterm.action.AdjustPaneSize { 'Down', 3 },
          }

        },
        activate_pane = {
          {
            key = 'RightArrow',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection 'Right',
          },
          {
            key = 'LeftArrow',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection 'Left' ,
          },
        {
            key = 'UpArrow',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection 'Up',
          },
          {
            key = 'DownArrow',
            mods = 'ALT',
            action = wezterm.action.ActivatePaneDirection 'Down' ,
          }
        },
      },
      inactive_pane_hsb = {
        saturation = 1,
        brightness = 1,
      }
    }
  '';

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
  programs.git = {
    enable = true;
    userName = "Marc Espin";
    userEmail = "marc@mespin.me";
    signing = {
      signByDefault = true;
      key = "0C052B1BE73F39F0";
    };
  };

  home.stateVersion = "25.05";
}
