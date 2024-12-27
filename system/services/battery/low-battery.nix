{pkgs, ...}: let
  inherit (pkgs) writeShellApplication libnotify;

  low-battery-check = writeShellApplication {
    name = "low-battery-check";
    runtimeInputs = with pkgs; [bash coreutils glib.bin libnotify];
    text = ''
      HW_BAT_DIR="/sys/class/power_supply/BAT1"
      BAT_FULL_FILE="$HW_BAT_DIR/energy_full"
      BAT_NOW_FILE="$HW_BAT_DIR/energy_now"
      BAT_STATUS_FILE="$HW_BAT_DIR/status"

      LOW_BATTERY_THRESHOLD_10=10
      LOW_BATTERY_THRESHOLD_20=20
      LOW_BATTERY_THRESHOLD_30=30
      FULLY_CHARGED_THRESHOLD=95
      STATUS_FILE="/tmp/battery_status"
      PREVIOUS_LEVEL_FILE="/tmp/battery_level"

      # Get battery percentage
      if [[ -f "$BAT_FULL_FILE" && -f "$BAT_NOW_FILE" ]]; then
        bat_full=$(<"$BAT_FULL_FILE")
        bat_now=$(<"$BAT_NOW_FILE")
        battery_percentage=$(((bat_now * 100) / bat_full))
      else
        echo "Battery info files missing." >&2
        exit 1
      fi

      battery_status=$(<"$BAT_STATUS_FILE") || battery_status="Unknown"
      last_status=$(<"$STATUS_FILE") || last_status="Unknown"
      previous_battery_level=$(<"$PREVIOUS_LEVEL_FILE") || previous_battery_level=100

      echo "$battery_percentage"
      echo "$battery_status"
      echo "$last_status"

      send_notification() {
        ${libnotify}/bin/notify-send "$1" "$2" || echo "Failed to send notification: $1 - $2" >&2
      }

      # Notify for low battery levels
      if [[ "$battery_percentage" -le "$LOW_BATTERY_THRESHOLD_30" && "$previous_battery_level" -gt "$LOW_BATTERY_THRESHOLD_30" ]]; then
        send_notification "Low Battery Warning" "Battery is at $battery_percentage%. Please connect the charger."

      elif [[ "$battery_percentage" -le "$LOW_BATTERY_THRESHOLD_20" && "$previous_battery_level" -gt "$LOW_BATTERY_THRESHOLD_20" ]]; then
        send_notification "Low Battery Warning" "Battery is at $battery_percentage%. Please connect the charger."
      elif [[ "$battery_percentage" -le "$LOW_BATTERY_THRESHOLD_10" && "$previous_battery_level" -gt "$LOW_BATTERY_THRESHOLD_10" ]]; then
        send_notification "Critical Battery Warning" "Battery is critically low at $battery_percentage%. Connect the charger immediately."
      fi

      # Notify for charging and discharging events
      if [[ "$battery_status" == "Charging" && "$last_status" != "Charging" ]]; then
        send_notification "Charger Plugged In" "The charger is connected."
      elif [[ "$battery_status" == "Discharging" && "$last_status" != "Discharging" ]]; then
        send_notification "Charger Plugged Out" "The charger is disconnected."
      fi

      # Notify when the battery is fully charged
      if [[ "$battery_percentage" -ge "$FULLY_CHARGED_THRESHOLD" ]]; then
        send_notification "Battery Fully Charged" "Battery is at $battery_percentage%. You can disconnect the charger."
      fi

      # Save the current battery status and level for future checks
      echo "$battery_status" >"$STATUS_FILE"
      echo "$battery_percentage" >"$PREVIOUS_LEVEL_FILE"
    '';
  };
in {
  # Timer unit
  systemd.timers."low-battery-check" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "1min"; # Run 1 minute after boot
      OnUnitActiveSec = "1min"; # Run every minute thereafter
      Unit = "low-battery-check.service";
    };
  };

  # Service unit
  systemd.services."low-battery-check" = {
    script = ''
      set -eu
      ${low-battery-check}
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "greeed"; # Using the same user as in your cron job
    };
  };
}
