{
  config,
  lib,
  pkgs,
  inputs,
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

  nixpkgs.overlays = [ inputs.fenix.overlays.default ];

  home.packages = with pkgs; [
    # Nix Formatting
    nixfmt-tree

    fenix.stable.toolchain
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

      $env.PROMPT_COMMAND = { ||
          let path = $env.PWD | path basename

          let cwd = $"(ansi green)($path)" 
          let name = $"(ansi yellow)@($env.USERNAME)"
          let branch = do { git branch --show-current } | complete | str trim
          let git_status = if $branch.exit_code == 0 and $branch.stdout != "" {
              $"(ansi white) ➜(ansi aqua) \u{eafe} ($branch.stdout)"
          } else {
              ""
          }
          
          let labels = (
            if ($env.SHELL_LABEL? | is-empty) {
              ""
            } else {
              let labels = $env.SHELL_LABEL
              | split row ","
              | each {|it| $"(ansi light_red) " + ($it | str trim) }
              | str join $"(ansi white) ➜"
              | str trim
              $"(ansi white) ➜($labels)"
            }
          )


          $"($cwd) (ansi white)[($name)($labels)($git_status)(ansi white)]\n"
      }

      $env.PROMPT_COMMAND_RIGHT = { ||
          ""
      }

      alias hh = cd $env.HOME
      alias cc = cd $"($env.HOME)/nixos-config"
      alias pp = cd $"($env.HOME)/Projects"
      alias ll = cat $"($env.HOME)/nixos-config/README.md"
    '';

    extraEnv = '''';
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

    mkdir -p ~/Services
    mkdir -p ~/Services/jellyfin

    cp -r /home/marc/nixos-config/wallpapers /home/marc/Wallpapers
  '';

  dconf.settings = {
    # Wallpaper
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/marc/Wallpapers/bridge";
      picture-uri-dark = "file:///home/marc/Wallpapers/bridge";
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
      ];

      # Enable GNOME Extensions
      enabled-extensions = [
        pkgs.gnomeExtensions.dash-to-dock.extensionUuid
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
