# === media.nix ===
# Media processing, downloading, and manipulation tools
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Media control and playback
    playerctl # media player control

    # Download tools
    wget # web downloader
    yt-dlp # video downloader
    ani-cli # anime streaming CLI
    aria2 # advanced downloader

    # Media processing
    ffmpegthumbnailer # video thumbnails
    imagemagick # image processing

    # OCR and document processing
    tesseract # OCR engine
    poppler # PDF utilities
    webp-pixbuf-loader # WebP image support
  ];
}
