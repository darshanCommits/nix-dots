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
        feh

        nemo
        nemo-python
        nemo-fileroller
        nemo-emblems

        gparted
        blanket
        brave
        localsend
        transmission_4-qt
        tofi
        zathura
        ffsubsync
        onlyoffice-bin
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
