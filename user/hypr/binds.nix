{
  ...
}: let
  scripts = ./scripts;
  emojilist = "${scripts}/emojilist"; # Path to the text file
in {
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
      "$mod, O, exec, thunar"
      "$mod, W, exec, brave"
      "$mod, return,  exec, footclient"

      ", Print, exec, grimblast --notify copysave"

      "$mod, D,  exec, ${scripts}/launcher"
      "$mod, R,  exec, ${scripts}/get-info"
      "$mod, V,  exec, ${scripts}/clipboard-manager"
      "$mod, X,  exec, ${scripts}/powermenu"
      "$mod, C,  exec, ${scripts}/color-picker"
      ''$mod, M,  exec, tofi < ${emojilist} | cut -d ' ' -f 1 | tr -d '\n' | wl-copy''
      "$mod SHIFT, S,  exec, ${scripts}/ocr"

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
    ", XF86AudioRaiseVolume, exec, ${scripts}/volume --inc"
    ", XF86AudioLowerVolume, exec, ${scripts}/volume --dec"
    ", XF86AudioMute, exec, ${scripts}/volume --toggle"

    ", XF86MonBrightnessUp , exec, ${scripts}/brightness --inc"
    ", XF86MonBrightnessDown , exec, ${scripts}/brightness --dec"

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
    ",switch:Lid,exec,systemctl suspend"
    '',switch:on:Lid,exec,hyprctl keyword monitor "eDP-1,1920x1080@144,0x0,1.25"''
    '',switch:off:Lid,exec,hyprctl keyword monitor "eDP-1, disable"''
  ];
}
