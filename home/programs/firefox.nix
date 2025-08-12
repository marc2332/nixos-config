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
    policies = {
      "OfferToSaveLogins" = false;
    };
    profiles = {
      "Marc" = {
        name = "Marc";
        id = 0;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        userChrome = builtins.readFile ./userChrome.css;
      };
    };
  };
}
