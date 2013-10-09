# vim:set et ft=sh fdm=marker sw=4 ts=4 nopaste softtabstop=4 :

# [ TODO ]# {{{
#--------------------------------------------
# 历史记录，中文乱码，自定义，时间戳格式


# }}}

[[ -f ${HOME}/.shrc ]] && source ${HOME}/.shrc

export SHELL=/bin/zsh

# [ PS1 git prompt  ] # {{{
#--------------------------------------------
# http://kriener.org/articles/2009/06/04/zsh-prompt-magic
# http://www.jukie.net/~bart/blog/pimping-out-zsh-prompt

#--------------------------------------------
## zsh 预置多个可用主题，用 prompt -l 查看，prompt -s <themes> 试用
#autoload -Uz promptinit
#promptinit
#prompt bart
#--------------------------------------------

setopt prompt_subst
autoload colors
colors

autoload -Uz vcs_info

## 默认变量定义格式太繁琐：%{${fg_bold[yellow]}%} ... %{${reset_color}%} 使用自定义变量
for COLOR in RED GREEN YELLOW WHITE BLACK CYAN BLUE MAGENTA; do
    eval PR_${COLOR}='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_${COLOR}='%{$fg_bold[${(L)COLOR}]%}'
done

PR_RST="%{${reset_color}%}"
#PR_RESET="%{${reset_color}%}"
## XXX 清空 颜色 和 样式 (粗体/背景色/下划线)
PR_RESET="%{%b%s%u${reset_color}%}"
PR_BRBG="%{%(?.${PR_RESET}.%S)%}"     ## bright / standout bg_color 命令执行失败，高亮背景色

## prompt_newline 变量用于分隔 2行的 prompt
## http://opensource.apple.com/source/zsh/zsh-53/zsh/Functions/Prompts/promptinit
#prompt_newline=$'\n%{\r%}'
PR_NEWLINE=$'\n%{\r%}'

# %b - branchname               分支名
# %u - unstagedstr              未跟踪
# %c - stangedstr               新添加 跟踪
# %a - special action           [e.g. rebase-i | merge conflict ]
# %R - repository path          版本路径
# %S - path in the repository   在版本库中到路径

FMT_BRANCH="${PR_BRIGHT_RED}%b ${PR_GREEN}%u${PR_YELLOW}%c${PR_RST}"  # master + -
FMT_ACTION="(${PR_WHITE}%a${PR_RST})"                                 # (merge)
FMT_PATH="%R${PR_YELLOW}/%S"                                          # (ink@king:~/text) 高亮最后一级

## http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
## man 1 zshcontrib
## :vcs_info:<vcs-string>:<user-context>:<repo-root-name>
## vcs-string        支持的版本控制系统名称
## user-context      用户自定义的字符串，可以作为参数传递给 vcs_info 函数
## repo-root-name    是 zstyle 要匹配的 repository

# 关闭不常用的版本控制系统, 执行 vcs_info_printsys 命令查看 '支持/不支持' 版本控制
zstyle ':vcs_info:*' disable bzr cdv darcs fossil mtn p4 svk tla
zstyle ':vcs_info:*' enable cvs git hg svn

## check-for-changes 实时检查 repo 更新，stagedstr %c / unstagedstr %u 才可用，repo 文件很多，速度会变慢
## actionformats     在当前版本库的特殊操作 (交互式变基 interactive rebase | 合并冲突 merge conflict )
## formats           无特殊操作 special action
## nvcsformats       当前目录不是 repository 或 vcs_info 被禁用
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr       '+ '                            ## green
zstyle ':vcs_info:*:prompt:*' stagedstr         '- '                            ## red / yellow
zstyle ':vcs_info:*:prompt:*' actionformats     "${FMT_BRANCH}${FMT_ACTION}"    ## branch 后空格
zstyle ':vcs_info:*:prompt:*' formats           "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats       ""

## call 'vcs_info' function before the prompt is drawn
## 格式: vcs_info command 传递 command 参数，默认值：(command default value is 'empty string')
function precmd {
    vcs_info 'prompt'
}

