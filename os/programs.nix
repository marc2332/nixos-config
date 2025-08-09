{
  config,
  lib,
  pkgs,
  ...
}:

{

  # Firefox
  programs.firefox = {
    enable = true;
  };
  environment.etc."firefox/policies/policies.json".text = lib.mkForce ''
    {
      "policies": {
        "OfferToSaveLogins": false
      }
    }
  '';

  # Generic programs
  documentation.nixos.enable = false;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
