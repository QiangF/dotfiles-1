# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f /etc/bashrc ]] && . /etc/bashrc
[[ -f /etc/bash_completion ]] && source /etc/bash_completion
[[ -f /usr/share/doc/tmux/examples/bash_completion_tmux.sh ]] && source /usr/share/doc/tmux/examples/bash_completion_tmux.sh
[[ -f ${HOME}/.shrc ]] && source ${HOME}/.shrc

# [ Prompt PS1 提示符 ]#{{{
#--------------------------------------------

# [ color 色块标记 git 状态 _git_prompt() ]
#--------------------------------------------
# Colorful bash prompt reflecting Git status
# From : http://opinionated-programmer.com/2011/01/colorful-bash-prompt-reflecting-git-status/

function _git_prompt {

    ## XXX 旧版 ( centos 5 ) git 不支持 -u normal 参数
    local git_status="`LANG=en_US.UTF-8 git status -unormal 2>&1`"

    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local ansi=42
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local ansi=43
        else
            local ansi=45
        fi
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
            test "$branch" != master || branch=' '
        else
            #branch="(`git branch --no-color 2> /dev/null|cut -d' ' -f2`)"
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
        fi
        echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\]'
    fi
}

## XXX 单独使用 PS1，没有调用 PROMPT_COMMAND 函数
## 1. 不会时事更新 git 信息
## 2. [?] 是否动态修改 screen 标题栏
#prompt_str="`_git_prompt`"'\w \n \$ '

# XXX 使用 \[ ... \] 包裹 screen 标题栏的 目录 | vim 等程序才能正常显示
prompt_str=" \[\e[1;34m\]\w \n \[\e[1;32m\]\$ "

case "$TERM" in
    screen*)

        # if [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; then
        #     PS1_HOSTNAME=
        # else
        #     PS1_HOSTNAME="@$HOSTNAME"
        # fi

        function ssh {
            # XXX 未知 \134
            #echo -n -e "\033k@`echo $1|sed 's:.*@::'`\033\134″"
            echo -n -e "\ek@`echo $1|sed 's:.*@::'`\e\\"
            /usr/bin/ssh -o UserKnownHostsFile=/dev/null \
                         -o StrictHostKeyChecking=no -o ServerAliveInterval=30 "$@"
        }

        PATHTITLE='\[\ek\W\e\\\]'   # 路径标题
        PROGRAMTITLE='\[\ek\e\\\]'  # 程序标题
        prompt_str="${PROGRAMTITLE}${PATHTITLE}${prompt_str}"

        ;;
    *)
        ;;
esac

function _prompt_command {
    PS1="`_git_prompt`"$prompt_str
    ## 加粗输入的命令
    trap 'echo -ne "\e[0m"' DEBUG
}

PROMPT_COMMAND=_prompt_command

#}}}

# [ history 历史记录 ]# {{{
#--------------------------------------------

#datestamp_history(){
#export infodate=`date "+: %c"`
#export infohis=`history 1`
#echo $infodate' => '$infohis >> $HOME/.history-timestamp
#}
#export PROMPT_COMMAND=datestamp_history

#--------------------------------------------

# 去除重复历史记录。bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# HISTSIZE 控制历史命令记录的总行数,默认 500
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT="%F %T "

# 禁用 history，,将 HISTSIZE 设置为 0
#export HISTSIZE=0

# HISTIGNORE 忽略历史中的特定命令, 将忽略 pwd、ls、ls -ltr 等命令：
export HISTIGNORE="[ ]*:ls:ls *:ll:ll *:la:cd:cd *:pwd:[bf]g:exit"

# 重复的命令，多个 shell 可能会干扰各自的历史记录，在 shell 中执行 shopt -s histappend

# 移除 shell 历史记录中连续的重复命令，清除整个命令历史中的重复条目 erasedups 参数
export HISTCONTROL=erasedups

# 使用 HISTTIMEFORMAT 显示时间戳
#export HISTTIMEFORMAT='%F %T '

# HISTFILE 更改历史文件名称
#HISTFILE=/root/.commandline_warrior







# }}}

## [ RED HAT /etc/bashrc ]#{{{
##--------------------------------------------
#
#if [ "$PS1" ]; then
#    case $TERM in
#        xterm*) 
#            if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
#                PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
#            else
#                PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
#            fi
#            ;;
#        screen) 
#            if [ -e /etc/sysconfig/bash-prompt-screen ]; then
#                PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
#            else
#                PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\033\\"'
#            fi
#            ;;
#    esac
#    # Turn on checkwinsize
#    shopt -s checkwinsize
#    [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "
#fi
#
##}}}






# vim:set et ft=sh fdm=marker sw=4 sts=4 ts=4 nopaste :
