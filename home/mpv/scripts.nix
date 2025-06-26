{ pkgs, ... }: {
  imports = [
    ./scriptOpts.nix
  ];

  programs.mpv.scripts = with pkgs.mpvScripts; [
    mpris
    uosc
    thumbfast
    dynamic-crop
    autosubsync-mpv
    sponsorblock
  ];
}
