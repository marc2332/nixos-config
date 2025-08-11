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
}
