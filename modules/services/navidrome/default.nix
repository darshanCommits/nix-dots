{
  config,
  pkgs,
  ...
}: let
  musicDirectory = "/mnt/music";
in {
  services.navidrome = {
    enable = true;
    settings = {
      Address = config.localhost;
      Port = config.port.navidrome;
      MusicFolder = musicDirectory;
      BaseUrl = "/";
    };
  };

  fileSystems."${musicDirectory}" = {
    device = "${config.home}/Music";
    options = ["bind"];
    fsType = "none";
  };
}
