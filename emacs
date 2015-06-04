;; -*- mode: emacs-lisp -*-
;; Time-stamp: "2015-06-04 20:32:04 i"

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
;; Emacs 21+ 版本支持时间戳：手动更新时间戳：M-x time-stamp 
;; emacs 22.1 已经弃用 'write-file-hooks C-h f time-stamp
(add-hook 'before-save-hook 'time-stamp)
;; 使用 内置 buffer-file-name 显示文件路径
;; http://www.emacswiki.org/emacs/DotEmacsChallenge
;(setq frame-title-format '(buffer-file-name "%f" ("%b")))





;; coding
;; --------------------------------------------

;; 高亮当前所在行
(global-hl-line-mode 1)
;; mode line 显示行号
(line-number-mode 1)
;; mode line 显示列号
(column-number-mode 1)
;; 全局显示行号 (所有 buffer) 定义样式：M-x customize-group RET linum RET
;; (global-linum-mode 1)
;; 语法高亮
(global-font-lock-mode 1)
;; 高亮标记配对的括号，默认延时：0.125
(show-paren-mode 1)
(setq show-paren-style 'parentheses)
(setq show-paren-delay 0)
;; 括号自动配对
(electric-pair-mode)
;; 显示 trailing whitespace 空白字符
(setq-default show-trailing-whitespace t)

;; Indent Tab 缩进
;; --------------------------------------------
;; 使用 空格 代替 Tab 缩进 variable
;;(setq indent-tabs-mode nil)

;; mode
;; --------------------------------------------

;; http://emacsworld.blogspot.com/2008/06/changing-default-mode-of-scratch-buffer.html
;; 修改 *scratch* 草稿 默认 mode 为：text-mode
(setq initial-major-mode 'text-mode)
;; fundamental-mode (默认) 改为 text-mode
(setq default-major-mode 'text-mode)


;;; TIME / DATE 时间
;;; --------------------------------------------
;
;;; modeline 显示时间
;(display-time-mode 1)
;;; 时间 24 小时制，显示日期
;(setq display-time-24hr-format t)
;(setq display-time-day-and-date t)
;;; 时间的变化频率，默认 60，导致时间格式从默认格式变为自定义格式需要 60 秒时间
;(setq display-time-interval 60)
;;; 显示时间的格式，启动 emacs 不会马上变为自定义格式，需要在时间刷新时才变化
;(setq display-time-format "| %m-%d %H:%M |")



;; ENCODING 中文
;; --------------------------------------------

;; hotkey key bonding
;; --------------------------------------------
;; C-x C-e 执行 (read-key-sequence "?") 或 (read-event "?") 获取按键事件(序列)
;; C-SPC 启用输入法，Win-SPC 启用标记
(global-set-key (kbd "C-SPC") 'nil)
(global-set-key (kbd "s-SPC") 'set-mark-command)
(global-set-key (kbd "<f7>") 'linum-mode)

;; GUI Style 样式
;; --------------------------------------------

;; interactive function 开关工具栏：M-x tool-bar-mode
;; 值: 正负切换，大于 0 启用，小于等于 0 关闭
(tool-bar-mode 0)
(menu-bar-mode 1)
;; 隐藏滚动条，可以使用鼠标滚轮
;; http://emacswiki.org/emacs/ScrollBar
(set-scroll-bar-mode 'nil)
;; 取消光标闪烁
(blink-cursor-mode 0)
;; 光标颜色
(set-cursor-color "brown")
;; 光标样式：竖线 bar，方块 box
(setq-default cursor-type 'box)

;; M-w 复制内容到系统剪切板
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)


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

;; (setq scroll-margin 0
;;       scroll-conservatively 100000
;;       scroll-preserve-screen-position 1)

;; 快速恢复窗口分割状态: C-c <left-arrow>
;; http://segmentfault.com/a/1190000000456319
(when (fboundp 'winner-mode)
  (winner-mode)
  (windmove-default-keybindings))

;; Shift-<arrow keys> 切换窗口
;; https://wiki.archlinux.org/index.php/Emacs#Smart_window_switch
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; GUI 配置放在后面，避免 color theme 主题里面自带的配置覆盖
(defun customize-gui-setting ()
  "setting for emacs GUI mode"
  ;; 取消 mode-line 状态栏 status bar 3D 样式。放在 theme 前会被主题样式覆盖
  ;; http://www.svenhartenstein.de/Software/Emacs
  ;; http://ldc.usb.ve/docs/emacs/Optional-Mode-Line.html
  (set-face-attribute 'mode-line nil :box nil)
  (set-face-attribute 'mode-line-inactive nil :box nil)
  (set-face-attribute 'mode-line-highlight nil :box nil
          :background "light sky blue"
          :weight 'bold)
  ;; 只显示一侧 fringe
  ;;(set-fringe-style '(8 . 0))
  ;; 窗口 "位置 position" (top left) "大小 size" (height width)
  (setq default-frame-alist
    '( ;;(font . "Monospace-12")
      (top . 80) (left . 80) (height . 37) (width . 100)))
  ;; 等宽：中文字体 == 2 个英文字体
  ;; http://donneryst.com/blog/emacs中达成中英文混排表格对齐效果.html
  ;; Dejavu Sans Mono 10 文泉驿等宽微米黑 12
  ;; Envy Code R 11 文泉驿等宽微米黑 12
  ;;(set-default-font "Dejavu Sans Mono 10:bold")
  (set-fontset-font "fontset-default" 'unicode "WenQuanyi Micro Hei Mono 12")
  ;; Prelude config: display file path as GUI window(frame) title
  (setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))
)

;; 前面一串"(if...lambda...(with-select-frame frame ())...)" 是个很好的函数框架
;; 是指 frame 创建后载入，用这个框架可以解决 --daemon 启动的问题

(if (and (fboundp 'daemonp) (daemonp))
  (add-hook 'after-make-frame-functions
    (lambda (frame)
      (with-selected-frame frame
    (customize-gui-setting)
      )
    )
  )
  (customize-gui-setting)
)


;; (add-to-list 'default-frame-alist
;;              '(font . "Envy Code R-11:weight=bold:antialias=0"))

(add-to-list 'default-frame-alist
             '(font . "Envy Code R-11"))

;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(blink-cursor-mode nil)
;;  '(column-number-mode t)
;;  '(show-paren-mode t)
;;  '(tool-bar-mode nil))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:family "Envy Code R" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))
