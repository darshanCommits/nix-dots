{ pkgs, lib, ... }:

let
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

  lowerBrightness = pkgs.writeShellScript "lower-brightness" ''
    ${brightnessctl} -s set 10
  '';

  lockSessionScript = pkgs.writeShellScript "lock-session" ''
    ${niri} msg action power-off-monitors
    ${loginctl} lock-session
    ${brightnessctl} -sd platform::kbd_backlight set 0
  '';
in
{
  services.swayidle =
    {
      enable = true;
      events = [
        { event = "before-sleep"; command = lockSessionScript.outPath; }
        {
          event = "after-resume";
          command = ''
            ${niri} msg action power-on-monitors
          '';
        }
        { event = "lock"; command = lockSessionScript.outPath; }
      ];

      timeouts = [
        { timeout = screenBlankDelay; command = lowerBrightness.outPath; }
        { timeout = suspendDelay; command = "${systemctl} suspend"; }
      ];
    };
}
