{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    dig
    exiftool
    glxinfo
    killall
    lsof
    p7zip
    pciutils
    stress-ng
    unrar
    unzip
    usbutils
    libnotify
    poppler
    webp-pixbuf-loader
    qalculate-qt
    systemdUkify
  ];
}
