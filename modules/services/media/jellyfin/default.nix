{
  config,
  pkgs,
  ...
}: let
  musicDirectory = "/mnt/music";
  tvShowDirectory = "/mnt/shows";
  movieDirectory = "/mnt/movies";
  animeDirectory = "/mnt/anime";
in {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    # user = config.username;
  };

  environment.systemPackages = [
    pkgs.jellyfin-mpv-shim
    pkgs.jellyfin-tui
  ];

  fileSystems = {
    ${musicDirectory} = {
      device = "${config.homeDir}/Music";
      options = ["bind" "rw"];
    };
    ${movieDirectory} = {
      device = "${config.homeDir}/Videos/movies";
      options = ["bind" "rw"];
    };
    ${tvShowDirectory} = {
      device = "${config.homeDir}/Videos/tv-shows";
      options = ["bind" "rw"];
    };
    ${animeDirectory} = {
      device = "${config.homeDir}/Videos/anime";
      options = ["bind" "rw"];
    };
  };
}
