{
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

  # [Unit]
  # Description=A scrollable-tiling Wayland compositor
  # BindsTo=graphical-session.target
  # Before=graphical-session.target
  # Wants=graphical-session-pre.target
  # After=graphical-session-pre.target

  # Wants=xdg-desktop-autostart.target
  # Before=xdg-desktop-autostart.target

  # [Service]
  # Slice=session.slice
  # Type=notify
  # ExecStart=/nix/store/vgj01ziv9z1ybxms085wk57qhcc2glj9-niri-25.05.1/bin/niri --session
  # Wants=xdg-desktop-autostart.target

  systemd.user.services.niri = {
    Unit = {
      Description = "A scrollable-tiling Wayland compositor";
      BindsTo = "graphical-session.target";
      Before = [
        "graphical-session.target"
        "xdg-desktop-autostart.target"
      ];
      After = "graphical-session-pre.target";
      Wants = [
        "graphical-session-pre.target"
        "xdg-desktop-autostart.target"

        "mako.service"
        "waybar.service"
        "swaybg.service"
        "swayidle.service"
        "cliphist.service"
      ];
    };
    Service = {
      Slice = "session.slice";
      Type = "notify";
      ExecStart = "${lib.getExe pkgs.niri} --session";
    };
  };

  home.packages = with pkgs; [
    xwayland-satellite
    walker
  ];
}
