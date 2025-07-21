{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.xwayland-satellite
  ];

  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Xwayland outside your Wayland";
      BindsTo = "graphical-session.target";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      Requisite = ["graphical-session.target"];
    };

    Service = {
      Type = "notify";
      NotifyAccess = "all";
      Restart = "on-failure";
      ExecStart = lib.getExe pkgs.xwayland-satellite;
      StandardOutput = "journal";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