function lprompt {
    ## vcs_info_lastmsg 命令可以查看当前 vcs_info_msg_N_ 变量对应的值_
    local git='$vcs_info_msg_0_'

    ## 当前工作目录 current_working_directory
    ## SIMPLE PROMPT ESCAPES , formatting sequences : man 1 zshmisc
    ## %B ... %b 开始到结束使用 *粗体* 打印
    ## %d present_working_directory ==> %/
    ## 绝对路径 %/
    ## 相对路径 %~
    local cwd=" %B%d%b "

    #PROMPT="${PR_RESET}${bracket_open}${git}${cwd}${bracket_close}○%# ${PR_RESET}"

    ## XXX 使用 $'\n' 来分隔/断开 prompt 的双引号 prompt_newline 变量
    PROMPT="${PR_RESET}${PR_BLUE}${cwd}"$'\n'" ${git}${PR_BRBG}${PR_RED}·${PR_RESET} "

}

## 调用 lprompt 函数，初始化 PS1
lprompt
#lprompt '[]' $BR_BRIGHT_BLACK $PR_GREEN
#lprompt '' $BR_BRIGHT_BLACK $PR_GREEN

# ------------------------------
# update the vcs_info_msg_ magic variables, but only as little as possible

# This variable dictates weather we are going to do the git prompt update
# before printing the next prompt.  On some setups this saves 10s of work.
PR_GIT_UPDATE=1

# called before command excution
# here we decide if we should update the prompt next time
function zsh_git_prompt_preexec {
        case "$(history $HISTCMD)" in 
            *git*)
                PR_GIT_UPDATE=1
                ;;
        esac
}
preexec_functions+='zsh_git_prompt_preexec'

# called after directory change
# we just assume that we have to update git prompt
function zsh_git_prompt_chpwd {
        PR_GIT_UPDATE=1
}
chpwd_functions+='zsh_git_prompt_chpwd'

# called before prompt generation
# if needed, we will update the prompt info
function zsh_git_prompt_precmd {
       if [[ -n "$PR_GIT_UPDATE" ]] ; then
               vcs_info 'prompt'
               PR_GIT_UPDATE=
       fi
}
precmd_functions+='zsh_git_prompt_precmd'


# }}}

## http://chenyufei.info/blog/2009-11-12/zsh-screen
## man zshmisc
## preexec  输入命令按下回车但 zsh 还未执行命令前被调用
##     Executed just after a command has been read and is about to be executed
## precmd   在 zsh 更新 prompt 前被调用
##     Executed before each prompt
## zsh 内置 截短字符串的功能，用 %20..>$1%


## [ screen / tmux 小标题 ] #  {{{
##--------------------------------------------
#
## [ case 判断 screen / xterm / tmux  ]# {{{
##--------------------------------------------
#case $TERM in
#    #xterm*|rxvt*)
#    rxvt*)
#        function title() { print -nP "\e]0;$1\a" } 
#        ;;
#    xterm-256color|screen*)
#        # 如果是本地 shell 仅设置 screen 标题栏
#        # only set screen title if it is in a local shell
#        if [ -n $STY ] && (screen -ls |grep $STY &>/dev/null); then
#
#            # 标题栏 定制函数
#            function title() {
#                # 动态 标题栏
#                print -nP "\ek$1\e\\"
#                # 修改窗口 标题栏
#                # modify window title ba
#                #print -nPR $'\033]0;'$2$'\a'
#            }
#
#        # 定制 tmux 标题栏 # actually in tmux !
#        elif [ -n $TMUX ]; then
#            function title() {  print -nP "\e]2;$1\a" }
#        else
#            function title() {}
#        fi
#        ;;
#    *)
#        function title() {}
#        ;;
#esac
## }}}
#
## [ Screen 动态改变 标题栏 扩展函数 ]# {{{
##--------------------------------------------
#
## 若，没有连接到远程服务器，动态改变 screen 标题
##if [ "$STY" != "" ]; then
#
#screen_precmd()
## {{{
#{
#
#    # 底部 标题 使用 短路径
#    #title "%10< ..<%c%<<"
#
#    # 输出 bell 报警信号 , urgent notification trigger
#    #echo -ne '\a'
#    #title "`print -Pn "%~" |sed "s:\([~/][^/]*\)/.*/:\1...:"`" "$TERM $PWD"
#    title "`print -Pn "%~" |sed "s:\([~/][^/]*\)/.*/:\1...:;s:\([^-]*-[^-]*\)-.*:\1:"`" "$TERM $PWD"
#    echo -ne '\033[?17;0;127c'
#}
## }}}
#
#screen_preexec()
## {{{
#{
#    #title "%10>..>$1%<<"
#
#    local -a cmd; cmd=(${(z)1})
#    case $cmd[1]:t in
#        'ssh')          title "@""`echo $cmd[2]|sed 's:.*@::'`" "$TERM $cmd";;
#        'sudo')         title "#"$cmd[2]:t "$TERM $cmd[3,-1]";;
#        'for')          title "()"$cmd[7] "$TERM $cmd";;
#        'svn'|'git')    title "$cmd[1,2]" "$TERM $cmd";;
#        'ls'|'ll')      ;;
#        *)              title $cmd[1]:t "$TERM $cmd[2,-1]";;
#    esac
#
#}
## }}}
#
##{{{  自定义 screen 扩展函数 添加到 zsh 默认的 precmd preexec 函数队列
#
## 版本 zsh 4.3.11 (2011.4.4) 中没有 add-zsh-hook 函数
## roylez's zshrc 配置文件，中有相关函数定义
#typeset -ga preexec_functions precmd_functions
#precmd_functions+=screen_precmd
#preexec_functions+=screen_preexec
#
##}}}
#
## }}}
#
#
#
## }}}
#

