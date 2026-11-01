#!/system/bin/sh

# Run as root after thermal zones are initialized. Only raise the lowest
# active/passive trip; hot and critical protection trips are left unchanged.
thermal_log()
{
	if command -v log >/dev/null 2>&1; then
		log -t thermal-trip-overrides "$*"
	else
		printf '%s\n' "thermal-trip-overrides: $*" >&2
	fi
}

set_lowest_trip()
{
	zone=$1
	target=$2
	lowest_temp=
	lowest_path=

	for temp_path in "$zone"/trip_point_*_temp; do
		[ -f "$temp_path" ] || continue

		trip=${temp_path##*/}
		trip=${trip#trip_point_}
		trip=${trip%_temp}
		type_path=$zone/trip_point_${trip}_type
		[ -r "$type_path" ] || continue

		case $(cat "$type_path") in
			active|passive) ;;
			*) continue ;;
		esac

		temp=$(cat "$temp_path")
		case $temp in
			''|*[!0-9]*) continue ;;
		esac

		if [ -z "$lowest_temp" ] || [ "$temp" -lt "$lowest_temp" ]; then
			lowest_temp=$temp
			lowest_path=$temp_path
		fi
	done

	if [ -z "$lowest_path" ]; then
		thermal_log "no writable active/passive trip found in $zone"
		return 0
	fi

	if [ "$lowest_temp" -ge "$target" ]; then
		thermal_log "$zone already has lowest eligible trip at ${lowest_temp}mC"
		return 0
	fi

	if ! printf '%s\n' "$target" > "$lowest_path"; then
		thermal_log "failed to set $lowest_path to ${target}mC"
		return 1
	fi

	thermal_log "set $lowest_path to ${target}mC (was ${lowest_temp}mC)"
}

thermal_root=${THERMAL_SYSFS_ROOT:-/sys/class/thermal}
[ -d "$thermal_root" ] || {
	thermal_log "$thermal_root is unavailable"
	exit 1
}

matched=0
failed=0

for zone in "$thermal_root"/thermal_zone*; do
	[ -r "$zone/type" ] || continue
	zone_type=$(cat "$zone/type")

	case $zone_type in
		*cpu*|*CPU*)
			target=48000
			;;
		*gpu*|*GPU*)
			target=48000
			;;
		*battery*|*Battery*|*BATTERY*)
			target=42000
			;;
		*)
			continue
			;;
	esac

	matched=$((matched + 1))
	set_lowest_trip "$zone" "$target" || failed=1
done

if [ "$matched" -eq 0 ]; then
	thermal_log "no CPU, GPU, or battery thermal zones matched"
	exit 1
fi

exit "$failed"
