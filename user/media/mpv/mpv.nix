{
  pkgs,
  config,
  ...
}: {
  # home.packages = with pkgs; [
  #   mpv
  # ];
  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.uosc
      mpvScripts.thumbfast
      mpvScripts.autosubsync-mpv # press n
    ];
  };
}
