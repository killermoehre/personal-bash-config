#!/bin/bash
# zz-custom-bash.sh
# Please place this file in /etc/profile.d/
#
# Maintainer:	danielschier84<at>gmail.com
# Comitter:	killermoehre<at>gmx.net^
# Version: 0.4

shopt -s extglob

FQDN="$(hostname -f)"
UNAME="$(uname -sr)"

declare -A CPUINFO MEMINFO
declare -a LOADAVG

#CPUINFO['processor']=1

while IFS="	:" read -r OPTION VALUE; do
	OPTION="${OPTION:=none}"
	VALUE="${VALUE:=none}"
	VALUE="${VALUE# }"
	case "${OPTION}" in
		processor)
			printf "%i\n" "${CPUINFO[processor]}"
			CPUINFO["$OPTION"]="$((CPUINFO[OPTION]++))"
			continue
			;;
		'model name')
			IFS="@" read -r CPUINFO["$OPTION"] CPUINFO['frequency'] <<< "$VALUE"
			CPUINFO["$OPTION"]="${CPUINFO["$OPTION"]% }"
			CPUINFO['frequency']="${CPUINFO['frequency']# }"
			continue
			;;
		none)
			continue
			;;
		*)
			CPUINFO[$OPTION]="${VALUE}"
			continue
			;;
	esac
done < /proc/cpuinfo

while IFS=":" read -r OPTION VALUE; do
	VALUE="${VALUE% kB}"
	declare -i MEMINFO["$OPTION"]="$VALUE"
done < /proc/meminfo

read -r -a LOADAVG < /proc/loadavg

printf ' System summary (collected %(%H:%M:%S %d.%m.%Y)T)
---------------------------------------------------------------
 Hostname		= %s
 Kernel			= %s

 CPU-Model		= %s
 CPU-Frequency		= %s
 CPU-Cores/Threads	= %i/%i

 Load (1, 5, 15)	= %s %s %s

 Memory (free)		= %i kiB
 Memory (available)	= %i kiB
 Memory (total)		= %i kiB
 Swap (free)		= %i kiB
 Swap (total)		= %i kiB
---------------------------------------------------------------\n' "$(printf '%(%s)T')" "$FQDN" "$UNAME" "${CPUINFO['model name']}" "${CPUINFO[frequency]}" "${CPUINFO['cpu cores']}" "${CPUINFO[processor]}" "${LOADAVG[0]}" "${LOADAVG[1]}" "${LOADAVG[2]}" "${MEMINFO[MemFree]}" "${MEMINFO[MemAvailable]}" "${MEMINFO[MemTotal]}" "${MEMINFO[SwapFree]}" "${MEMINFO[SwapTotal]}"
