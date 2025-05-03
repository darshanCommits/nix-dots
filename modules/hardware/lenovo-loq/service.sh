#!/usr/bin/env bash
set -euo pipefail
readonly FAN_CONTROL_PATH="/proc/acpi/ibm/fan"

log_message() {
	echo "$(date +'%F %T') - $1" | systemd-cat -t loq-fan-control
}

max_temp() {
	local max temp
	max=-1
	while IFS= read -r temp; do
		((temp > max)) && max=$temp
	done < <(cat /sys/class/hwmon/hwmon*/temp*_input)
	echo "$((max / 1000))"
}

determine_fan_speed() {
	local t=$1
	case $t in
	[0-2][0-9] | 3[0-4]) echo 0 ;;
	3[5-9]) echo 1 ;;
	4[0-4]) echo 2 ;;
	4[5-9]) echo 3 ;;
	5[0-4]) echo 4 ;;
	5[5-9]) echo 5 ;;
	6[0-4]) echo 6 ;;
	*) echo 7 ;;
	esac
}

prev_speed=-1
update_fan_speed() {
	local avg=$1 lvl
	lvl=$(determine_fan_speed "${avg%.*}")
	if ((prev_speed < 0 || lvl > prev_speed + 1 || lvl < prev_speed - 1)); then
		log_message "Avg temp ${avg}°C → fan level $lvl"
		echo "level $lvl" >"$FAN_CONTROL_PATH"
		prev_speed=$lvl
	fi
}

# Initialization
echo level auto >"$FAN_CONTROL_PATH"
log_message "ThinkPad fan control initialized"

# Single‐run (timer will re-invoke us)
avg=$(max_temp)
update_fan_speed "$avg"
