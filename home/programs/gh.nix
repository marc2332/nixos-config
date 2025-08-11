{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