# [ clear commint ]#{{{
#--------------------------------------------

## http://blog.bstpierre.org/zsh-prompt
#function title {
#    # escape '%' chars in $1, make nonprintables visible
#    local a=${(V)1//\%/\%\%}
#
#    # Truncate command, and join lines.
#    a=$(print -Pn "%40>...>$a" | tr -d "\n")
#    case $TERM in
#        screen*)
#            function zsh_term_prompt_precmd {
#                print -Pn "\e]2;$a @ $2\a" # plain xterm title
#            }
#            function zsh_term_prompt_preexec {
#                print -Pn "\ek$a\e\\"      # screen title (in ^A")
#                print -Pn "\e_$2   \e\\"   # screen location
#            }
#            preexec_functions+='zsh_term_prompt_preexec'
#            precmd_functions+='zsh_term_prompt_precmd'
#            ;;
#        xterm*)
#            function zsh_term_prompt_precmd {
#                print -Pn "\e]2;$a @ $2\a" # plain xterm title
#            }
#            precmd_functions+='zsh_term_prompt_precmd'
#            ;;
#    esac
#}

## man screen TITLES
## title-string escape-sequence (<esc>kname<esc>\)
case $TERM in
    screen*)
        function title {
            ## escape '%' chars in $1, make nonprintables visible
            local cmd=${(V)1//\%/\%\%}      ## (V) escapes all non-printable characters
            ## 截短命令行，并合并命令行 truncate command, and join lines
            cmd=$(print -Pn "%16<..<$cmd" | tr -d "\n")

            ## screen 标题转义序列格式：\ek_title_name_\e\\
            print -Pn "\ek$cmd\e\\"         ## -P --> Perform prompt expansion
            print -Pn "\e]2;$cmd @ $2\a"    ## xterm title
            print -Pn "\e_$2   \e\\"        ## screen location [?] remote ssh [?]
                                            ## screen) print -Pn "\e_ %/ | %y\e\\"
                                            ## better for remote shells: "\e_ %n@%m: %~\e\\"

            #  local a=${${1## *}[(w)1]} # get the command
            #  local b=${a##*\/} # get the command basename
            #  a="${b}${1#$a}" # add back the parameters
            #  a=${a//\%/\%\%} # escape print specials
            #  a=$(print -Pn "$a" | tr -d "\t\n\v\f\r") # remove fancy whitespace
            #  a=${(V)a//\%/\%\%} # escape non-visibles and print specials

        }
        ;;
    xterm*|linux)
        ## XXX console 下提示 screen_precmd 找不到命令 title , console 的 $TERM=linux
        function title {
            #local cmd=${(V)1//\%/\%\%}      ## (V) escapes all non-printable characters
            #print -Pn "\e]2;$USER @ $2\a"   ## xterm title
            print -Pn "\e]2;${(V)1}\e\\"
        }
        ;;
esac

## precmd 用来修改 xterm 标题栏 / screen 标题栏
function screen_precmd {
    ## %m --> hostname  %~ --> reletive path
    #title "$PWD" "%m:%48<...<%~"
    #title "%~" "%m : %8<...<%~"
    title "%~" "%m : %8< ..<%c%<<"
}

