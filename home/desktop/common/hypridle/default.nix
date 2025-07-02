{ config, lib, ... }:

let
  inherit (lib) mkIf;

  compositor = "hyprland";

  cfg = {
    hyprland = {
      lock = "pidof hyprlock || hyprlock";
      beforeSleep = "loginctl lock-session";
      afterSleep = "hyprctl dispatch dpms on";
      screenOff = "hyprctl dispatch dpms off";
      screenOn = "hyprctl dispatch dpms on";
    };

    niri = {
      lock = "pidof hyprlock || hyprlock";
      beforeSleep = "loginctl lock-session";
      afterSleep = "swaymsg \"output * power on\"";
      screenOff = "swaymsg \"output * power off\"";
      screenOn = "swaymsg \"output * power on\"";
    };
  };

  commands = cfg.${compositor} or (throw "Unsupported compositor: ${compositor}");
in
{
  config = mkIf (compositor == "hyprland") {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = commands.lock;
          before_sleep_cmd = commands.beforeSleep;
          after_sleep_cmd = commands.afterSleep;
        };

        listeners = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 150;
            on-timeout = "brightnessctl -sd platform::kbd_backlight set 0";
            on-resume = "brightnessctl -rd platform::kbd_backlight";
          }
          {
            timeout = 300;
            on-timeout = commands.beforeSleep;
          }
          {
            timeout = 330;
            on-timeout = commands.screenOff;
            on-resume = commands.screenOn;
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
