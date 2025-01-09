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
    android-tools
    onlyoffice-bin
    corefonts
  ];
}