## preexec 用来对特殊命令进行包装，如 ssh / sudo ...
function screen_preexec {
    #title "$1" "%m : %8<...<%~"
    title "$1" "%m : %8< ..<%c%<<"
}

typeset -ga preexec_functions precmd_functions
preexec_functions+='screen_preexec'
precmd_functions+='screen_precmd'

#}}}

# [ man screen title  ]#{{{
#--------------------------------------------
### https://github.com/kalkin/zsh/blob/master/zshscreen

#function preexec() {
#  local a=${${1## *}[(w)1]} # get the command
#  local b=${a##*\/} # get the command basename
#  a="${b}${1#$a}" # add back the parameters
#  a=${a//\%/\%\%} # escape print specials
#  a=$(print -Pn "$a" | tr -d "\t\n\v\f\r") # remove fancy whitespace
#  a=${(V)a//\%/\%\%} # escape non-visibles and print specials
#
#  case "$TERM" in
#    screen|screen.*)
#      # See screen(1) "TITLES (naming windows)".
#      # "\ek" and "\e\" are the delimiters for screen(1) window titles
#      print -Pn "\ek%-3~ $a\e\\" # set screen title. Fix vim: ".
#      print -Pn "\e]2;%-3~ $a\a" # set xterm title, via screen "Operating System Command"
#      ;;
#    rxvt|rxvt-unicode|xterm|xterm-color|xterm-256color)
#      print -Pn "\e]2;%m:%-3~ $a\a"
#      ;;
#  esac
#}
#
#function precmd() {
#  case "$TERM" in
#    screen|screen.rxvt)
#      print -Pn "\ek%-3~\e\\" # set screen title
#      print -Pn "\e]2;%-3~\a" # must (re)set xterm title
#      ;;
#  esac
#}
#
#set -A preexec_functions preexec mypreexec

#}}}

# [ Base 基本 ] # {{{
#--------------------------------------------

# 默认配置文件 格式 ：
#setopt appendhistory autocd extendedglob nomatch notify

# 关闭 报错 响铃
setopt NO_BEEP

# 关闭 C-q/C-k 锁定 终端快捷键 [screen] [?] 无效
unsetopt flowcontrol

# pushds 和 popds 操作后，不打印输出 dir stack
setopt pushd_silent
setopt pushd_ignore_dups        # do not push dups on stack

# 允许在交互模式中使用注释 如： cmd #这是注释
setopt INTERACTIVE_COMMENTS

# 在 提示符函数中有调用
#setopt prompt_subst             # prompt more dynamic, allow function in prompt

# [ 进程 ? ]
#--------------------------------------------
# 自动向 暂停工作 disowned jobs 发送 CONT 继续重新工作信号
setopt auto_continue

# 使用默认的 long 格式，显示 后台 运行的 作业 jobs
setopt long_list_jobs

# 创建文件时，将 ^ * # 字符视作 文件命名的合法字符 [?] 无效
setopt extended_glob

# [ XXX ] #--------------------------------------------

# 展开 达括号中到表达式 [?]
setopt brace_ccl


# shell 不会按照远程地址上的文件去扩展参数，# scp ip:/home/tommy/*
# 本地当前目录中，不存在 ip:/home/tommy/*，匹配失败
# 默认情况下，bash 在匹配失败时就使用原来的内容，zsh 则报告一个错误
# zsh 中执行 setopt nonomatch 则告诉它不要报告 no matches 的错误，而是当匹配失败时直接使用原来的内容
# XXX 实际上，不管是 bash 还是 zsh，不管设置了什么选项，只要把 "ip:/home/tommy/*" 加上引号，可解决问题
setopt nonomatch

# 在改变路径是，若包含 链接目录，要如何处理 [?]
# ~/ln -> /; cd ln; pwd -> /
#setopt chase_links

# 扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
#setopt complete_in_word



# }}}

# [ completion 补全 ]# {{{
#--------------------------------------------

# [ 补全 选项 ]# {{{
#--------------------------------------------

# man zshoptions 查看选项到详细说明
setopt AUTO_LIST AUTO_MENU
#开启此选项，补全时会直接选中菜单项
#setopt MENU_COMPLETE

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD

# 补全命令，包括 .ssh/known_hosts 里面到主机
autoload -U compinit
#autoload -Uz compinit # [?]
compinit

# 启用自动 cd，输入目录名回车进入目录
# 稍微有点混乱，不如 cd 补全实用
#setopt AUTO_CD

