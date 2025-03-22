{pkgs, ...}: let
  low-battery-check = pkgs.writeShellApplication {
    name = "low-battery-check";
    runtimeInputs = with pkgs; [bash coreutils glib libnotify];
    text = ''
      #!/usr/bin/env bash

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
      FULLY_CHARGED_NOTIFIED_FILE="/tmp/battery_fully_charged_notified"

      # Create files if they don't exist
      touch "$STATUS_FILE" "$PREVIOUS_LEVEL_FILE" "$FULLY_CHARGED_NOTIFIED_FILE"

      # Make sure the battery files exist
      if [[ ! -f "$BAT_FULL_FILE" || ! -f "$BAT_NOW_FILE" ]]; then
        echo "Battery info files missing." >&2
        exit 1
      fi

      # Get battery percentage
      bat_full=$(<"$BAT_FULL_FILE")
      bat_now=$(<"$BAT_NOW_FILE")
      battery_percentage=$(((bat_now * 100) / bat_full))

      battery_status=$(<"$BAT_STATUS_FILE") || battery_status="Unknown"
      last_status=$(<"$STATUS_FILE") || last_status="Unknown"
      previous_battery_level=$(<"$PREVIOUS_LEVEL_FILE") || previous_battery_level=100
      fully_charged_notified=$(<"$FULLY_CHARGED_NOTIFIED_FILE") || fully_charged_notified="false"

      # Function to send notifications
      send_notification() {
        DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u greeed)/bus" notify-send "$1" "$2" || echo "Failed to send notification: $1 - $2" >&2
      }

      # Notify for low battery levels
      if [[ "$battery_percentage" -le "$LOW_BATTERY_THRESHOLD_10" && "$previous_battery_level" -gt "$LOW_BATTERY_THRESHOLD_10" ]]; then
        send_notification "Critical Battery Warning" "Battery is critically low at $battery_percentage%. Connect the charger immediately."
      elif [[ "$battery_percentage" -le "$LOW_BATTERY_THRESHOLD_20" && "$previous_battery_level" -gt "$LOW_BATTERY_THRESHOLD_20" ]]; then
        send_notification "Low Battery Warning" "Battery is at $battery_percentage%. Please connect the charger."
      elif [[ "$battery_percentage" -le "$LOW_BATTERY_THRESHOLD_30" && "$previous_battery_level" -gt "$LOW_BATTERY_THRESHOLD_30" ]]; then
        send_notification "Low Battery Warning" "Battery is at $battery_percentage%. Please connect the charger."
      fi

      # Notify for charging and discharging events
      if [[ "$battery_status" == "Charging" && "$last_status" != "Charging" ]]; then
        send_notification "Charger Plugged In" "The charger is connected."
        echo "false" > "$FULLY_CHARGED_NOTIFIED_FILE"  # Reset the fully charged notification flag
      elif [[ "$battery_status" == "Discharging" && "$last_status" != "Discharging" ]]; then
        send_notification "Charger Plugged Out" "The charger is disconnected."
        echo "false" > "$FULLY_CHARGED_NOTIFIED_FILE"  # Reset the fully charged notification flag
      fi

      # Notify when the battery is fully charged (only once per charging session)
      if [[ "$battery_percentage" -ge "$FULLY_CHARGED_THRESHOLD" &&
            "$battery_status" == "Charging" &&
            "$fully_charged_notified" == "false" ]]; then
        send_notification "Battery Fully Charged" "Battery is at $battery_percentage%. You can disconnect the charger."
        echo "true" > "$FULLY_CHARGED_NOTIFIED_FILE"
      fi

      # Save the current battery status and level for future checks
      echo "$battery_status" > "$STATUS_FILE"
      echo "$battery_percentage" > "$PREVIOUS_LEVEL_FILE"
    '';
  };
in {
  # Timer unit
  systemd.timers."low-battery-check" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
      Unit = "low-battery-check.service";
    };
  };

  # Service unit
  systemd.services."low-battery-check" = {
    description = "Low Battery Check Service";
    path = [pkgs.bash pkgs.coreutils pkgs.glib pkgs.libnotify];
    script = "${low-battery-check}/bin/low-battery-check";
    serviceConfig = {
      Type = "oneshot";
      User = "greeed";
      Environment = [
        "DISPLAY=:0"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
      ];
    };
  };
}
