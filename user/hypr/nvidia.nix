{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.env = [
    "LIBVA_DRIVER_NAME, nvidia"
    "XDG_SESSION_TYPE,wayland"
    "GBM_BACKEND,nvidia-drm"
    "__GLX_VENDOR_LIBRARY_NAME, nvidia"
    "__GL_VRR_ALLOWED,1"
    "NVD_BACKEND,direct"
    "WLR_DRM_NO_ATOMIC,1"
  ];
}
