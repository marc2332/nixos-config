{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.docker.daemon.settings = {
    data-root = "/home/marc/Services/docker";
  };
}
