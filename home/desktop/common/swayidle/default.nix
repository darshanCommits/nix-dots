{ pkgs, lib, ... }:

let
  # Time constants
  second = 1;
  minute = 60 * second;

  screenBlank = 15 * minute;
  lockDelay = 15 * minute;
  suspendDelay = 60 * minute;

  # Executables
  loginctl = "${pkgs.systemd}/bin/loginctl";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  hyprlock = lib.getExe pkgs.hyprlock;
  niri = lib.getExe pkgs.niri;

  # Scripts
  lockSessionScript = pkgs.writeShellScript "lock-session" ''
    ${hyprlock}
    ${niri} msg action power-off-monitors
  '';

  beforeSleepScript = pkgs.writeShellScript "before-sleep" ''
    ${loginctl} lock-session
  '';
in
{
  services.swayidle = {
    enable = true;

    events = [
      { event = "lock"; command = lockSessionScript.outPath; }
      { event = "before-sleep"; command = beforeSleepScript.outPath; }
      # { event = "after-resume"; command = "${niri} msg action power-on-monitors"; }
    ];

    timeouts = [
      { timeout = screenBlank; command = "${niri} msg action power-off-monitors"; }
      { timeout = screenBlank + lockDelay; command = "${loginctl} lock-session"; }
      { timeout = suspendDelay; command = "${systemctl} suspend"; }
    ];
  };
}
