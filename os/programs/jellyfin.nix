{ pkgs, ... }:

{
  services.declarative-jellyfin = {
    enable = true;

    system = {
      cachePath = "/home/marc/Services/jellyfin/cache";
    };
    encoding = {
      enableHardwareEncoding = true;
    };
    libraries = {
      Movies = {
        enabled = true;
        contentType = "movies";
        pathInfos = [ "/data/Movies" ];
        typeOptions.Movies = {
          metadataFetchers = [
            "The Open Movie Database"
            "TheMovieDb"
          ];
          imageFetchers = [
            "The Open Movie Database"
            "TheMovieDb"
          ];
        };
      };
      Shows = {
        enabled = true;
        contentType = "tvshows";
        pathInfos = [ "/data/Shows" ];
      };
    };

    users = {
      marc = {
        mutable = false;
        password = "marc";
        permissions = {
          isAdministrator = true;
        };
      };
    };
  };
}
