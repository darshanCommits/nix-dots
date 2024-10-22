{...}: let
  script = ./low-battery; # Path to the low-battery check script
in {
  systemd.services.low-battery-check = {
    description = "Low Battery Check";
    serviceConfig = {
      Type = "simple";
      ExecStart = script;
    };
  };

  systemd.timers.low-battery-check = {
    description = "Timer for Low Battery Check";
    timerConfig = {
      OnCalendar = "*:0/5"; # Every 5 minutes
    };
    wantedBy = ["timers.target"];
  };
}
