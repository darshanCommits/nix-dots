{...}: let
  keyblight = "platform::kbd_backlight";
  mod = "SUPER";
  reset = "hyprctl dispatch submap reset &&";
  browser = "brave";
  fm = "thunar";
  tg = "telegram-desktop";
  term = "footclient";
  wa = "zapzap";
  volume = "pavucontrol";

  emojiPicker = "tofi < ${scripts/emojilist} | cut -d ' ' -f 1 | tr -d '\\n' | wl-copy";
in {
  wayland.windowManager.hyprland.settings = {
  };

  wayland.windowManager.hyprland.settings.bind =
    [
      ", Print, exec, grimblast --notify copysave"

      "${mod},  B,           togglefloating"
      "${mod},  F,           fullscreen"
      "${mod},  Q,           killactive"
      "${mod},  S,           togglesplit"
      "${mod},  Y,           togglefloating,  pin"
      "${mod},  mouse_down,  workspace,       e+1"
      "${mod},  mouse_up,    workspace,       e-1"
      "${mod},  Z,           exec,            pypr zoom"
      "${mod},  C,           exec,            ${scripts/color-picker}"
      "${mod},  D,           exec,            ${scripts/launcher}"
      "${mod},  R,           exec,            ${scripts/get-info}"
      "${mod},  X,           exec,            ${scripts/powermenu}"
      "${mod},  V,           exec,            ${scripts/clipboard-manager}"
      "${mod},  M,           exec,            ${emojiPicker}"
      "${mod},  W,           exec,            ${browser}"
      "${mod},  return,      exec,            ${term}"
      "${mod} SHIFT,S,       exec,            ${scripts/ocr}"
      "ALT, Tab, cyclenext"
      "SHIFT ALT, Tab, cyclenext, prev"

      "${mod}, GRAVE, togglespecialworkspace"
      "${mod} SHIFT, GRAVE, movetoworkspace, special"
    ]
    ++ builtins.concatLists (builtins.genList (x: let
        ws = builtins.toString (x + 1 - ((x + 1) / 10) * 10);
      in [
        "${mod},        ${ws},  workspace,        ${toString (x + 1)}"
        "${mod} Shift,  ${ws},  movetoworkspace,  ${toString (x + 1)}"
      ])
      10)
    ++ builtins.concatLists (
      builtins.attrValues (
        builtins.mapAttrs (key: value: [
          "bind=${mod},        ${key},  movefocus,   ${value}"
          "bind=${mod} Shift,  ${key},  movewindow,  ${value}"
        ]) {
          h = "l";
          l = "r";
          j = "d";
          k = "u";
        }
      )
    );

  wayland.windowManager.hyprland.settings.binde = [
    "${mod},  left,   resizeactive,  -10    0"
    "${mod},  right,  resizeactive,   10    0"
    "${mod},  up,     resizeactive,    0  -10"
    "${mod},  down,   resizeactive,    0   10"

    ",XF86AudioMute,          exec,  ${scripts/volume}      --toggle"
    ",XF86AudioLowerVolume,   exec,  ${scripts/volume}      --dec"
    ",XF86AudioRaiseVolume,   exec,  ${scripts/volume}      --inc"
    ",XF86MonBrightnessDown,  exec,  ${scripts/brightness}  --dec"
    ",XF86MonBrightnessUp,    exec,  ${scripts/brightness}  --inc"
  ];

  wayland.windowManager.hyprland.settings.bindm = [
    "${mod}, mouse:272, movewindow"
    "ALT, mouse:272, resizewindow"
  ];

  wayland.windowManager.hyprland.settings.bindl = [
    ",switch:Lid,exec,systemctl    suspend"
    ",switch:on:Lid,exec,hyprctl   keyword  monitor  \"eDP-1,  1920x1080@144,0x0,1.25\""
    ",switch:off:Lid,exec,hyprctl  keyword  monitor  \"eDP-1,  disable\" &&  brightnessctl -d  ${keyblight} s 0"
  ];

  # Order sensitive
  wayland.windowManager.hyprland.extraConfig = ''
    bind = ${mod}, space, submap, pypr

    submap = pypr

    # sets repeatable binds for resizing the active window
    bind  =  ,  B,       exec,  ${reset}  blanket
    bind  =  ,  W,       exec,  ${reset}  ${wa}
    bind  =  ,  T,       exec,  ${reset}  ${tg}
    bind  =  ,  V,       exec,  ${reset}  ${volume}
    bind  =  ,  F,       exec,  ${reset}  ${fm}
    bind  =  ,  S,       exec,  ${reset}  stremio
    bind  =  ,  return,  exec,  ${reset}  ${term} -a "scratch.term"

    # use reset to go back to the global submap
    bind  =  ,  escape,  submap,  reset

    submap = reset
  '';
}
