#!/bin/bash

title=$1
content=$2

## 需要引号引用变量，否在，若在 title 和 content 中有空格会被拆分成多个参数

# [ OK 可以工作 ]
#--------------------------------------------

## XXX 依赖 ~/.xinitrc 创建的 ~/.dbus_session_address 文件
DISPLAY=:0.0 DBUS_SESSION_BUS_ADDRESS=`cat ~/.dbus_session_address` /usr/bin/notify-send -t 3000 "$title" "$content"


# [ not working 不管用 ]
#--------------------------------------------

#DISPLAY=:0.0 /usr/bin/notify-send -t 3000 "$title" "$content"

#DISPLAY=:0.0
#DBUS_SESSION_BUS_ADDRESS=`sed -n -e 's/^DBUS_SESSION_BUS_ADDRESS=//p' ~/.dbus/session-bus/*-0`
#/usr/bin/notify-send -t 3000 "$title" "$content"

#DISPLAY=:0.0 DBUS_SESSION_BUS_ADDRESS=`sed -n -e 's/^DBUS_SESSION_BUS_ADDRESS=//p' ~/.dbus/session-bus/*-0` /usr/bin/notify-send -t 3000 "$title" "$content"

## 读取 ~/.dbus/session-bus/*-0 可以保证 dbus 变量的实时性
## 从 .xinitrc 中重定向生成的 ~/.dbus_session_address 文件只是登录时刻的 dbus 的变量
## 如果进程有更换，不能保证有效性
## sed -n -e 's/^DBUS_SESSION_BUS_ADDRESS=//p' ~/.dbus/session-bus/*-0




