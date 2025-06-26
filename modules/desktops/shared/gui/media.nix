{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    stremio
    easyeffects
    feh
    ani-cli
    ffsubsync
    blanket
    gapless
    # mpv use the HM module

  ];
}
