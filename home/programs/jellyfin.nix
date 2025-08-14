{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # Desktop Client
    jellyfin-media-player
  ];
}
