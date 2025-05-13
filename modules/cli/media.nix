{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    android-tools
    wget
    ani-cli
    yt-dlp
    aria2
    ffmpegthumbnailer
    imagemagick
    tesseract
  ];
}
