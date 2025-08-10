{...}: {
  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
    TERMINAL = "footclient";
    VIDEO_PLAYER = "mpv";
    AUDIO_PLAYER = "mpv";
    DIRENV_LOG_FORMAT = "";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_STYLE_OVERRIDE = "";
    GDK_BACKEND = "wayland,x11,*";
    SDL_VIDEODRIVER = "wayland,x11";
    CLUTTER_BACKEND = "wayland";
    __GL_VRR_ALLOWED = 1;
    __GL_GSYNC_ALLOWED = 1;
  };
}
