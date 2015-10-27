#!/bin/bash
# zz-custom-bash.sh
# Please place this file in /etc/profile.d/
#
# Maintainer: danielschier84<at>gmail.com
# Version: 0.2

##########################################
# System Summary                         #
##########################################
echo " System summary (collected $(printf '%(%H:%M:%S %d.%m.%Y)T'))
---------------------------------------------------------------
 Hostname                 = $(hostname -f)
 Kernel                   = $(uname -sr)

 CPU-Model                = $(awk '/model name/ { print $4 $5 $6 }' /proc/cpuinfo | head -n1)
 CPU-Frequency            = $(awk '/model name/ { print $9 }' /proc/cpuinfo | head -n1)
 CPU-Cores/Threads        = $(awk '/cpu cores/ { print $4 }' /proc/cpuinfo | head -n1 )/$(grep -c 'processor' /proc/cpuinfo)

 Memory (free)            = $(awk '/MemFree:/ { print $2 }' /proc/meminfo) kB
 Memory (available)       = $(awk '/MemAvailable:/ { print $2 }' /proc/meminfo) kB
 Memory (total)           = $(awk '/MemTotal:/ { print $2 }' /proc/meminfo) kB
 Swap   (free)            = $(awk '/SwapFree:/ { print $2 }' /proc/meminfo) kB
 Swap   (total)           = $(awk '/SwapTotal:/ { print $2 }' /proc/meminfo) kB
---------------------------------------------------------------"
