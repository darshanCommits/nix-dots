{
  config,
  inputs,
  pkgs,
  ...
}: {
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  environment.systemPackages = with pkgs; (
    let
      genericPkgs = [
        foot
        feh
        nemo
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
