;; -*- mode: emacs-lisp -*-
;; Time-stamp: "2015-04-14 20:27:51 i"

;; Help 帮助
;; M-x apropos 交互式搜索关键词：函数，变量
;; C-h a 正则匹配 **命令**
;; C-h f 函数，支持 *通配符* 匹配，输入 *keyword*，然后按 tab 会展开补全
;; C-h v 变量，支持 *通配符* 匹配
;; C-h k 快捷键
;; C-h m 当前 mode 文档
;; C-h i 查看 info 文档
;; C-h l 最近输入的 300 个按键

;; C-x C-e 执行光标所在语句
;; 选择一个 region , M-x eval-region
;; 重载整个配置文件
;;    M-x eval-buffer
;;    M-x load-file ~/.emacs

;; M-x customize 进入交互式定制 C-h i 进入 Easy Customization 文档页面
;; M-x customize-face 显示所有 face 编辑项
;; M-x customize-apropos


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

;; auto-save-mode 模式 M-x recover-file 恢复文件
;; 默认在当前目录生成 #file# 文件，间歇地保存对 buffer 的修改
;; http://emacswiki.org/emacs/AutoSave
;;(setq auto-save-mode nil)

;; 保存文件时，不将源文件备份为 file~ : C-h v make-backup-files
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Backup-Copying.html
(setq-default make-backup-files 'nil)

;; 查找时严格区分大小写
;;(setq case-fold-search nil)

;; 退出时，需要提示
;;(setq confirm-kill-emacs t)

;; 使用 yes / no 简称 y / n
;; http://www.emacswiki.org/emacs/YesOrNoP
(defalias 'yes-or-no-p 'y-or-n-p)

;; coding
;; --------------------------------------------

;; 显示行号
;(setq line-number-mode t)

;; 全局显示行号 (所有 buffer)
(global-linum-mode t)

;; 显示列号
(setq column-number-mode t)

;; 高亮选择区域，默认开启
;(transient-mark-mode t)

;; 高亮当前所在行，默认使用 emacs 高亮色。若要与主题一致参考：
;; http://ann77.emacser.com/Emacs/EmacsHighlightLine.html
(global-hl-line-mode 1)

;; 语法高亮
(global-font-lock-mode t)

;; 高亮标记配对的括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; 显示 trailing whitespace 空白字符
(setq-default show-trailing-whitespace t)

;; 使用 空格 代替 Tab 缩进
;;(setq indent-tabs-mode nil)


;; mouse
;; --------------------------------------------

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

;; mode
;; --------------------------------------------

;; http://emacsworld.blogspot.com/2008/06/changing-default-mode-of-scratch-buffer.html
;; 修改 *scratch* 草稿 默认 mode 为：text-mode
(setq initial-major-mode 'text-mode)

;; fundamental-mode (默认) 改为 text-mode
(setq default-major-mode 'text-mode)


;; Buffer 缓冲编辑区
;; --------------------------------------------

;; Indent Tab 缩进
;; --------------------------------------------


;; TIME / DATE 时间
;; --------------------------------------------

;; minibuffer 时间显示格式
(display-time-mode 1)

;; 时间 24小时制，显示日期
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;; 时间的变化频率，默认 60，导致时间格式从默认格式变为自定义格式需要 60 秒时间
(setq display-time-interval 60)

;; 显示时间的格式，启动 emacs 不会马上变为自定义格式，需要在时间刷新时才变化
(setq display-time-format "| %m-%d %H:%M |")

;; Emacs 21+ 版本支持时间戳：http://www.emacswiki.org/emacs/TimeStamp
;; 手动更新时间戳：M-x time-stamp
;; http://home.lupaworld.com/home-space-uid-28556-do-blog-id-136002.html
;; emacs 22.1 已经弃用 'write-file-hooks C-h f time-stamp
(add-hook 'before-save-hook 'time-stamp)

;; ENCODING 中文
;; --------------------------------------------

;;; [ 不管用 ? ] 告别 LC_CTYPE=zh_CN.utf8 emacs 激活 fcitx 输入法
;;; http://shellfly.org/imitated-effiective-emacs
;(setenv "LC_CTYPE" "zh_CN.utf8")

;; 屏蔽 C - <Space>，启用输入法
(global-set-key (kbd "C-SPC") 'nil)
(global-set-key (kbd "C-m") 'set-mark-command)

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

;; 光标样式：竖线 bar，方块 box
;;(setq-default cursor-type 'bar)
(setq-default cursor-type 'box)

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

;; M-w 复制内容到系统剪切板
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

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
;;(set-face-attribute 'mode-line-highlight nil :background "light sky blue" :box nil :weight bold)
;;(set-face-attribute 'mode-line-inactive nil :box nil)






