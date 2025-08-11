{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
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
      alias ss = nu $"($env.HOME)/nixos-config/scripts/status.nu"

      $env.Path = ($env.Path | prepend "~/.npm-global/bin")
    '';

    extraEnv = '''';
  };
}
