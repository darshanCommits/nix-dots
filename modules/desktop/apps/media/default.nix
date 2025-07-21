{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qimgv
    stremio
    easyeffects
    ani-cli
    ffsubsync
    blanket
    gapless
  ];
}