# 在命令补全过程中，不展开 alias 别名
setopt complete_aliases

# 拼写检查 仅对命令纠错
setopt CORRECT
# 对命令中的所有参数纠错
#setopt CORRECT_ALL

# 在开始补全时，会将可能路径提前 hash，可能会使 补全变慢
#setopt hash_list_all

# 补全文件类型提示 ，类似 ls -F 的文件类型标志符
setopt list_types

# 补全 数字开头到文件时，按照数字排序，而非字典排序
setopt numeric_glob_sort





# }}}

# [ 补全 类型  ] #{{{
#--------------------------------------------
# 格式定义 man zshcompsys 中的 completer 字段
# zstyle ':completion:*' completer _complete _complete:-foo
# zsytle ':completion:*:completer:context or command:argument:tag'

# Archwiki 补全菜单可以使用方向键导航
zstyle ':completion:*' menu select
# 只有一个候选结果时，也显示补全候选菜单，默认：大于 2 个候选菜单才显示
zstyle ':completion:*:*:default' force-list always

# 使用 cache 加速 pacman 补全 # man zshcompsys
zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
# cd 不选择 父 目录
zstyle ':completion:*' ignore-parents parent pwd directory

# 路径补全，扩展函数，包含 prefix / suffix
zstyle ':completion:*' expand 'yes'
# 若 路径中包含 多个 // 斜扛，当作一个处理：/foo//who ==> /foo/who
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

# 错误校正
#zstyle ':completion:*' completer _complete _match _approximate
#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _match #_user_expand
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

zstyle ':completion:*:match:*' original only
# 容错字数 可以修改
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# 递增 补全
zstyle ':completion:incremental:*' completer _complete _correct

# [ XXX ] #--------------------------------------------

# 前缀 补全选项 [?] man 中没找到 prefix-1 格式
zstyle ':completion::prefix-1:*' completer _complete
# 推测 / 预告 补全 [?] man 中没找到
zstyle ':completion:predict:*' completer _complete

# [ XXX ] #--------------------------------------------

#修正大小写
# 大写 <==> 小写
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
# 大小写 <==> 大小写
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# kill 命令补全
# From http://wandsea.com/doc/opensource_guide/ch14s09.html
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
# 没什么效果 [?]
#zstyle ':completion:*:*:killall:*' menu yes select
#zstyle ':completion:*:killall:*'   force-list always
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'


#}}}

# [ 补全菜单 样式 ]# {{{
#--------------------------------------------

# 给补全菜单添加颜色
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 补全提示 标题描述 group matches and descriptions
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# 补全 标题 样式
#zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
#zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
#zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'

#zstyle ':completion:*:descriptions' format $'\e[33m == \e[1;7;36m %d \e[m\e[33m ==\e[m' 
#zstyle ':completion:*:messages' format $'\e[33m == \e[1;7;36m %d \e[m\e[0;33m ==\e[m'
#zstyle ':completion:*:warnings' format $'\e[33m == \e[1;7;31m No Matches Found \e[m\e[0;33m ==\e[m' 
#zstyle ':completion:*:corrections' format $'\e[33m == \e[1;7;37m %d (errors: %e) \e[m\e[0;33m ==\e[m'

#   [ 提示符颜色 ASCII 编码 ]# {{{
#--------------------------------------------
#   Black   0;30
#   Red     0;31
#   Green   0;32
#   Brown   0;33
#   Blue    0;34
#   Purple  0;35
#   Cyan    0;36
# }}}

zstyle ':completion:*:descriptions' format $'\e[33m | \e[1;7;32m %d \e[m\e[33m |\e[m' 
zstyle ':completion:*:messages' format $'\e[33m | \e[1;7;32m %d \e[m\e[0;33m |\e[m'
zstyle ':completion:*:warnings' format $'\e[33m | \e[1;7;33m No Matches \e[m\e[0;33m |\e[m'
zstyle ':completion:*:corrections' format $'\e[33m | \e[1;7;35m %d [errors: %e] \e[m\e[0;33m |\e[m'

#zstyle ':completion:*:descriptions' format $'\e[33m == \e[1;46;33m %d \e[m\e[33m ==\e[m' 
#zstyle ':completion:*:messages' format $'\e[33m == \e[1;46;33m %d \e[m\e[0;33m ==\e[m'
#zstyle ':completion:*:warnings' format $'\e[33m == \e[1;47;31m No Matches Found \e[m\e[0;33m ==\e[m' 
#zstyle ':completion:*:corrections' format $'\e[33m == \e[1;47;31m %d (errors: %e) \e[m\e[0;33m ==\e[m'



