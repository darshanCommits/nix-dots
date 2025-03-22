{
  config,
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    foot
    feh

    gparted
    blanket
    brave

    inputs.zen-browser.packages.${pkgs.system}.default

    localsend
    qbittorrent
    tofi
    zathura
    renpy

    ffsubsync

    onlyoffice-bin

    telegram-desktop
    vesktop

    element-desktop
    thunderbird-latest
    nicotine-plus
    stremio
    mpv
  ];
}
