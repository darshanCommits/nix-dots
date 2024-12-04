# i was bored so i wrote functions in nix to assert dominance.
{...}: let

  isTitle = isTitle: app: 
    if isTitle
    then "title:^(${app})$"
    else "class:^(${app})$";
  compose = rules: isTitleVal: app: map (rule: "${rule}, ${(isTitle isTitleVal app)}") rules;

in {
  wayland.windowManager.hyprland.settings.windowrulev2 =
    [
      "opacity 0.0 override, class:^(xwaylandvideobridge)$"
      "noanim, class:^(xwaylandvideobridge)$"
      "noinitialfocus, class:^(xwaylandvideobridge)$"
      "maxsize 1 1, class:^(xwaylandvideobridge)$"
      "noblur, class:^(xwaylandvideobridge)$"

      "float,title:^(Picture-in-picture)$"
      "pin,title:^(Picture-in-picture)$"
      "size 640 360,title:^(Picture-in-picture)$"
      "move onscreen cursor 100%-640 100%-360,title:^(Picture-in-picture)$"

      "idleinhibit focus,class:^(mpv)$"
      "idleinhibit fullscreen,class:^(brave-browser)$"

      "animation popin, class:^(Rofi)$"
      "stayfocused, class:^(Rofi)$"
    ]
    ++ ([
      "org.pulseaudio.pavucontrol"
      "thunar"
      "com.rafaelmardojai.Blanket"
      "scratch.term"
      "com.rtosta.zapzap"
      "org.telegram.desktop"
      "com.stremio.stremio"
      "feh"
      ] |> builtins.concatMap (compose ["float" "center" "size 90% 90%" ] false)) # mimic scratchpads
    ++ ([
      "org.kde.polkit-kde-authentication-agent-1"
      "pavucontrol"
      "Viewnior"
      "file_progress"
      "confirm"
      "dialog"
      "notification"
      "error"
      "confirmreset"
      "Rofi" 
      ] |> builtins.concatMap (compose ["float" "center"] false)) # for centered things with client deciding size
    ++ ([
      "Media viewer"
      "Volume Control"
      "DevTools"
      "Open"
      "branchdialog"
      "Confirm to replace files"
      "File Operation Progress"
      "xdg-desktop-portal-gtk" 
      ] |> builtins.concatMap (compose ["float" "center" "size 40% 60%"] false)) # for centered things

    ++ ([
      "download"
      "Open File"
      "Save File"
      "Volume Control" 
      "Sign in – Google accounts - Brave"
      ] |> builtins.concatMap (compose ["float" "center" "size 40% 60%"] true)) # title: outliers, same as above 
    ;
}
