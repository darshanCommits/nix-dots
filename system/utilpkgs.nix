{
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    lsof
    pciutils # lspci
    usbutils # lsusb
    pciutils
    libnotify
    brightnessctl
    wl-clipboard
    unzip
    killall
    dig
    qalculate-qt
    wget
    git
    delta
    nh
    vim
    p7zip
    wtype
    dracula-theme
    dracula-icon-theme
    hyprlock
    hypridle
    libsForQt5.qtstyleplugin-kvantum
    android-tools
    onlyoffice-bin
    corefonts
  ];
}
