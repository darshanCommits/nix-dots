#!/usr/bin/env bash

HW_BAT_DIR="/sys/class/power_supply/BAT1"
BAT_FULL_FILE="$HW_BAT_DIR/energy_full"
BAT_NOW_FILE="$HW_BAT_DIR/energy_now"
BAT_STATUS_FILE="$HW_BAT_DIR/status"

LOW_BATTERY_THRESHOLD=20
FULLY_CHARGED_THRESHOLD=95        # Notify when battery is above 95%
STATUS_FILE="/tmp/battery_status" # Temporary file to store last battery state

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
	notify-send "$1" "$2" || echo "Failed to send notification: $1 - $2" >&2
	echo "$1"
	echo "$2"
}

if [[ "$battery_percentage" -le "$LOW_BATTERY_THRESHOLD" ]]; then
	echo 1
	send_notification "Low Battery Warning" "Battery is at $battery_percentage%. Please connect the charger."
fi

if [[ "$battery_status" == "Charging" ]]; then
	echo 2
	send_notification "Charger Plugged In" "The charger is connected."
fi

if [[ "$battery_status" == "Discharging" ]]; then
	echo 3
	send_notification "Charger Plugged Out" "The charger is disconnected."
fi

if [[ "$battery_percentage" -ge "$FULLY_CHARGED_THRESHOLD" ]]; then
	echo 4
	send_notification "Battery Fully Charged" "Battery is at $battery_percentage%. You can disconnect the charger."
fi

# Store current status for next check
echo "$battery_status" >"$STATUS_FILE"
