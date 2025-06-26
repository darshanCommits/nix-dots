{ config
, pkgs
, ...
}:
let
  musicDirectory = "/mnt/music";
in
{
  services.navidrome = {
    enable = true;
    settings = {
      Address = config.localhost;
      Port = config.port.navidrome;
      MusicFolder = musicDirectory;
      BaseUrl = "/";
      LastFM.ApiKey = "cb62a45e2f3075ca21d16bcb4de6cb1d";
      LastFM.Secret = "fcdd6180e8d27adb248fc9c1012ef592";
    };
  };

  fileSystems."${musicDirectory}" = {
    device = "${config.home}/Music";
    options = [ "bind" "rw" ];
    fsType = "btrfs";
  };
}
