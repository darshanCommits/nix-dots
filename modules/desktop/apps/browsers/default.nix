{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
    brave
  ];
}