# }}}

# [ 自定义补全 ] #{{{
#--------------------------------------------

# ping
zstyle ':completion:*:ping:*' hosts www.zstu.edu.cn www.google.com \
192.168.128.1{38,} 192.168.{1,0}.1{{7..9},} 10.10.62.{1,{5{2..8},}}

# ssh scp sftp 等
my_accounts=(
57wsqh@216.194.70.6
lvii@fedora.unix-center.net
{r00t,root}@{192.168.1.1,192.168.0.1}
)
zstyle ':completion:*:my-accounts' users-hosts $my_accounts



#}}}






# }}}

# [ history 历史记录 ] # {{{
#--------------------------------------------
# 历史记录 修饰符 man zshexpn

#历史纪录条目数量
export HISTSIZE=2000
#注销后保存的历史纪录条目数量
export SAVEHIST=2000
#历史纪录文件
export HISTFILE=~/.zhistory

# 为历史纪录中的命令添加 时间戳 格式 [?]：
# : 1301840847:0;history 20 # EXTENDED_HISTORY

# 去除重复（相邻两次输入） [?]，若历史中已有，不再写入
#setopt HIST_IGNORE_DUPS

# file text/soft/zsh.txt # vim !$ 时，不立即执行，而是输出
# vim text/soft/zsh.txt 用户确认后在执行
setopt hist_verify              # 使用 历史命令时 重载 完整的 命令
setopt no_hist_beep             # 获取 / 写入 [?] 历史记录错误，不发出 beep 报警
setopt hist_ignore_all_dups     # 去除重复，新纪录覆盖旧的历史记录
setopt hist_reduce_blanks       # 删除历史文件 里面的空白
setopt hist_ignore_space        # 不纪录以空格开始的命令
setopt share_history            # 多 session 共享历史
setopt hist_verify              # reload full command when runing from history
setopt hist_expire_dups_first   # 删除 超出 最大上限 数量的 记录
setopt hist_find_no_dups        # 使用 history 命令显示时，不显示重复历史记录
setopt inc_append_history       # 立即附加，递增立即写入方式 历史纪录，而 APPEND_HISTORY 则是在 shell 退出之后写入

#}}}

# [ zle bindkey ]# {{{
#--------------------------------------------

# man zle = zsh command editor Emacs 风格
bindkey -e

# 设置 [DEL]键 为向后删除
#  1 前面的顿号，<1> xev 查看 ` 的 keycode，<2>在 xmodmap -pke 中查找对应的名称
bindkey "\e[3~" delete-char

#bindkey "\M-v" "\`xclip -o\`\M-\C-e\""

# c-z 后，再按一次，将进程调到前台 [?]
bindkey -s "" "fg\n"


# Archwiki 只在当前会话中进行，历史记录查
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

## 默认 C-u 绑定 kill-whole-line 会删除整行，而不是 backward-kill-line
bindkey \^U backward-kill-line

## C-v 然后 Alt-backspace 查看 A-backspace 的显示为 '^?'
## · bindkey | grep 'backward-kill-word'
## "^W" backward-kill-word
## "^[^H" backward-kill-word
## "^[^?" backward-kill-word

# Archwiki [?]
[[ -n "${key[Home]}" ]]     && bindkey "${key[Home]}"   beginning-of-line
[[ -n "${key[End]}" ]]      && bindkey "${key[End]}"    end-of-line

[[ -n "${key[Insert]}" ]]   && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]]   && bindkey "${key[Delete]}" delete-char

[[ -n "${key[Up]}" ]]       && bindkey "${key[Up]}"     up-line-or-history
[[ -n "${key[Down]}" ]]     && bindkey "${key[Down]}"   down-line-or-history

[[ -n "${key[Left]}" ]]     && bindkey "${key[Left]}"   backward-char
[[ -n "${key[Right]}" ]]    && bindkey "${key[Right]}"  forward-char

# Ctrl N/P 历史记录 翻页，默认支持 [?]
#bindkey "" history-beginning-search-backward
#bindkey "" history-beginning-search-forward




# [ PS1 之后，命令行输入样式 ] # {{{
#--------------------------------------------
# man zshzle

# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta  #选中区域
               special:bold       #特殊字符
               isearch:underline) #搜索时使用的关键字

zle_highlight+=( default:fg=green,bold )

#}}}

# }}}

# [ alias 别名 ]# {{{
#--------------------------------------------

# [ global 命令别名 ] # {{{
#--------------------------------------------
# -g 全局命令别名，放在命令的哪个位置都行
# cat test.txt L ==> cat test.txt|less

alias -g A="|awk"
# remove color, make things boring
alias -g B='|sed -r "s:\x1B\[[0-9;]*[mK]::g"'
alias -g C="|wc"
alias -g E="|sed"
alias -g G="|egrep"
alias -g H="|head -n $(($LINES-2))"
# less -R 可以解析 ls / grep 等颜色转义字符
alias -g L="|less -R"
alias -g P="|column -t"
alias -g R="|tac"
alias -g S="|sort"
alias -g T="|tail -n $(($LINES-2))"
alias -g X="|xargs"
#alias -g N="> /dev/null"
alias -g N='&> /dev/null &'
# last modified(inode time) file or directory
#alias -g NF="./*(oc[1])"

# NN 指向 inode 最新的那个文件，下载完7z x NN 解压缩，解压缩 cd NN 进入解压缩后的目录，方便!
alias -g NN="*(oc[1])"
# zsh 通配符 * 后可加括号修饰，o 表示排序，c 排序方式 inode time，方括号限定一个显示
# 用inode time 而非 file modified time NN 仍能指向 解压缩出来 修改时间较旧的文件


# }}}

# [ 文件关联 ] # {{{
#--------------------------------------------
# 查看 *.png 文件，只要输入该文件名（Tab 补完）回车，Zsh 会自动调用关联打开
# From : http://linuxtoy.org/archives/zsh-tip.html

# 依赖选项，默认就开启
#autoload -U zsh-mime-setup
#zsh-mime-setup
# alias 形式来实现文件关联 , 其中 png 为文件扩展名，= 右边的 feh 为关联的程序。-s 必不可少

for i in jpg png gif; alias -s $i=feh
for i in avi rmvb wmv; alias -s $i=mplayer
#alias -s txt=$EDITOR
#alias -s gz=tar -xzvf
#alias -s bz2=tar -xjvf
#alias -s html=$BROWSER
#alias -s php=$BROWSER
#
#alias -s org=$BROWSER
#alias -s com=$BROWSER
#alias -s net=$BROWSER
#
#alias -s sxw=soffice
#alias -s doc=soffice
#alias -s java=$EDITOR
#alias -s PKGBUILD=$EDITOR

# }}}

# [ 路径别名  ] #{{{
#--------------------------------------------
# 使用 cd ~XXX 快速进入自定义目录

hash -d a="${HOME}/.config/awesome/"
hash -d b="${HOME}/book/"
hash -d x="${HOME}/text/"
hash -d c="${HOME}/code/"
hash -d d="${HOME}/code/django/"
hash -d m="/home/download/m"
hash -d o="/var/log/"
hash -d p="${HOME}/pic/"
hash -d u="/mnt/usb/"
hash -d pkg="/var/cache/pacman/pkg"

# [?] 进入到相应目录，提示符会显示 ~e
#hash -d e="/etc"
#hash -d c="/etc/conf.d"
#hash -d r="/etc/rc.d"
#hash -d X="/etc/X11"

#}}}





# }}}

# [ 自定义 函数 ] #{{{
#--------------------------------------------

# [ 目录 堆栈 ]# {{{
#--------------------------------------------
# 空行按[tab] 自动输出 cd 提示
# cd    [tab] 再按 [tab] 开始遍历当前目录
# cd -  [tab] 打开 directory stack 菜单
# cd -- [tab] 变为 +[tab] （负负得正）逆序 directory stack
user-complete(){
    case $BUFFER in
        # "cd --" 替换为 "cd +"
        "cd --" )
        BUFFER="cd +"
        zle end-of-line
        zle expand-or-complete
        ;;
        # "cd +-" 替换为 "cd -"
        "cd +-" )
        BUFFER="cd -"
        zle end-of-line
        zle expand-or-complete
        ;;
        # 空行自动输入 "cd "
        "" )
        BUFFER="cd "
        zle end-of-line
        zle expand-or-complete
        ;;
        * )
        zle expand-or-complete
        ;;
    esac
}
# 调用 user-complete 函数
zle -N user-complete
# 绑定到 快捷键 tab
bindkey "\t" user-complete

