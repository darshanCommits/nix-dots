{
  config,
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; (
    let
      genericPkgs = [
        foot
        oculante
        gparted
        feh
        blanket
        brave
        localsend
        transmission_4-qt
        tofi
        zathura
        ffsubsync
      ];
      messagingPkgs = [
        telegram-desktop
        zapzap
      ];
      mediaPkgs = [
        stremio
        mpv
      ];
    in
      genericPkgs
      ++ messagingPkgs
      ++ mediaPkgs
  );
}
