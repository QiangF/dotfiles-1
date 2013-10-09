=================
dotfiles 配置文件
=================

:source: `dotfiles <http://github.com/lvii/dotfiles>`_ 最近更新
:me: 果冻 <volcanowill(at)gmail.com>

about
-----

有些配置文件选项是基于 archlinux 的，可能需要根据自己的发行版重新自定义

将 ``$HOME`` 下的配置文件独立出来放在 ``dotfiles`` 中的方便之处：

- 统一管理配置，迁移方便，多个系统可以共享挂载点 (arch/gentoo)
- 在家目录下的误操作受害的都是 ``链接文件`` 降低伤及无辜的风险

config file list
----------------

*路径无需修改*
::
    xinitrc
    musca_start
        musca/1366.0.firefox
        musca/1366.0.gimp
        musca/1366.0.xterm
        musca/1366.1.xterm
        musca/1680.0.firefox
        musca/1680.0.xterm
    dzen.sh
    xmobarrc

    Xdefaults
    screenrc
    bashrc
    zshrc
    alias
    pythonstartup

    emacs
    vimrc

    pentadactylrc

    irssi/config
    irssi/startup
    irssi/weed.theme
    irssi/scripts
        adv_windowlist.pl
        notify.pl
        trackbar-soliton.pl
    mutt/mailcap
    mutt/muttrc

*媒体文件路径( ncmpcpp 路径影响 taglib 编辑歌曲信息)*
::
    mpdconf
    ncmpcpp/config

*种子路径/下载路径，按需修改*
::
    rtorrent.rc
    aria2/aria2.conf

    xmodmap
    fonts.conf
    gitconfig

*创建 $HOME 目录下链接文件脚本*
utils/build.ln.sh

missing config
--------------

*目前尚未跟踪的文件，需要后续追加*
::
    .mplayer/config
    .bitlbee.conf
    .lftprc ==> .lft/rc
    .gtk-bookmarks

todo
----

- musca 虚拟桌面自动激活浮动模式
- irssi KDE 提示脚本
- /etc --> syscfg/

thanks
------

- `Google SSL`_

    - 因为 GFW，你懂得 ('_';)...

.. _`Google SSL`: https://encrypted.google.com

- `Archlinux Wiki`_

    - 说明书看多了，英文恐慌症状减轻了

.. _`Archlinux Wiki`: https://wiki.archlinux.org

- `Github`_

    - 一窥其他兄台的配置变得 easy

.. _`Github`: https://github.com






# vim:set et ft=rst fdm=marker sw=4 sts=4 ts=4 nopaste :
