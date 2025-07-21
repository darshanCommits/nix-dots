{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    walker
    rink
  ];

  systemd.user.services.walker = {
    Unit = {
      Description = "Walker launcher service";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
      Requires = "graphical-session.target";
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };

    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.walker} --gapplication-service";
      Slice = "session.slice";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
