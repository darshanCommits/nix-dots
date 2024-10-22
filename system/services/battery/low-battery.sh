#!/usr/bin/env bash

HW_BAT_DIR="/sys/class/power_supply/BAT1"
BAT_FULL_FILE="$HW_BAT_DIR/energy_full"
BAT_NOW_FILE="$HW_BAT_DIR/energy_now"
BAT_STATUS_FILE="$HW_BAT_DIR/status"

LOW_BATTERY_THRESHOLD=20

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

check_low_battery() {
	local battery_percentage="$1"
	local battery_status="$2"

	if [[ "$battery_percentage" -le "$LOW_BATTERY_THRESHOLD" && "$battery_status" == "Discharging" ]]; then
		notify-send -u critical "Low Battery Warning" "Battery is at ${battery_percentage}%. Please connect the charger."
	fi
}

main() {
	local battery_percentage
	local battery_status

	if ! battery_percentage=$(get_battery_percentage); then
		exit 1
	fi

	battery_status=$(get_battery_status)
	check_low_battery "$battery_percentage" "$battery_status"
}

main
