{
  config,
  inputs,
  pkgs,
  ...
}: {
  # Thunar config
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  environment.packages = with pkgs; (
    let
      genericPkgs = [
        gparted
        feh
        blanket
        brave
        inputs.ghostty.packages.${pkgs.system}.ghostty
        localsend
        transmission_4-qt
      ];
      messagingPkgs = [
        telegram-desktop
        zapzap
      ];
      mediaPkgs = [
        stremio
      ];
    in
      genericPkgs
      ++ messagingPkgs
      ++ mediaPkgs
  );
}
