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
    config = {
      vo = "gpu-next";
      gpu-api = "vulkan";
      gpu-context = "waylandvk";
      hwdec = "nvdec";
      profile="gpu-hq";
      save-position-on-quit = true;
      keep-open="yes";
    };
    scripts = with pkgs; [
      mpvScripts.uosc
      mpvScripts.thumbfast
      mpvScripts.autosubsync-mpv # press n
    ];
  };
}
