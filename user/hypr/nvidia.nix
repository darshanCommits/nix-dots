{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.env = [
    "__GLX_VENDOR_LIBRARY_NAME, nvidia"
    "LIBVA_DRIVER_NAME, nvidia"
    "__GL_VRR_ALLOWED,1"
    "WLR_DRM_NO_ATOMIC,1"
  ];
}
