{...}: let
  scripts = ./scripts;
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$reset" = "hyprctl dispatch submap reset &&";
    "$center" = "pypr layout_center toggle";

    "$fm" = "thunar";
    "$tg" = "telegram-desktop";
    "$wa" = "zapzap";
    "$volume" = "pavucontrol";
  };

  wayland.windowManager.hyprland.settings.bind =
    [
      ", Print, exec, grimblast --notify copysave"

      "$mod, B, togglefloating"
      "$mod, F, fullscreen"
      "$mod, GRAVE, togglespecialworkspace"
      "$mod, Q, killactive"
      "$mod, S, togglesplit"
      "$mod, Y, togglefloating, pin"
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
      "$mod, O, exec, thunar"
      "$mod, C, exec, ${scripts/color-picker}"
      "$mod, D, exec, ${scripts/launcher}"
      "$mod, R, exec, ${scripts/get-info}"
      "$mod, X, exec, ${scripts/powermenu}"
      "$mod, V, exec, ${scripts/clipboard-manager}"
      "$mod, M, exec, tofi < ${scripts/emojilist} | cut -d ' ' -f 1 | tr -d '\\n' | wl-copy"
      "$mod, W, exec, brave"
      "$mod, Z, exec, pypr zoom"
      "$mod, return, exec, footclient"

      "ALT, Tab, cyclenext"
      "SHIFT ALT, Tab, cyclenext, prev"

      "$mod SHIFT, GRAVE, movetoworkspace, special"
      "$mod SHIFT, S, exec, ${scripts}/ocr"
    ]
    ++ builtins.concatLists (builtins.genList (x: let
        ws = builtins.toString (x + 1 - ((x + 1) / 10) * 10);
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ])
      10)
    ++ builtins.concatLists (
      builtins.attrValues (
        builtins.mapAttrs (key: value: [
          "bind=$mod, ${key}, movefocus, ${value}"
          "bind=$mod SHIFT, ${key}, movewindow, ${value}"
        ]) {
          h = "l";
          l = "r";
          j = "d";
          k = "u";
        }
      )
    );

  wayland.windowManager.hyprland.settings.binde = [
    "$mod, left, resizeactive, -10 0"
    "$mod, right, resizeactive, 10 0"
    "$mod, up, resizeactive, 0 -10"
    "$mod, down, resizeactive, 0 10"

    ", XF86AudioMute, exec, ${scripts}/volume --toggle"
    ", XF86AudioLowerVolume, exec, ${scripts}/volume --dec"
    ", XF86AudioRaiseVolume, exec, ${scripts}/volume --inc"
    ", XF86MonBrightnessDown, exec, ${scripts}/brightness --dec"
    ", XF86MonBrightnessUp, exec, ${scripts}/brightness --inc"
  ];

  wayland.windowManager.hyprland.settings.bindm = [
    "$mod, mouse:272, movewindow"
    "ALT, mouse:272, resizewindow"
  ];

  wayland.windowManager.hyprland.settings.bindl = [
    ",switch:Lid,exec,systemctl suspend"
    '',switch:on:Lid,exec,hyprctl keyword monitor "eDP-1,1920x1080@144,0x0,1.25"''
    '',switch:off:Lid,exec,hyprctl keyword monitor "eDP-1, disable"''
  ];

  # Order sensitive
  wayland.windowManager.hyprland.extraConfig = ''
    bind = $mod, space, submap, pypr

    submap = pypr

    # sets repeatable binds for resizing the active window
    bind = , B, exec, $reset blanket              #pypr toggle blanket
    bind = , W, exec, $reset $wa              #pypr toggle wa
    bind = , T, exec, $reset $tg              #pypr toggle tg
    bind = , V, exec, $reset $volume              #pypr toggle volume
    bind = , O, exec, $reset $fm              #pypr toggle fm

    # use reset to go back to the global submap
    bind = , escape, submap, reset

    submap = reset
  '';
}
