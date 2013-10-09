#!/bin/bash

xephyr_pid=`pidof Xephyr`

if [ $pids ]
then
    echo "Xephyr is already running (pids: $pids)";
else
    Xephyr :1 -ac -dpi 96 -host-cursor -noreset -screen 1280x750 2>/dev/null &
    sleep 1
    export DISPLAY=':1.0'
    exec musca -s ~/.musca_start 2>/dev/null &
fi




