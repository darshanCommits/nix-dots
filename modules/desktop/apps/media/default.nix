{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qimgv
    stremio
    easyeffects
    feh
    ani-cli
    ffsubsync
    blanket
    gapless
  ];
}
