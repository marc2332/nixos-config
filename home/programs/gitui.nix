{
  pkgs,
  ...
}:

{
  home.packages = [
    (import ../../pkgs/gitui.nix { inherit pkgs; })
  ];
}
