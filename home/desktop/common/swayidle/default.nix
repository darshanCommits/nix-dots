{
  pkgs,
  lib,
  ...
}: let
  # Time constants
  second = 1;
  minute = 60 * second;

  screenBlankDelay = 15 * minute;
  lockDelay = screenBlankDelay * 2;
  suspendDelay = lockDelay * 2;

  # Executables
  loginctl = "${pkgs.systemd}/bin/loginctl";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  brightnessctl = lib.getExe pkgs.brightnessctl;
  niri = lib.getExe pkgs.niri;

  lowerBrightness = ''
    ${brightnessctl} -sd platform::kbd_backlight set 0
    ${brightnessctl} -s set 10
  '';

  lockSessionScript = ''
    ${brightnessctl} -sd platform::kbd_backlight set 0
    ${niri} msg action power-off-monitors
    ${loginctl} lock-session
  '';

  screenOn = ''
    ${brightnessctl} -r
    ${brightnessctl} -rd platform::kbd_backlight
    ${niri} msg action power-on-monitors
  '';

  suspend = ''
    ${systemctl} suspend
  '';
in {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = lockSessionScript;
      }
      {
        event = "after-resume";
        command = screenOn;
      }
      {
        event = "lock";
        command = lockSessionScript;
      }
    ];

    timeouts = [
      {
        timeout = screenBlankDelay;
        command = lowerBrightness;
      }
      {
        timeout = suspendDelay;
        command = suspend;
      }
    ];
  };
}
