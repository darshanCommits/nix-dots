{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
    "float,class:^(pavucontrol)$"
    "float,class:^(feh)$"
    "float,title:^(Media viewer)$"
    "float,title:^(Volume Control)$"
    "float,class:^(Viewnior)$"
    "float,title:^(DevTools)$"
    "float,class:^(file_progress)$"
    "float,class:^(confirm)$"
    "float,class:^(dialog)$"
    "float,class:^(download)$"
    "float,class:^(notification)$"
    "float,class:^(error)$"
    "float,class:^(confirmreset)$"
    "float,title:^(Open File)$"
    "float,title:^(branchdialog)$"
    "float,title:^(Confirm to replace files)"
    "float,title:^(File Operation Progress)"
    "float, class:^(Rofi)$"
    "fullscreen, class:^(com.stremio.stremio)$"

    "float,title:^(Picture-in-picture)$"
    "pin,title:^(Picture-in-picture)$"
    "size 640 360,title:^(Picture-in-picture)$"
    "move onscreen cursor 100%-640 100%-360,title:^(Picture-in-picture)$"

    "size 50% 60%,class:^(download)$"
    "size 50% 60%,title:^(Open File)$"
    "size 50% 60%,title:^(Save File)$"
    "size 50% 60%,title:^(Volume Control)$"

    "center,title:^(Open File)$"
    "center,title:^(Save File)$"
    "center,title:^(download)$"

    "idleinhibit focus,class:^(mpv)$"
    "idleinhibit fullscreen,class:^(Brave-browser)$"

    "animation popin, class:^(Rofi)$"
    "stayfocused, class:^(Rofi)$"
  ];
}
