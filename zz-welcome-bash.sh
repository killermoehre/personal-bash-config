#!/bin/bash
# zz-custom-bash.sh
# Please place this file in /etc/profile.d/
#
# Maintainer:	danielschier84<at>gmail.com
# Comitter:	killermoehre<at>gmx.net^
# Version: 0.3
gawk '
BEGIN {
	HOSTCOMMAND="hostname -f"
	if ((HOSTCOMMAND | getline HOSTNAME) > 0) {
		close(HOSTCOMMAND)
	UNAMECOMMAND="uname -sr"
	if ((UNAMECOMMAND | getline KERNEL) > 0)
		close(UNAMECOMMAND)
	}
}

{
	if ( FILENAME == "/proc/cpuinfo" ) {
		FS=":"
		if ($1 ~ /model name/) {
			#split($2, MODEL, " ")
			#CPUMODEL = MODEL[1]" "MODEL[2]" "MODEL[3]
			sub(/^ /, "", $2)
			sub(/  .+/, "", $2)
			CPUMODEL = $2
		}
		if ($1 ~ /cpu cores/) {
			CPUCORES = $2
			CPUTHREADS++
		}
		else {
			if ($1 ~ /processor/) {
				CPUCORES++
				CPUTHREADS++
			}
		}
		if ($1 ~ /cpu MHz/) {
			gsub(/ /, "", $2)
			CPUFREQUENCY = $2 / 1000
		}
	}
	if ( FILENAME == "/proc/loadavg" ) {
		split($1, LOADAVG, " ")
	}
	if ( FILENAME == "/proc/meminfo" ) {
		FS=":"
		sub(/ kB/, "", $2)
		gsub(/ /, "", $2)
		MEMINFO[$1] = $2
	}
}

END {
	printf(" System summary (collected %s)\n\
---------------------------------------------------------------\n\
 Hostname		= %s\n\
 Kernel			= %s\n\
\n\
 CPU-Model		= %s\n\
 CPU-Frequency		= %.2f GHz\n\
 CPU-Cores/Threads	= %i/%i\n\
\n\
 Load (1, 5, 15)	= %.2f %.2f %.2f\n\
\n\
 Memory (free)		= %8i kiB\n\
 Memory (available)	= %8i kiB\n\
 Memory (total)		= %8i kiB\n\
 Swap (free)		= %8i kiB\n\
 Swap (total)		= %8i kiB\n\
---------------------------------------------------------------\n", strftime("%H:%M:%S %d.%m.%Y"), HOSTNAME, KERNEL, CPUMODEL, CPUFREQUENCY, CPUCORES, CPUTHREADS, LOADAVG[1], LOADAVG[2], LOADAVG[3], MEMINFO["MemFree"], MEMINFO["MemAvailable"], MEMINFO["MemTotal"], MEMINFO["SwapFree"], MEMINFO["SwapTotal"])
}' /proc/cpuinfo /proc/loadavg /proc/meminfo 2> /dev/null || printf "No gawk available. Can't show welcome message." >&2
