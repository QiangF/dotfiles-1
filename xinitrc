
# [ App Evnvirenmet 程序依赖环境变量 ]# {{{
#--------------------------------------------

# urxvt Tabpage 标签页高亮提示完成任务
#export PROMPT_COMMAND="echo -ne '\a'"
#/usr/bin/urxvtd -q -o -f &


# [ fcitx ]
#-------------------------------------------
## http://fcitx-im.org/wiki/Input_method_related_environment_variables
## https://wiki.archlinux.org/index.php/Fcitx
## http://wiki.gentoo.org/wiki/Fcitx
## XMODIFIERS X 图形程序的输入法
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
killall fcitx
## XXX >fcitx 4.2.5 后，带有自动启动脚本 /etc/xdg/autostart/fcitx-autostart.desktop
## 在高端 WM 中会自动启动，但 musca 不行，在 musca_start 配置启动，在 gtk2 可以激活 fcitx

# 加载 dmenu 使用 X11 核心字体路径
# XXX fc-list 显示字体属性，并不一定在 xfontsel 中会有
# 需要在 /etc/X11/xorg.conf 中指定路径，或手动添加 X 字体路径
#xset +fp '/usr/share/fonts/local'
#xset +fp /usr/share/fonts/myfont/pix.square
#xset +fp /usr/share/fonts/myfont/ohsnap-1.7.8
#xset fp rehash

# }}}

# [ AutoRun  自动启动 ]# {{{
#--------------------------------------------

# 键盘 键位 置换
#{ sleep 2; xmodmap ~/.xmodmaprc; } &

# awesome 启用透明功能，依赖
#xcompmgr &

# 阴影效果对比明显，无窗口/菜单渐隐
# XXX 会导致 musca 虚拟桌面不能及时刷新 [?]
#xcompmgr -l -5 -t -5 -r 5 -o 0.60 -c &

#(sleep 40 && conky -c ~/conky/big_conky) &

# wallpaper 壁纸
#feh --bg-scale ~/pic/wall/glass.jpg
#xsetroot -solid "#a8a8a8"

# Disable PC Speaker Beep in console
#setterm -blength 0

#xhost -

# 关闭X下响铃
# 2012-01-06 无效
#xset b off
#xset -b

# sleep 延时解决 fcitx 无法在自启动 xterm 激活问题 [?]
#(sleep 4 && xterm) &

# }}}

if [ -f /etc/arch-release ]
then
    export DISTRO=arch
    ## https://wiki.archlinux.org/index.php/D-Bus
    ## ## cat xinitrc.d/30-dbus
    ## if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] && type dbus-launch >/dev/null; then
    ##   eval $(dbus-launch --sh-syntax --exit-with-session)
    ##   echo $DBUS_SESSION_BUS_ADDRESS > ~/.dbus_session_address
    ##   #export DBUS_SESSION_BUS_ADDRESS    ## XXX notify + crontab 依赖该环境变量
    ## fi
    if [ -d /etc/X11/xinit/xinitrc.d ]; then
      for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && source "$f"
      done
      unset f
    fi
elif [ -f /etc/gentoo-release ]
then
    export DISTRO=gentoo
    synclient TapButton1=1      ## 单指 --> 左键
    synclient TapButton2=2      ## 双指 --> 中建
    synclient TapButton3=3      ## 三指 --> 右键
fi

# [ Window Manager 窗口管理器 ]# {{{
#--------------------------------------------
# /etc/slim.conf 中没有指定 session 时有用，否在会按照 slim 中定义的 session 队列匹配
# openbox-session compiz fvwm2 subtle

DEFAULTSESSION="kde"
WM_SESSION=${1:-$DEFAULTSESSION}    ## XXX 若 $1 参数为空，则使用 $DEFAULTSESSION
echo $WM_SESSION|tee -a /tmp/window_manager_session.txt

case $WM_SESSION in
musca)

    # [ create musca layout link file ]#{{{
    #--------------------------------------------
    ## gentoo / arch xrandr 依赖比 xdpyinfo 少，而且 xrandr 提供调节分辨率功能
    export XRANDR_RESOLUTION=`xrandr |sed -n 's/.*current \([0-9]\{4\}\) x.*/\1/p'`
    export XDPYINFO_RESOLUTION=`xdpyinfo | awk '/dimensions/ { print $2 }' | cut -dx -f1`

    if [[ ! -L ~/.layout_musca/firefox && ! -L ~/.layout_musca/xterm  && -L ~/.layout_musca ]]
    then
        if [ ! -z $XRANDR_RESOLUTION ]
        then
            ## archlinux xrandr 可以获取分辨率
            export RESOLUTION=$XRANDR_RESOLUTION
            ln -sf ~/.layout_musca/${RESOLUTION}.xterm ~/.layout_musca/xterm
            ln -sf ~/.layout_musca/${RESOLUTION}.firefox ~/.layout_musca/firefox
        elif [ ! -z $XDPYINFO_RESOLUTION ]
        then
            export RESOLUTION=$XRANDR_RESOLUTION
            ln -sf ~/.layout_musca/${RESOLUTION}.xterm ~/.layout_musca/xterm
            ln -sf ~/.layout_musca/${RESOLUTION}.firefox ~/.layout_musca/firefox
        else
            export RESOLUTION='UNKNOWN'
        fi
    fi
    #}}}

    exec dbus-launch musca
    # 在 slim 中加载 ck-launch-session 和 dbus-launch
    # 如果不使用 slim ,使用 .xinitrc 中无法加载 ck-launch-session
    #exec musca
    ;;
kde)
    if [ "$DISTRO"x = "arch"x ]
    then
        ## archlinux
        exec startkde
    elif [ "$DISTRO"x=="gentoo"x ]
    then
        ## gentoo
        exec ck-launch-session startkde
    else
        exec ck-launch-session dbus-launch startkde
    fi
    ;;
gnome-shell)
    exec dbus-launch gnome-session
    ;;
*)
    exec $DEFAULTSESSION
    ;;
esac

# }}}





# vim:set et ft=sh fdm=marker sw=4 sts=4 ts=4 nopaste :
