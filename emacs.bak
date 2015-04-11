;; -*- mode: emacs-lisp -*-
;; Time-stamp: "2013-04-02 20:19:08 ink"

;; Help 帮助
;; C-h f 查看 函数 文档，支持 *通配符* 来匹配，输入 *keyword*，然后按 tab 会展开补全
;; C-h v 查看 变量值 和 说明，也支持 *通配符* 来匹配
;; C-h a 使用正则表达式来查找命令
;; C-h k 描述我接下来的键入动作
;; C-h l 显示最近的 100 个键入动作
;; C-h m 描述当前的 mode
;; C-h i 查看 info 文档

;; C-x C-e 执行光标所在语句
;; 选择一个 region , M-x eval-region
;; 重载整个配置文件
;;    M-x eval-buffer
;;    M-x load-file ~/.emacs

;; Base 基础
;; --------------------------------------------

;; [ 不管用 ? ] 告别 LC_CTYPE=zh_CN.utf8 emacs 激活 fcitx 输入法
;; http://shellfly.org/imitated-effiective-emacs
(setenv "LC_CTYPE" "zh_CN.utf8")

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



;; Edit 编辑
;; --------------------------------------------

;; 默认 打开文件 缺省路径
;;(setq default-directory "~/")
;;(setq-default default-directory "~/")
;;(setq command-line-default-directory "~/")

;; 默认 emacs 打开文件时，会以当前所在目录作为打开路径，而不是默认目录
;; 若要编辑当前文件所在目录的其他文件使用 C-x C-v
;; http://stackoverflow.com/questions/3364221/change-the-default-directory-of-emacs-with-cocoa-emacs
;; http://stackoverflow.com/questions/354490/preventing-automatic-change-of-default-directory
(add-hook 'find-file-hook
    (lambda ()
        (setq default-directory command-line-default-directory)))

;; 在行首 C-k 时，同时删除该行
;;(setq-default kill-whole-line t)

;; 自动重载更改的文件
(global-auto-revert-mode 1)

;; 当光标在行尾上下移动的时候，始终保持在行尾
(setq track-eol t)

;; 允许设置大小写 [?]
;(put 'upcase-region 'disabled nil)
;(put 'downcase-region 'disabled nil)

;; 默认 Emacs 里 M-w 不能复制内容到系统的剪切板
;; 如果需要让 M-w 复制内容到剪切板
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)


