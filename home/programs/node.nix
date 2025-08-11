{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  home.file.".npmrc".text = lib.mkForce ''
    prefix=/home/marc/.npm-global
  '';

}
