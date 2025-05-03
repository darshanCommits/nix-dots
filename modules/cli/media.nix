{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    android-tools
    wget
    ani-cli
    aria2
    ffmpegthumbnailer
    imagemagick
    tesseract
  ];
}