# }}}

# [ 在命令前插入 sudo  ] #{{{
#--------------------------------------------
# 输完命令，命令若要 root 权限，一般采用：[Ctrl+a] sudo (空格）[Ctrl+e]
# 按两下 ESC 键，在命令开头补全 sudo

sudo-command-line()
{
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    #光标移动到行末
    zle end-of-line
}
zle -N sudo-command-line
#定义快捷键为： [Esc] [Esc]
bindkey "\e\e" sudo-command-line

#}}}

# [ 高端应用 ]# {{{
#--------------------------------------------

# whence 类似 which 但当没有查询到结果时，不提示错误
bin-exist() {[[ -x `whence -cp $1 2>/dev/null` ]]}

#recalculate track db gain with mp3gain
(bin-exist mp3gain) && id3gain() { find $* -type f -iregex ".*\(mp3\|ogg\|wma\)" -exec mp3gain -r -s i {} \; }

#ccze for log viewing
# tac 是 cat 反义词，倒序输出文件
(bin-exist ccze) && lless() { tac $* |ccze -A |less }

#man page to pdf
(bin-exist ps2pdf) && man2pdf() {  man -t ${1:?Specify man as arg} | ps2pdf -dCompatibility=1.3 - - > ${1}.pdf; }

# }}}



# }}}

# [ XXX ] #--------------------------------------------

# [ 杂项  ] #{{{
#--------------------------------------------

# 禁用 core dumps，man zshbuiltins
limit coredumpsize 0

# report to me when people login/logout
watch=(notme)
# replace the default beep with a message
#ZBEEP="\e[?5h\e[?5l"        # visual beep

## 除了字母和数字之外还有哪些符号是一个单词可以包含的
## 默认值: ?*_-.[]~=/&;!#$%^(){}<>
## 去掉 / 在使用 C-w 删除单词时，可以逐一删除路径，而不是一次整个删除路径
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'


#[Esc][h] man 当前命令时，显示简短说明
alias run-help >&/dev/null && unalias run-help
autoload run-help

# force rehash 当没找到命令时，强制 rehash
# http://zshwiki.org/home/examples/compsys/general
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1    # Because we did not really complete anything
}
#一启动 zsh 的时候顺带自动开启 screen 呢
#在~/.zshrc中加入 echo "$TERM"| grep -vq "screen" && \ exec screen zsh




#}}}

# [ Refer ]# {{{
#--------------------------------------------

# Zsh 技巧三则
# From : http://linuxtoy.org/archives/zsh_per_dir_hist.html

# zsh里代表当前目录下最后修改的文件的alias
# From : http://roylez.heroku.com/2010/03/06/zsh-recent-file-alias.html

# roylez    # From : https://github.com/roylez/dotfiles/raw/master/.zshrc
# gogonkt   # From : https://github.com/gogonkt/dotG/blob/master/.zshrc

# [ man ]# {{{
#--------------------------------------------
# setopt <选项>     -->     man zshoptions
# autoload  <选项>  -->     man zshmisc

# 补全              -->     man zshcompctl / zshcompwid
# 交互 / 编辑       -->     man zshzle
# 函数

# zsh                Zsh overview (this section)
# zshroadmap         Informal introduction to the manual
# zshmisc            Anything not fitting into the other sections
# zshexpn            Zsh command and parameter expansion
# zshparam           Zsh parameters
# zshoptions         Zsh options
# zshbuiltins        Zsh built-in functions
# zshzle             Zsh command line editing
# zshcompwid         Zsh completion widgets
# zshcompsys         Zsh completion system
# zshcompctl         Zsh completion control
# zshmodules         Zsh loadable modules
# zshcalsys          Zsh built-in calendar functions
# zshtcpsys          Zsh built-in TCP functions
# zshzftpsys         Zsh built-in FTP client
# zshcontrib         Additional zsh functions and utilities
# XXX zshall             Meta-man page containing all of the above

# }}}

#   [ 提示符颜色 ASCII 编码 ]# {{{
#--------------------------------------------
#   Black   0;30
#   Red     0;31
#   Green   0;32
#   Brown   0;33
#   Blue    0;34
#   Purple  0;35
#   Cyan    0;36

# }}}

# }}}


