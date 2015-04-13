;; -*- mode: emacs-lisp -*-
;; Time-stamp: "2015-04-13 20:25:52 i"

;; Help 帮助
;; C-h f 查看 函数 文档，支持 *通配符* 来匹配，输入 *keyword*，然后按 tab 会展开补全
;; C-h v 查看 变量值 和 说明，也支持 *通配符* 来匹配
;; C-h a 正则匹配 **命令**
;; C-h k KEYS 快捷键 hotkey
;; C-h l 显示最近的 100 个键入动作
;; C-h m 当前 mode 文档
;; C-h i 查看 info 文档

;; C-x C-e 执行光标所在语句
;; 选择一个 region , M-x eval-region
;; 重载整个配置文件
;;    M-x eval-buffer
;;    M-x load-file ~/.emacs

;; TODO:
;; 1. ~/.emacs 只包含基础配置，插件配置放到 ~/.emacs.d/ 目录中，动态加载
;; 2. 判断 ~/.emacs.d/ 目录中是否存在插件，并进行加载


;; Base 基础
;; --------------------------------------------

;; 操作错误 闪屏提示
;(setq visible-bell t)

;; 关闭启动 emacs 默认页面
(setq inhibit-startup-message t)

;; 关闭 默认 scratch buffer 提示信息
(setq initial-scratch-message nil)

;; 自动保存模式，类似版本控制 自动保存，需要定义备份文件夹路径 [可自定义]
(setq auto-save-mode nil)

