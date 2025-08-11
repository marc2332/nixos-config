{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [ inputs.fenix.overlays.default ];

  home.packages = [ pkgs.fenix.stable.toolchain ];
}
