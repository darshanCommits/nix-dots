{
  pkgs,
  config,
  lib,
  ...
}: let
  swaync = pkgs.unstable.swaynotificationcenter;
in {
  home.packages = [
    swaync
    pkgs.libnotify
  ];

  systemd.user.services.swaync = {
    Unit = {
      Description = "Swaync notification daemon";
      Documentation = "https://github.com/ErikReider/SwayNotificationCenter";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      Requisite = ["graphical-session.target"];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };

    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${lib.getExe swaync}";
      Restart = "on-failure";
    };

    Install.WantedBy = [config.wayland.systemd.target];
  };
}
