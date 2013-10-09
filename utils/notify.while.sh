#!/bin/bash

libnotify="`which notify-send 2>/dev/null`"

if [ -n "$libnotify" ]
then
    export DISPLAY=:0.0
    ## export DBUS_SESSION_BUS_ADDRESS=`cat ~/.dbus_session_address`
    while true
    do
        sleep 45m
        notify-send -t 3000  "TAKE WATER !" "爷，喝口水吧！"
        sleep 2m
        # XXX 每隔 45 分钟提示一次
        notify-send -t 3000  "TAKE WATER 2!" "爷，喝口水吧！"
    done
fi



## KDE 无需在脚本中引用 DBUS_SESSION_BUS_ADDRESS 变量
## ln -s ~/me/dotfiles/utilities/notify.while.sh ~/.kde4/Autostart/notify.while.sh

