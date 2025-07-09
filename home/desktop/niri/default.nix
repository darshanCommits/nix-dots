{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./../common/hyprlock
    ./../common/mako
    ./../common/swayidle
    ./../common/waybar
    ./../common/swaybg
  ];

  systemd.user.services.niri = {
    Service = {
      Slice = "session.slice";
      Type = "notify";
      ExecStart = "${lib.getExe pkgs.niri} --session";
    };

    Unit = {
      Description = "A scrollable-tiling Wayland compositor";
      BindsTo = "graphical-session.target";
      Before = ["graphical-session.target" "xdg-desktop-autostart.target"];
      After = "graphical-session-pre.target";
      Wants = [
        "xdg-desktop-autostart.target"
        "graphical-session-pre.target"
        "graphical-session-pre.target"

        "mako.service"
        "waybar.service"
        "swaybg.service"
        "swayidle.service"
      ];
    };
  };

  home.packages = with pkgs; [
    xwayland-satellite
    walker
  ];
}
