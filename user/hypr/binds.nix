{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
  };

  wayland.windowManager.hyprland.settings.bind =
    [
      "$mod, Q, killactive"
      "$mod, F, fullscreen"
      "$mod, B, togglefloating"
      "$mod, S, togglesplit"
      "$mod, Y, togglefloating, pin"
      "$mod, F, exec, firefox"
      "$mod, return, exec, footclient"
      "$mod, O, exec, thunar"
      "$mod, W, exec, brave"

      ", Print, exec, grimblast --notify copysave"

      "$mod, d,  exec, $(tofi-drun)"
      "$mod, V,  exec, cliphist list | tofi | cliphist decode | wl-copy"
      "$mod, m,  exec, cat ~/.config/hypr/emoji | tofi | cut -d ' ' -f 1 | wl-copy"
      # "$mod, x,  exec, rofi -show power-menu -modi power-menu:rofi-power-menu"
      "$mod, c,  exec, ~/.config/hypr/scripts/colorpicker"

      "ALT, Tab, cyclenext"
      "SHIFT ALT, Tab, cyclenext, prev"

      "$mod SHIFT, GRAVE, movetoworkspace, special"
      "$mod , GRAVE, togglespecialworkspace"

      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    ]
    ++ (
      builtins.concatLists (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        10)
      ++ (
        let
          moveKeys = ["h" "l" "j" "k"];
          moveDirections = ["l" "r" "d" "u"];
        in
          builtins.concatLists (builtins.genList (
              x: [
                "$mod, ${builtins.elemAt moveKeys x}, movefocus, ${builtins.elemAt moveDirections x}"
                "$mod SHIFT, ${builtins.elemAt moveKeys x}, movewindow, ${builtins.elemAt moveDirections x}"
              ]
            )
            4)
      )
    );

  wayland.windowManager.hyprland.settings.binde = [
    ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

    ", XF86MonBrightnessDown , exec, brightnessctl s $(( $(brightnessctl g) > 120 ? $(brightnessctl g) - $(brightnessctl m) / 10 : 20 ))"
    ", XF86MonBrightnessUp , exec, brightnessctl s +10%"

    "$mod, left, resizeactive, -10 0"
    "$mod, right, resizeactive, 10 0"
    "$mod, up, resizeactive, 0 -10"
    "$mod, down, resizeactive, 0 10"
  ];

  wayland.windowManager.hyprland.settings.bindm = [
    "$mod, mouse:272, movewindow"
    "ALT, mouse:272, resizewindow"
  ];

  wayland.windowManager.hyprland.settings.bindl = [
    ",switch:Lid,exec,hyprlock"
    '',switch:on:Lid,exec,hyprctl keyword monitor "eDP-1,1920x1080@144,0x0,1.25"''
    '',switch:off:Lid,exec,hyprctl keyword monitor "eDP-1, disable"''
  ];
}
