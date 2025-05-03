{...}: {
  imports = [
    ./scripts.nix
  ];

  programs.mpv.enable = true;
  programs.mpv.config = {
    osc = false;
    osd-bar = false;
    interpolation = true;
    video-sync = "display-resample";
    sub-auto = "fuzzy";
    save-position-on-quit = true;
    ignore-path-in-watch-later-config = true;
    ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
    fullscreen = "yes";
    cache = "yes";
    cursor-autohide = 3500;
    sub-font = "Ubuntu";
    sub-border-size = 1;
    sub-color = "#FFFFFF";
    sub-shadow-color = "#000000";
    sub-shadow-offset = 2;
  };
}
