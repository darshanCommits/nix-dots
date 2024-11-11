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

      LOW_BATTERY_THRESHOLD=20
      FULLY_CHARGED_THRESHOLD=95
      STATUS_FILE="/tmp/battery_status"

      # Get battery percentage
      if [[ -f "$BAT_FULL_FILE" && -f "$BAT_NOW_FILE" ]]; then
      	bat_full=$(<"$BAT_FULL_FILE")
      	bat_now=$(<"$BAT_NOW_FILE")
      	battery_percentage=$(((bat_now * 100) / bat_full)) <"$BAT_NOW_FILE"
      else
      	echo "Battery info files missing." >&2
      	exit 1
      fi

      battery_status=$(<"$BAT_STATUS_FILE") || battery_status="Unknown"
      last_status=$(<"$STATUS_FILE") || last_status="Unknown"

      echo "$battery_percentage"
      echo "$battery_status"
      echo "$last_status"

      send_notification() {
      	${libnotify}/bin/notify-send "$1" "$2" || echo "Failed to send notification: $1 - $2" >&2
      }

      if [[ "$battery_percentage" -le "$LOW_BATTERY_THRESHOLD" ]]; then
      	send_notification "Low Battery Warning" "Battery is at $battery_percentage%. Please connect the charger."
      fi

      if [[ "$battery_status" == "Charging" ]]; then
      	send_notification "Charger Plugged In" "The charger is connected."
      fi

      if [[ "$battery_status" == "Discharging" ]]; then
      	send_notification "Charger Plugged Out" "The charger is disconnected."
      fi

      if [[ "$battery_percentage" -ge "$FULLY_CHARGED_THRESHOLD" ]]; then
      	send_notification "Battery Fully Charged" "Battery is at $battery_percentage%. You can disconnect the charger."
      fi

      echo "$battery_status" >"$STATUS_FILE"
    '';
  };
in {
  systemd.user.services.low-battery-check = {
    Unit = {
      Description = "Low Battery Check";
      StartLimitIntervalSec = 3;
      StartLimitBurst = 1;
    };
    Service = {
      Type = "simple";
      ExecStart = "${low-battery-check}/bin/low-battery-check";
    };
    Install.WantedBy = ["multi-user.target"];
  };
}
