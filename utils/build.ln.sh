#!/bin/bash

script_file=`basename $0`
script_dir=`dirname $0`
absolute_path=$(cd "$(dirname "$0")"; pwd)

function is_file_or_dir()
{

    local dotfile="$1"
    local base_dotfile="$2"
    local home_dotfile="$3"
    local DATE_TIME=`date -d now +"%F"`
    local TIME_STAMP=`date -d now +"%s"` ## %s UNIX 时间戳 1343138292_xinitrc
    local SHOW_TIMESTAMP=`date -d@$TIME_STAMP +"%F %T"`
    #local base_dotfile=`basename $dotfile`
    #local home_dotfile="$HOME/.${dotfile##*/}"

    ## 链接文件 [直接返回] --> 普通文件 [移动到 .0.dotfiles] --> 创建链接文件

    ## XXX 若是链接文件，直接返回，第一个判断，否则会重复将文件移走，重复重建链接文件
    if [ -h $home_dotfile ]
    then
        echo -e "\e[1;33m (N) 链接文件: $dotfile \e[0m"
        return
    fi

    ## 判断 家目录 下是否已经有 配置文件(夹)
    if [[ -f $home_dotfile || -d $home_dotfile ]]
    then
        echo -e "\e[1;31m {M} \$HOME 家目录 已存在 $home_dotfile 文件，移动到 \$HOME/.0.dotfiles/ \e[0m"
        # XXX 因为时间戳只精确到天，同一天的文件会被强制覆盖
        mv -f $home_dotfile $HOME/.0.dotfiles/${base_dotfile}_${DATE_TIME}
    fi

    if [ ! -f $home_dotfile ] && [ -f $dotfile ]
    then
        echo -e "\e[1;36m [L] --> file 创建链接文件: $dotfile \e[0m"
        ln -s $dotfile $home_dotfile
    fi

    if [ ! -d $home_dotfile ] && [ -d $dotfile ]
    then
        echo -e "\e[1;36m [L] --> dir 创建链接文件夹: $dotfile \e[0m"
        ln -s $dotfile $home_dotfile

    fi

    #[ -h $home_dotfile ] && echo "链接文件: $dotfile"
    #[ -f $home_dotfile ] && echo "普通文件: $dotfile"
    #[ -d $home_dotfile ] && echo "目录文件: $dotfile"
    #[ -f $dotfile ] && echo "普通文件: $dotfile"
    #[ -d $dotfile ] && echo "目录文件: $dotfile"
    #ln -s $dotfile $home_dotfile

}

#--------------------------------------------
# XXX 之前移动过去的文件/文件夹会被覆盖

if [ ! -d $HOME/.0.dotfiles ]
then
    echo -e "\e[1;31m 创建 \$HOME/.0.dotfiles 文件夹 \e[0m"
    mkdir $HOME/.0.dotfiles
fi

#--------------------------------------------
# http://stackoverflow.com/questions/5238019/using-bash-to-automate-dotfiles
for dotfile in ~/me/dotfiles/*
do

    base_dotfile=`basename $dotfile`
    home_dotfile="$HOME/.${dotfile##*/}"

    # 过滤 README / build.ln.sh / ... 文件
    case $base_dotfile in
        ## XXX for 循环没有遍历 .* 隐藏文件
        utils|README.rst|ssh|.gitignore|ignore)
            echo -e "\e[1;33m [S] 跳过 $dotfile 文件 \e[0m"
            continue
            ;;
        Xdefaults)
            #if [ ! -f ~/.Xdefaults-${HOSTNAME} ] && [ -f Xdefaults ]
            if [ ! -f ~/.Xdefaults-${HOSTNAME} ]
            then
                echo -e "\e[1;36m |xterm| 为 gnome-shell 创建 .Xdefaults-\${HOSTNAME} 文件 \e[0m"
                ln -s  $dotfile ~/.Xdefaults-${HOSTNAME}
            fi
            ;;
    esac

    is_file_or_dir $dotfile $base_dotfile $home_dotfile
done
            set +x
            set -x
