{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  programs.git = {
    enable = true;
    userName = "Marc Espin";
    userEmail = "marc@mespin.me";
    signing = {
      signByDefault = true;
      key = "0C052B1BE73F39F0";
    };
  };
}
