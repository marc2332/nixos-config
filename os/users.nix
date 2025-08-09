{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Marc
  users.users.marc = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkManager"
      "video"
    ];
    description = "Marc";
    shell = pkgs.nushell;
    initialPassword = "initialPassword";
  };
}
