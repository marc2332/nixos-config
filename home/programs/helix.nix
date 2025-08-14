{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs.helix = {
    enable = true;
  };

  home.packages = [
    pkgs.wl-clipboard
  ];
}
