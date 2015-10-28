#!/bin/bash -i
# zz-custom-bash.sh
# Please place this file in /etc/profile.d/
#
# Maintainer: danielschier84<at>gmail.com
# Comitter:   killermoehre<at>gmx.net^
# Version: 0.4

# make $COLUMNS available in script
shopt -s checkwinsize
kill -s WINCH $$

# set advanced glob options
shopt -s extglob

function remove_whitespace () {
    local INPUT="$1"
    local INPUT2=""
    until [ "$INPUT" = "$INPUT2" ]; do
        INPUT2="$INPUT"
        INPUT="${INPUT/ /}"
    done
    printf '%s' "$INPUT"
}

function draw_full_line () {
    local -i i=0
    COLUMNS="${COLUMNS:=80}"
    until [[ "$i" -ge "$COLUMNS" ]]; do
        printf '-'
        i+=1
    done
    printf '\n'
}

FQDN="$(hostname -f)"
UNAME="$(uname -sr)"

printf ' System summary (current time %(%H:%M:%S %d.%m.%Y)T))\n'
draw_full_line "$COLUMNS"

# create on the fly arrays named after the options in /proc/cpuinfo and fill
#+them with the values from each CPU 
declare -a CPU_OPTIONS
while IFS="	:" read -r CPU_OPTION CPU_VALUE; do
    CPU_OPTION="${CPU_OPTION^^*}"
    CPU_OPTION="$(remove_whitespace "$CPU_OPTION")"
    CPU_OPTIONS+=("${CPU_OPTION:=none}")
    declare -a "$CPU_OPTION"
    CPU_VALUE="${CPU_VALUE:=none}"
    CPU_VALUE="${CPU_VALUE# }"
    declare "$CPU_OPTION+=( \"$CPU_VALUE\" )"
done < /proc/cpuinfo

declare -i -A MEMINFO
while IFS=":" read -r MEM_OPTION MEM_VALUE; do
    MEM_VALUE="${MEM_VALUE% kB}"
    MEMINFO["$MEM_OPTION"]="$MEM_VALUE"
done < /proc/meminfo

read -r -a LOADAVG < /proc/loadavg

draw_full_line "$COLUMNS"
#~ for OPTION in "${OPTIONS[@]}"; do
	#~ echo "${!OPTION[@]}"
#~ done

#~ printf ' System summary (collected %(%H:%M:%S %d.%m.%Y)T)
#~ ---------------------------------------------------------------
 #~ Hostname       = %s
 #~ Kernel         = %s

 #~ CPU-Model      = %s
 #~ CPU-Frequency      = %s
 #~ CPU-Cores/Threads  = %i/%i

 #~ Load (1, 5, 15)    = %s %s %s

 #~ Memory (free)      = %i kiB
 #~ Memory (available) = %i kiB
 #~ Memory (total)     = %i kiB
 #~ Swap (free)        = %i kiB
 #~ Swap (total)       = %i kiB
#~ ---------------------------------------------------------------\n' "$(printf '%(%s)T')" "$FQDN" "$UNAME" "${CPUINFO['model name']}" "${CPUINFO[frequency]}" "${CPUINFO['cpu cores']}" "${CPUINFO[processor]}" "${LOADAVG[0]}" "${LOADAVG[1]}" "${LOADAVG[2]}" "${MEMINFO[MemFree]}" "${MEMINFO[MemAvailable]}" "${MEMINFO[MemTotal]}" "${MEMINFO[SwapFree]}" "${MEMINFO[SwapTotal]}"