;; 编辑文件时，不将源文件备份为 ~filename
(setq-default make-backup-files 'nil)

;; 查找时严格区分大小写
;;(setq case-fold-search nil)

;; 显示行号
;(setq line-number-mode t)
;; 对所有 buffer 全局开启 行号
(global-linum-mode t)

;; 显示列号
(setq column-number-mode t)

;; 高亮选择区域，默认开启
;(transient-mark-mode t)

;; 高亮当前所在行，使用 Emacs 默认的高亮色
;; 若要与主题一致参考 http://ann77.emacser.com/Emacs/EmacsHighlightLine.html
(global-hl-line-mode 1)
;; 或者
;(require 'hl-line)
;(hl-line-mode 1)



;; 默认文本模式是 fundamental-mode 改为：text-mode
(setq default-major-mode 'text-mode)

;; http://emacsworld.blogspot.com/2008/06/changing-default-mode-of-scratch-buffer.html
;; 修改 *scratch* 草稿 默认 mode 为：text-mode
(setq initial-major-mode 'text-mode)

;; 退出时，需要提示
;;(setq confirm-kill-emacs t)

;; http://www.emacswiki.org/emacs/YesOrNoP
;; yes / no 使用 y / n 简称
(defalias 'yes-or-no-p 'y-or-n-p)


;; 默认 Emacs 里 M-w 不能复制内容到系统的剪切板
;; 如果需要让 M-w 复制内容到剪切板
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)


;; 设置光标为竖线
;;(setq-default cursor-type 'bar)
;; 设置光标为方块
(setq-default cursor-type 'box)

;; 启用鼠标滚轮
(mouse-wheel-mode t)

;; 鼠标 自动聚焦 frame，window 或 minibuffer
(setq mouse-autoselect-window t)

;; (鼠标中键) 在光标处粘贴，而不是鼠标指针处
(setq mouse-yank-at-point t)

;; 光标靠近鼠标指针时，让鼠标指针自动让开
;(mouse-avoidance-mode 'animate)

;; 滚屏时，锁定光标位置
(scroll-lock-mode t)

;;; 每次滚动一行，减少跳动，鼠标滚动会变慢 http://www.emacswiki.org/emacs/SmoothScrolling
;(setq mouse-wheel-scroll-amount '(4 ((shift) . 4))) ;; one line at a time
;(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
;(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;(setq scroll-step 4) ;; keyboard scroll one line at a time

;;; 平滑滚动：页面步进，页面边距，缓冲行数
;;;    scroll-margin 3  ;; 光标不在行首滚屏闪动，光标会丢失
;(setq scroll-step 1
;      scroll-conservatively 10000)


;; Buffer 缓冲编辑区
;; --------------------------------------------

;; Indent Tab 缩进
;; --------------------------------------------
;; 插入 tab : C-q tab

;; 格式化源程序或者其他文件是用 TAB 还是 SPACE 呢?
;; http://emacser.com/ann77/Emacs/EmacsSpaceOrTab.html
;; 使用 空格 space 代替 TAB 字符作为 缩进，格式化字符
;;(setq-default indent-tabs-mode nil)
;;(setq indent-tabs-mode nil)

;;(setq-default 'tab-width 4)
;; XXX 怎么使用 set 设置变量
;;(setq tab-width 4)
;;(loop for x downfrom 40 to 1 do
;;      (setq tab-stop-list (cons (* x (default-value tab-width)) tab-stop-list)))

;;;; http://stackoverflow.com/questions/69934/set-4-space-indent-in-emacs-in-text-mode
;; Both tab-width and tab-stop-list are needed
;; tab-width is used when DISPLAYING tabs
;; tab-stop-list determine tab stops when you ADD tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

;;;; http://stackoverflow.com/questions/6471803/making-emacs-tabs-behave-exactly-like-vims
;;(eval-after-load "cc-mode"
;;  '(define-key c-mode-map (kbd "TAB") 'self-insert-command))
;;
;;(global-set-key (kbd "DEL") 'backward-delete-char)
;;(setq c-backspace-function 'backward-delete-char)


;; Coding 代码
;; --------------------------------------------
;; 语法高亮
(global-font-lock-mode t)

;; FOR :: coding
;; 高亮标记配对的括号
(setq column-number-mode t)

;; 显示括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; 显示 trailing whitespace 空白字符
(setq-default show-trailing-whitespace t)

;; 使用 空格 代替 Tab 缩进
;;(setq indent-tabs-mode nil)


;; TIME / DATE 时间
;; --------------------------------------------

;; minibuffer 时间显示格式
(display-time-mode 1)

;; 时间 24小时制，显示日期
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;;; 时间的变化频率，默认 60，导致时间格式从默认格式变为自定义格式需要 60 秒时间
(setq display-time-interval 60)

;; 显示时间的格式，启动 emacs 不会马上变为自定义格式，需要在时间刷新时才变化
(setq display-time-format "| %m-%d %H:%M |")

;; Emacs 21+ 版本支持时间戳：http://www.emacswiki.org/emacs/TimeStamp
;; 自动更新时间戳：在文件的开头 8 行，添加 Time-stamp: <时间戳> 标记
;; 注意：Time-stamp 首字母必须大写，Time-stamp：后面必须有一个空格
;; 使用命令手动更新时间戳：M-x time-stamp
;; 中文参考：http://home.lupaworld.com/home-space-uid-28556-do-blog-id-136002.html
(add-hook 'write-file-hooks 'time-stamp)



;; ENCODING 中文
;; --------------------------------------------

;;; [ 不管用 ? ] 告别 LC_CTYPE=zh_CN.utf8 emacs 激活 fcitx 输入法
;;; http://shellfly.org/imitated-effiective-emacs
;(setenv "LC_CTYPE" "zh_CN.utf8")

;; 屏蔽 C - <Space>，启用输入法
(global-set-key (kbd "C-SPC") 'nil)
(global-set-key (kbd "s-SPC") 'set-mark-command)

;;;; 中文 字符 编码 encoding
;;;; http://blog.waterlin.org/articles/set-emacs-default-coding-system.html
;;;; C-x <RET> r gbk 或 M-x revert-buffer-with-coding-system 指定编码，重新 *读入* 文件
;;;; C-h C 或 M-x describe-coding-system 查看当前文件编码信息
;;
;;;; 即使 LC_CTYPE=zh_CN.UTF-8 仍定义 emacs 默认语音为 English 避免帮助文档变为中文
;;;;(set-language-environment 'English)
;;;; C-x <RET> l 可以补全查看变量取值
;;(set-language-environment 'UTF-8)
;;
;;;; [ 读取 / 新建 ] 新建 buffer 编码 和读取文件的字符编码顺序 (读取文档的时，解析 buffer 编码顺序)
;;;; 可以 M-x prefer-coding-system 手动调整
;;(prefer-coding-system 'utf-8)
;;
;;;; [ 写入 ] 默认 buffer 编码是 utf-8 (写文件)
;;;; 23.2 之后用 buffer-file-coding-system 替换 default-buffer-file-coding-system 变量
;;;;(setq default-buffer-file-coding-system 'utf-8)
;;(setq buffer-file-coding-system 'utf-8)
;;
;;;; 终端的文件编码方式
;;(set-terminal-coding-system 'utf-8)
;;;; 键盘输入的编码方式
;;(set-keyboard-coding-system 'utf-8)
;;;; 读取或写入文件名的编码方式，默认: iso-latin-1
;;(setq file-name-coding-system 'utf-8)
;;
;;;; 等宽：中文字体 == 2 个英文字体
;;;; http://donneryst.com/blog/emacs中达成中英文混排表格对齐效果.html
;;;; 指定默认英文字体为 Dejavu Sans Mono 大小 10
;;(set-default-font "Dejavu Sans Mono 10")

;;;; 前面一串"(if...lambda...(with-select-frame frame ())...)" 是个很好的函数框架
;;;; 是指 frame 创建后载入，用这个框架可以解决 --daemon 启动的问题
;;;; 只有 set-fontset-font 一句指定修改字符集 'unicode 字体为文泉驿等宽微米黑，大小为 12
;;(if (and (fboundp 'daemonp) (daemonp))
;;    (add-hook 'after-make-frame-functions
;;              (lambda (frame)
;;                (with-selected-frame frame
;;                  (set-fontset-font "fontset-default"
;;                    'unicode "WenQuanyi Micro Hei Mono 12"))))
;;  (set-fontset-font "fontset-default" 'unicode "WenQuanYi Micro Hei Mono 12"))



;; GUI Style 样式
;; --------------------------------------------
;; GUI 配置放在后面，避免 color theme 主题里面自带的配置覆盖

;;;; http://blog.waterlin.org/articles/emacs-adjust-window-size-position.html
;;;; 设置 emacs 窗口 “大小尺寸” "位置"
;;(setq default-frame-alist
;;'(
;;;(font . "Monospace-10")
;;(height . 37)
;;(width . 100)
;;;(top . 80)
;;;(left . 80)
;;;(cursor-type . bar)
;;;(tool-bar-lines . 20)
;;;(menu-bar-lines . 20)
;;;(horizontal-scroll-bars . nil)
;;;(vertical-scroll-bars . nil)
;;;(background-color . "rgb:00/00/00")
;;;(foreground-color . "rgb:ff/ff/ff")
;;))

;; 使用 内置 buffer-file-name 显示文件路径
;; http://www.emacswiki.org/emacs/DotEmacsChallenge
;(setq frame-title-format '(buffer-file-name "%f" ("%b")))

;; 隐藏工具栏 M-x tool-bar-mode
;; 使用 C-x C-e 立即执行时，结果不同
;; 值: 一直为空
(tool-bar-mode -1)
;; 值: 正负切换
;;(tool-bar-mode 'nil)

;; 隐藏 menu-bar 和 tool-bar
;(menu-bar-mode -1)
;(menu-bar-mode 0)

;; 隐藏滚动条，可以使用鼠标滚轮，新版 emacs 24.1 不能用 nil，必须用 0
;; http://blog.csdn.net/cherylnatsu/article/details/7663163
;; http://emacswiki.org/emacs/ScrollBar
(scroll-bar-mode -1)
;; 上面的配置无法生效，使用 set-scroll-bar-mode 生效
;;(set-scroll-bar-mode 'nil)
;; 取消光标闪烁
(blink-cursor-mode 0)

;; 光标颜色
;(set-cursor-color "green")

;; 取消 mode-line 状态栏 status bar 3D 样式，若放在主题前面，可能会被主题里面的样式覆盖
;; http://www.svenhartenstein.de/Software/Emacs
;; http://ldc.usb.ve/docs/emacs/Optional-Mode-Line.html

(set-face-attribute 'mode-line nil :box nil)




