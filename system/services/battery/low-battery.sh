#!/usr/bin/env bash

HW_BAT_DIR="/sys/class/power_supply/BAT1"
BAT_FULL_FILE="$HW_BAT_DIR/energy_full"
BAT_NOW_FILE="$HW_BAT_DIR/energy_now"
BAT_STATUS_FILE="$HW_BAT_DIR/status"

LOW_BATTERY_THRESHOLD=20
FULLY_CHARGED_THRESHOLD=95        # Notify when battery is above 95%
STATUS_FILE="/tmp/battery_status" # Temporary file to store last battery state

get_battery_percentage() {
	if [[ ! -f "$BAT_FULL_FILE" || ! -f "$BAT_NOW_FILE" ]]; then
		return 1
	fi

	local bat_full
	local bat_now

	bat_full=$(cat "$BAT_FULL_FILE")
	bat_now=$(cat "$BAT_NOW_FILE")

	echo $(((bat_now * 100) / bat_full))
}

get_battery_status() {
	if [[ -f "$BAT_STATUS_FILE" ]]; then
		cat "$BAT_STATUS_FILE"
	else
		echo "Unknown"
	fi
}

check_battery_status() {
	local battery_percentage="$1"
	local battery_status="$2"
	local last_status

	# Check the previous status
	if [[ -f "$STATUS_FILE" ]]; then
		last_status=$(cat "$STATUS_FILE")
	else
		last_status="Unknown"
	fi

	# Low battery warning
	if [[ "$battery_percentage" -le "$LOW_BATTERY_THRESHOLD" && "$battery_status" == "Discharging" ]]; then
		notify-send -u critical "Low Battery Warning" "Battery is at ${battery_percentage}%. Please connect the charger."
	fi

	# Charger plugged in
	if [[ "$battery_status" == "Charging" && "$last_status" != "Charging" ]]; then
		notify-send "Charger Plugged In" "The charger is connected."
	fi

	# Charger unplugged
	if [[ "$battery_status" == "Discharging" && "$last_status" != "Discharging" ]]; then
		notify-send "Charger Plugged Out" "The charger is disconnected."
	fi

	# Fully charged notification
	if [[ "$battery_percentage" -ge "$FULLY_CHARGED_THRESHOLD" && "$battery_status" == "Charging" ]]; then
		notify-send "Battery Fully Charged" "Battery is at ${battery_percentage}%. You can disconnect the charger."
	fi

	# Store the current status for the next run
	echo "$battery_status" >"$STATUS_FILE"
}

main() {
	local battery_percentage
	local battery_status

	if ! battery_percentage=$(get_battery_percentage); then
		exit 1
	fi

	battery_status=$(get_battery_status)
	check_battery_status "$battery_percentage" "$battery_status"
}

main
