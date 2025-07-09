{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;

  # Time constants
  second = 1;
  minute = 60 * second;

  screenBlankDelay = 15 * minute;
  lockDelay = screenBlankDelay * 2;
  suspendDelay = lockDelay * 2;

  # Executables
  brightnessctl = getExe pkgs.brightnessctl;
  niri = getExe pkgs.niri;
  loginctl = "${pkgs.systemd}/bin/loginctl";
  systemctl = "${pkgs.systemd}/bin/systemctl";

  swayidleScript = pkgs.writeShellScript "swayidle-power-management" ''
    ${getExe pkgs.swayidle} -w \
      timeout ${toString screenBlankDelay} '${brightnessctl} -sd platform::kbd_backlight set 0 && ${brightnessctl} -s set 10' \
      timeout ${toString suspendDelay} '${systemctl} suspend' \
      before-sleep '${brightnessctl} -sd platform::kbd_backlight set 0 && ${niri} msg action power-off-monitors && ${loginctl} lock-session' \
      after-resume '${brightnessctl} -r && ${brightnessctl} -rd platform::kbd_backlight && ${niri} msg action power-on-monitors' \
      lock '${brightnessctl} -sd platform::kbd_backlight set 0 && ${niri} msg action power-off-monitors && ${loginctl} lock-session'
  '';
in {
  home.packages = [pkgs.swayidle];

  systemd.user.services.swayidle = {
    Unit = {
      Description = "Swayidle power management daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      Requisite = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${swayidleScript}";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