;; ;; http://emacswiki.org/emacs/CopyAndPaste
;; ; (transient-mark-mode 1)  ; Now on by default: makes the region act quite like the text "highlight" in many apps.
;; ; (setq shift-select-mode t) ; Now on by default: allows shifted cursor-keys to control the region.
;; (setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
;; (setq x-select-enable-primary nil)  ; stops killing/yanking interacting with primary X11 selection
;; (setq x-select-enable-clipboard t)  ; makes killing/yanking interact with clipboard X11 selection

;; ;; these will probably be already set to these values, leave them that way if so!
;; ; (setf interprogram-cut-function 'x-select-text)
;; ; (setf interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; ; You need an emacs with bug #902 fixed for this to work properly. It has now been fixed in CVS HEAD.
;; ; it makes "highlight/middlebutton" style (X11 primary selection based) copy-paste work as expected
;; ; if you're used to other modern apps (that is to say, the mere act of highlighting doesn't
;; ; overwrite the clipboard or alter the kill ring, but you can paste in merely highlighted
;; ; text with the mouse if you want to)
;; (setq select-active-regions t) ;  active region sets primary X11 selection
;; (global-set-key [mouse-2] 'mouse-yank-primary)  ; make mouse middle-click only paste from primary X11 selection, not clipboard and kill ring.

;; ;; with this, doing an M-y will also affect the X11 clipboard, making emacs act as a sort of clipboard history, at
;; ;; least of text you've pasted into it in the first place.
;; ; (setq yank-pop-change-selection t)  ; makes rotating the kill ring change the X11 clipboard.




;; 保存退出文件时的当前位置，编辑比较长的文档
;(require 'saveplace)
;(setq-default save-place t)




;; Mouse 鼠标
;; --------------------------------------------

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

;; 每次滚动一行，减少跳动，鼠标滚动会变慢 http://www.emacswiki.org/emacs/SmoothScrolling
(setq mouse-wheel-scroll-amount '(4 ((shift) . 4))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 4) ;; keyboard scroll one line at a time

;; Autosave every 500 typed characters
(setq auto-save-interval 500)

;; 平滑滚动：页面步进，页面边距，缓冲行数
;;    scroll-margin 3  ;; 光标不在行首滚屏闪动，光标会丢失
(setq scroll-step 1
      scroll-conservatively 10000)








;; UNKNOWN ======================

;; [?] echo-keystrokdes 控制 echo area 回显延时的变量，设为0秒，就永远不回显。设为-1秒，立即回显
(setq echo-keystrokes 0.01)





;; Buffer 缓冲编辑区
;; --------------------------------------------

;; 交互式切换补全 打开文件 / buffer 切换 （buffer 交互式补全 iswithb-mode）
;; C-x C-f 被绑定为: ido-find-file 若要使用默认 find-file，需要再按一次 C-f
;; (require 'ido)
;; (ido-mode t)

;; (when (require 'ido "ido" t)
;;   (ido-mode 'buffer)
;;   ;;(ido-mode)
;;   (setq ido-enable-flex-matching t)
;;   (setq ido-use-virtual-buffers t)
;;   (define-key ctl-x-map "\C-v" 'ido-find-file))

;; 对于同名 buffer 引用父目录来区分
;; http://lifegoo.pluskid.org/wiki/EmacsTip.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


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

;; http://stackoverflow.com/questions/6471803/making-emacs-tabs-behave-exactly-like-vims
(eval-after-load "cc-mode"
  '(define-key c-mode-map (kbd "TAB") 'self-insert-command))

(global-set-key (kbd "DEL") 'backward-delete-char)
(setq c-backspace-function 'backward-delete-char)

;; ;; @didi #emacs
;; (defun backward-delete-char-or-4 (rep)
;;   (interactive "p")
;;   (if (= 1 rep)
;;       (let ((pt (point)))
;;         (forward-char -4)
;;         (if (looking-at "    ")
;;             (delete-region (point) pt)
;;             (progn (goto-char pt)
;;                    (backward-delete-char 1))))
;;       (backward-delete-char rep)))

;; (local-set-key (kbd "DEL") 'backward-delete-char-or-4)
;; (add-hook 'text-mode-hook (lambda () (local-set-key (kbd "DEL") 'backward-delete-char-or-4)))

;; emacs 缩进线 guidline indention
;; http://www.emacswiki.org/emacs/BlankMode


;; #emacs @pjb : local-set-key in hooks, or global-set-key

;; mode 模式
;; --------------------------------------------

;; Org-mode
;; ----------------------

;; ;; http://lumiere.ens.fr/~guerry/u/org-mediawiki.el
;; ;; Export Org files to mediawiki: M-x org-mw-export RET
;; (require 'org-mediawiki)

;; (add-to-list 'load-path "~/.emacs.d/org-mode/")
;; (require 'org-export)

;; M-x gtd 快捷方式
;; http://www.yifeiyang.net/emacs/org-mode-for-gtd.html
 (defun gtd ()
   (interactive)
   (find-file "~/text/emacs/gtd/ink.org")
 )

(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
        (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")))

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

;;;; 对拷贝的代码块自动重新格式化 http://zhuoqiang.me/a/torture-emacs#sec-5
;;;; 手动格式化：选中代码块，Ctrl-Alt-\
;;(dolist (command '(yank yank-pop))
;;  (eval
;;   `(defadvice ,command (after indent-region activate)
;;      (and (not current-prefix-arg)
;;           (member major-mode
;;                   '(emacs-lisp-mode
;;                     lisp-mode
;;                     scheme-mode
;;                     haskell-mode
;;                     ruby-mode
;;                     python-mode
;;                     c-mode
;;                     c++-mode
;;                     objc-mode
;;                     latex-mode
;;                     js-mode
;;                     plain-tex-mode))
;;           (let ((mark-even-if-inactive transient-mark-mode))
;;             (indent-region (region-beginning) (region-end) nil))))))
;;



;; Folding 折叠
;; --------------------------------------------

;; http://www.emacswiki.org/emacs/HideShow
;; http://article.yeeyan.org/view/179850/185790
;; M-x hs-minor-mode 激活之后，menu 出现 [Hide/Show] 菜单
;; 进入下面的 mode 时自动开启自带的 hide show mode 折叠
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

;; 定义 F1 开关折叠函数
(global-set-key [f1] 'hs-toggle-hiding)

;; Bookmark 书签
;; --------------------------------------------

;; 保存书签的文件路径及文件名，默认：~/.emacs.bmk
;(setq bookmark-default-file "~/.emacs.d/.emacs.bmk")

;; 同步更新书签文件 或 退出时保存，默认: t
;(setq bookmark-save-flag t)



;; TIME / DATE 时间
;; --------------------------------------------

;; minibuffer 时间显示格式
(display-time-mode 1)

;; 时间 24小时制，显示日期
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;;; 时间的变化频率，默认 60，导致时间格式从默认格式变为自定义格式需要 60 秒时间
;(setq display-time-interval 60)

;; 显示时间的格式，启动 emacs 不会马上变为自定义格式，需要在时间刷新时才变化
(setq display-time-format "| %m-%d %H:%M |")

;; Emacs 21+ 版本支持时间戳：http://www.emacswiki.org/emacs/TimeStamp
;; 自动更新时间戳：在文件的开头 8 行，添加 Time-stamp: <时间戳> 标记
;; 注意：Time-stamp 首字母必须大写，Time-stamp：后面必须有一个空格
;; 使用命令手动更新时间戳：M-x time-stamp
;; 中文参考：http://home.lupaworld.com/home-space-uid-28556-do-blog-id-136002.html
(add-hook 'write-file-hooks 'time-stamp)

;;;; 自定义时间戳 time-stamp 格式
;;;; %:u，更新时用登录 Linux 的用户名替换
;;;; %04y-%02m-%02d，年-月-日 "YYYY-MM-DD"
;;;; %02H:%02M:%02S，时:分:秒 "HH:MM:SS"
;;(setq time-stamp-format
;;          "由 %:u 修改 时间：%04y-%02m-%02d %02H:%02M:%02S"
;;          time-stamp-active t
;;          time-stamp-warn-inactive t)
;;






;; ENCODING 中文
;; --------------------------------------------

;; 屏蔽 C - <Space>，启用输入法
(global-set-key (kbd "C-SPC") 'nil)

;; 中文 字符 编码 encoding
;; http://blog.waterlin.org/articles/set-emacs-default-coding-system.html
;; C-x <RET> r gbk 或 M-x revert-buffer-with-coding-system 指定编码，重新 *读入* 文件
;; C-h C 或 M-x describe-coding-system 查看当前文件编码信息

;; 即使 LC_CTYPE=zh_CN.UTF-8 仍定义 emacs 默认语音为 English 避免帮助文档变为中文
;;(set-language-environment 'English)
;; C-x <RET> l 可以补全查看变量取值
(set-language-environment 'UTF-8)

;; [ 读取 / 新建 ] 新建 buffer 编码 和读取文件的字符编码顺序 (读取文档的时，解析 buffer 编码顺序)
;; 可以 M-x prefer-coding-system 手动调整
(prefer-coding-system 'utf-8)

;; [ 写入 ] 默认 buffer 编码是 utf-8 (写文件)
;; 23.2 之后用 buffer-file-coding-system 替换 default-buffer-file-coding-system 变量
;;(setq default-buffer-file-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)

;; 终端的文件编码方式
(set-terminal-coding-system 'utf-8)
;; 键盘输入的编码方式
(set-keyboard-coding-system 'utf-8)
;; 读取或写入文件名的编码方式，默认: iso-latin-1
(setq file-name-coding-system 'utf-8)

;; 等宽：中文字体 == 2 个英文字体
;; http://donneryst.com/blog/emacs中达成中英文混排表格对齐效果.html
;; 指定默认英文字体为 Dejavu Sans Mono 大小 10
(set-default-font "Dejavu Sans Mono 10")

;; 前面一串"(if...lambda...(with-select-frame frame ())...)" 是个很好的函数框架
;; 是指 frame 创建后载入，用这个框架可以解决 --daemon 启动的问题
;; 只有 set-fontset-font 一句指定修改字符集 'unicode 字体为文泉驿等宽微米黑，大小为 12
(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (set-fontset-font "fontset-default"
                    'unicode "WenQuanyi Micro Hei Mono 12"))))
  (set-fontset-font "fontset-default" 'unicode "WenQuanYi Micro Hei Mono 12"))


;; CUSTOM 自定义
;; --------------------------------------------

;;;; 没有选中区域时，C-w 剪切光标所在行，不管光标的位置在哪里
;;;; 而 M-w ，则会复制光标所在行，不管光标的位置在行首还是行尾还是行中间的任意位置
;;;; 当选中区域时，C-w 和 M-w 功能和 Emacs 自带的没啥两样
;;;; http://blog.waterlin.org/articles/改造emacs的删除行和复制行操作.html
;;(defadvice kill-ring-save (before slickcopy activate compile)
;;  "When called interactively with no active region, copy a single line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (list (line-beginning-position)
;;	    (line-beginning-position 2)))))
;;
;;(defadvice kill-region (before slickcut activate compile)
;;  "When called interactively with no active region, kill a single line instead."
;;   (interactive
;;    (if mark-active (list (region-beginning) (region-end))
;;      (list (line-beginning-position)
;;	    (line-beginning-position 2)))))





;; PLUGINS plugins 插件
;; --------------------------------------------

;; 通过 "菜单" 修改的配置 将会保存在 custom-file 里
;(setq custom-file "~/.emacs.d/ink-custom.el")

;; 目录后面的斜杠不能省略，不能展开子目录
;; http://www.emacswiki.org/emacs/LoadPath
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")


;; Color Theme 色彩 主题
;; --------------------------------------------

;; ;; emacs 24 版本
;; (load-theme 'wombat t)
;; (set-face-attribute 'mode-line nil :box nil)

(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/themes/")
(require 'color-theme)

;; color-theme 自带主题，需要添加下面这行
;(color-theme-initialize)
;; M-x color-theme-select 选择后按 d 获取主题配置信息
;(color-theme-charcoal-black)

(add-to-list 'load-path "~/.emacs.d/theme/")
(load-file "~/.emacs.d/theme/color-theme-almost-monokai.el")
(color-theme-almost-monokai)

;; 取消状态栏 3D 样式，若放在主题前面，可能会被主题里面的样式覆盖
(set-face-attribute 'mode-line nil :box nil)


;; yasnippet 代码片段
;; --------------------------------------------
;;; http://www.emacswiki.org/emacs/Yasnippet
;(add-to-list 'load-path
;              "~/.emacs.d/yasnippet")
;(require 'yasnippet) ;; not yasnippet-bundle
;(yas/initialize)
;(yas/load-directory "~/.emacs.d/yasnippet/snippets")

;;;; http://cx4a.org/software/auto-complete/
;;(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1/")


;; auto-complete 自动补全
;; --------------------------------------------
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; 关闭 auto-acomplete 的帮助提示
(setq ac-use-quick-help nil)


;; pinbar tabbar
;; --------------------------------------------
;; http://emacswiki.org/emacs/PinBar
;; 需要使用 M-0 来手动将 buffer 与 tabbar 关联的
;; (require 'pinbar)
;; (global-set-key "\M-0" 'pinbar-add)
;; (pinbar-mode t)

;; tabbar
;; --------------------------------------------
;; http://emacswiki.org/emacs/TabBarMode
;; http://d.hatena.ne.jp/alfad/20100425/1272208744
;; http://d.hatena.ne.jp/plasticster/20110825/1314271209
;; http://d.hatena.ne.jp/tequilasunset/touch/20110103/p1

;; 取消以 * 开头的 buffer 显示 scratch / help /...
(require 'cl)
 (when (require 'tabbar nil t)
    (setq tabbar-buffer-groups-function
	  (lambda (b) (list "All Buffers")))
    (setq tabbar-buffer-list-function
          (lambda ()
            (remove-if
             (lambda(buffer)
               (find (aref (buffer-name buffer) 0) " *"))
             (buffer-list))))
    (tabbar-mode))

;; Disable the button that is displayed on the left
(setq tabbar-home-button-enabled "")
(setq tabbar-scroll-left-button-enabled "")
(setq tabbar-scroll-right-button-enabled "")
(setq tabbar-scroll-left-button-disabled "")
(setq tabbar-scroll-right-button-disabled "")

;; 颜色设置
(set-face-attribute
   'tabbar-default-face nil
   :family "Monospace"
   :height 1.0
   :background "#272821") ;; 背景色
  (set-face-attribute ;; disactive 标签页
   'tabbar-unselected-face nil
   :background "#272821"
   :foreground "grey60"
   :box nil)
  (set-face-attribute ;; 当前活动 buffer 标签页
   'tabbar-selected-face nil
   :background "#272821"
   :foreground "white"
   :bold t
   :box nil)

;; Width setting
(set-face-attribute
   'tabbar-separator-face nil
   :height 0.1)

(global-set-key (kbd "M-p") 'tabbar-forward-tab)
(global-set-key (kbd "M-n") 'tabbar-backward-tab)

;; markdown
;; --------------------------------------------
;; version: 2013–01–25: 1.9
(add-to-list 'load-path "~/.emacs.d/modes")
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist
             '("\\.md$\\|\\.mkd$\\|\\.txt$\\|\\.markdown$" . markdown-mode))

;; markdown 标题字体加大 Customize Font Faces
;; http://www.emacswiki.org/emacs/CustomizingFaces
;; https://gist.github.com/matthewmccullough/1658034
;; http://crshd.anapnea.net/2012/10/10/Headings-in-markdown-mode/
(custom-set-faces
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
`(markdown-header-face-1 ((t (:inherit markdown-header-face :height 2.0))))
`(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.8))))
`(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.6))))
`(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.4))))
`(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.2))))
`(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.1))))
;; `(org-level-1 ((t (:inherit org-level-1 :height 1.5))))
;; `(org-level-2 ((t (:inherit org-level-2 :height 1.3))))
)




;; GUI Style 样式
;; --------------------------------------------
;; GUI 配置放在后面，避免 color theme 主题里面自带的配置覆盖

;; http://blog.waterlin.org/articles/emacs-adjust-window-size-position.html
;; 设置 emacs 窗口 “大小尺寸” "位置"
(setq default-frame-alist
'(
;(font . "Monospace-10")
(height . 37)
(width . 100)
;(top . 80)
;(left . 80)
;(cursor-type . bar)
;(tool-bar-lines . 20)
;(menu-bar-lines . 20)
;(horizontal-scroll-bars . nil)
;(vertical-scroll-bars . nil)
;(background-color . "rgb:00/00/00")
;(foreground-color . "rgb:ff/ff/ff")
))

;; 使用 内置 buffer-file-name 显示文件路径
;; http://www.emacswiki.org/emacs/DotEmacsChallenge
(setq frame-title-format '(buffer-file-name "%f" ("%b")))

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

;; 取消 mode-line 状态栏 status bar 的 3d shadow 效果
;; http://www.svenhartenstein.de/Software/Emacs
;; http://ldc.usb.ve/docs/emacs/Optional-Mode-Line.html
(set-face-attribute 'mode-line nil :box nil)





;; 默认显示 100 列，之后换行
(setq default-fill-column 100)

;; 对于长度超过窗口尺寸的文本行，自动换行
(toggle-truncate-lines t)




;; NOT USE
;; --------------------------------------------

;;;; 打开图片显示功能
;;(setq auto-image-file-mode t)



