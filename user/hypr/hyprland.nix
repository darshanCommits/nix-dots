{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./binds.nix
    ./rules.nix
  ];
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.systemd.variables = ["--all"];
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    env = [
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"
    ];

    gestures = {
      workspace_swipe = true;
      workspace_swipe_distance = 200;
      #workspace_swipe_invert = true;
      workspace_swipe_min_speed_to_force = 9;
    };

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      sensitivity = 0;

      touchpad = {
        natural_scroll = true;
      };
    };

    device = {
      name = "epic-mouse-v1";
    };

    general = {
      gaps_in = 0;
      gaps_out = 1;
      allow_tearing = true;
      border_size = 1;
      no_border_on_floating = true;
      "col.active_border" = "rgb(FA584F)";
      "col.inactive_border" = "rgba(00000000)";
      layout = "dwindle";
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = false;
      vfr = true;
      animate_manual_resizes = true;
      animate_mouse_windowdragging = true;
      enable_swallow = true;
      swallow_regex = "^(foot)$";
    };

    decoration = {
      rounding = 0;
      drop_shadow = false;
    };

    animations = {
      enabled = true;
      bezier = [
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.1, 1.1, 0.1, 1.1"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
      ];
      animation = [
        "windows, 1, 2, wind, slide"
        "windowsIn, 1, 2, winIn, slide"
        "windowsOut, 1, 2, winOut, slide"
        "windowsMove, 1, 2, wind, slide"
        "fade, 1, 2, default"
        "workspaces, 1, 2, wind"
      ];
    };

    dwindle = {
      no_gaps_when_only = false;
      pseudotile = true;
      preserve_split = true;
    };

    monitor = "eDP-1,1920x1080@144,0x0,1.25";

    exec-once = [
      "systemctl --user import-environment"
      "$(which polkit-kde-authentication-agent-1)"
      "wl-paste --watch cliphist store"
      "hypridle"
      "swaybg -i ~/.dotfiles/assets/wallpapers/goatv3.jpg"
      "waybar"
      "foot --server"
      "mako"
    ];
  };
}
