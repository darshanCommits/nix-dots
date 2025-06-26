{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    playerctl
    wget
    ani-cli
    yt-dlp
    aria2
    ffmpegthumbnailer
    imagemagick
    tesseract
  ];
}
