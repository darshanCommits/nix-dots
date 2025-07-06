{
  pkgs,
  lib,
  config,
  ...
}: let
  musicDirectory = "/mnt/music";
in {
  environment.systemPackages = [
    pkgs.picard
  ];

  services.navidrome = {
    enable = true;
    settings = {
      Address = config.localhost;
      Port = config.port.navidrome;
      MusicFolder = musicDirectory;
      EnableSharing = true;

      # BaseUrl = "/";
      LastFM.ApiKey = "cb62a45e2f3075ca21d16bcb4de6cb1d";
      LastFM.Secret = "fcdd6180e8d27adb248fc9c1012ef592";
    };
  };

  # yo this is super important. ts wont work otherwise, and i have no idea how to make it work
  systemd.services.navidrome.serviceConfig = {
    User = lib.mkForce config.username;
    Group = lib.mkForce "users";
    ProtectHome = lib.mkForce false;
  };

  fileSystems."${musicDirectory}" = {
    device = "${config.homeDir}/Music";
    options = ["bind" "rw"];
  };
}
