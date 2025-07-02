{ config, lib, pkgs, ... }: {
  imports = [
    ./../common/hyprlock
    ./../common/swayidle
    ./../common/waybar
    ./../common/mako
    ./../common/quickshell

    ./../common/swaybg
  ];

  services.swayidle.systemdTarget = lib.mkForce "niri.service";
  systemd.user.services.swayidle.Unit.After = lib.mkForce "niri.service";

  systemd.user.services.niri =
    {
      Service = {
        Slice = "session.slice";
        Type = "notify";
        ExecStart = "${lib.getExe pkgs.niri} --session";
      };

      Unit = {
        Description = "A scrollable-tiling Wayland compositor";
        BindsTo = "graphical-session.target";
        Before = [ "graphical-session.target" "xdg-desktop-autostart.target" ];
        After = "graphical-session-pre.target";
        Wants = [
          "xdg-desktop-autostart.target"
          "graphical-session-pre.target"
          "graphical-session-pre.target"

          "mako.service"
          "waybar.service"
          "swaybg.service"
        ];
      };
    };


  home.packages = with pkgs; [
    xwayland-satellite
  ];


}
