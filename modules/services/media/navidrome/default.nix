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
      LastFM.ApiKey = config.sops.secrets."LastFM.ApiKey".path;
      LastFM.Secret = config.sops.secrets."LastFM.Secret".path;
    };
  };

  # yo this is super important. ts wont work otherwise, and i have no idea how to make it work
  # how to make
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
