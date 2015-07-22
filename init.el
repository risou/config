
;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
;; 引数のディレクトリとそのサブディレクトリを load-path に追加
(add-to-load-path "elisp" "conf" "public_repos")

;; C-m で改行時にインデント
;; (define-key global-map (kbd "C-m") 'newline-and-indent) ;; 下と同じ
(global-set-key (kbd "C-m") 'newline-and-indent)

;; C-h でバックスペース
;; (keyboard-translate ?\C-h ?\C-?)
(define-key key-translation-map [?\C-h] [?\C-?])

;; C-x ? でヘルプ
(global-set-key (kbd "C-x ?") 'help-command)

;; 文字コードの指定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

(custom-set-variables
 '(inhibit-default-init t)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t))

;; ファイル名の設定
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))
(when (eq system-type 'windows-nt)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932))

;; カラム番号も表示
(column-number-mode t)
;; ファイルサイズを表示
(size-indication-mode t)
;; 時計を表示
(setq display-time-24hr-format t)
(display-time-mode t)
;; バッテリー残量を表示
;; (display-battery-mode t)
;; タイトルバーにフルパスを表示
(setq frame-title-format "%f")
;; 行番号を常に表示
(global-linum-mode t)
(set-face-attribute 'linum nil
					:foreground "#ccc"
					:height 0.9)
(setq linum-format "%4d  ")
;; 半透明
(setq default-frame-alist
	  (append
	   (list
		;; '(alpha . (75 50))
 		'(alpha . (85 70))
 		'(width . 200)
 		'(height . 65)
 		'(top . 50)
 		'(left . 50)
		'(foreground-color . "white")
		'(background-color . "black")
		) default-frame-alist))

;; tabのサイズ
(setq-default tab-width 4)

;; color-theme
(add-to-list 'load-path "~/.emacs.d/el-get/color-theme")
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-hober))

;; customized color
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anything-bookmarks-su-face ((t (:foreground "magenta"))))
 '(anything-buffer-saved-out ((t (:foreground "magenta"))))
 '(message-header-xheader-face ((t (:foreground "cyan"))))
 '(minibuffer-prompt ((t (:foreground "cyan"))))
 '(my-hl-line-face ((t (:background "color-17" :weight bold)))))

;; asciiフォント
(when (eq system-type 'darwin)
  (let ((system-name (system-name)))
	(cond
	 ((string-match "rmb" system-name)
	  (set-face-attribute 'default nil
						  :family "Ricty"
						  :height 140)
	  )))
  )
(when (eq system-type 'windows-nt)
  (set-face-attribute 'default nil
					  :family "Migu 1M"
					  :height 100))

;; 日本語フォント
(when (eq system-type 'darwin)
  (let ((system-name (system-name)))
	(cond
	 ((string-match "rmb" system-name)
	  (set-fontset-font
	   nil 'japanese-jisx0208
	   (font-spec :family "Ricty")))
	 ))
  )
(when (eq system-type 'windows-nt)
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "Migu 1M")))
  
;; 行ハイライト
(defface my-hl-line-face
  '((((class color) (background dark))
	 (:background "NavyBlue" t))
	(((class color) (background light))
	 (:background "LightGoldenrodYellow" t))
	(t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)

;; 対応する括弧を強調
(setq show-paren-delay 0)

(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

;; バックアップ&オートセーブ
(add-to-list 'backup-directory-alist
			 (cons "." "~/emacs.d/backups/"))
(setq auto-save-file-name-transforms
	  `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;; 検索時にカーソルを単語の先頭に移動する
(defun isearch-forward-with-heading ()
  "Search the word your cursor looking at."
  (interactive)
  (command-execute 'backward-word)
  (command-execute 'isearch-forward))
(global-set-key "\C-s" 'isearch-forward-with-heading)

;; Window分割
;; prefixをC-zに
;; (define-key global-map "\C-z" (make-sparse-keymap))
;; C-c2回でWindow移動（Windowが1つの場合は2分割）
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
	(split-window-horizontally))
  (other-window 1))
(global-set-key "\C-c\C-c" 'other-window-or-split)
;; C-cC-rでリサイズ（hjkl）
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
		(current-width (window-width))
		(current-height (window-height))
		(dx (if (= (nth 0 (window-edges)) 0) 1 -1))
		(dy (if (= (nth 1 (window-edges)) 3) 1 -1)) ;; '3'は会社開発機での環境
		action c)
	(catch 'end-flag
	  (while t
		(setq action (read-key-sequence-vector (format "size[%dx%d]" (window-width) (window-height))))
		(setq c (aref action 0))
		(cond ((= c ?l) (enlarge-window-horizontally dx))
			  ((= c ?h) (shrink-window-horizontally dx))
			  ((= c ?j) (enlarge-window dy))
			  ((= c ?k) (shrink-window dy))
			  (t (let ((last-command-char (aref action 0))
					   (command (key-binding action)))
				   (when command (call-interactively command)))
				 (message "Quit")
				 (throw 'end-flag t)))))))
(global-set-key "\C-c\C-r" 'window-resizer)
;; C-c(hjkl)でWindow移動
(global-set-key "\C-cl" 'windmove-right)
(global-set-key "\C-ch" 'windmove-left)
(global-set-key "\C-cj" 'windmove-down)
(global-set-key "\C-ck" 'windmove-up)
;; Window移動時にループ可能にする
(setq windmove-wrap-around t)
;; C-c vで3分割
(defun split-n (n)
  "split window to N parts"
  (interactive "p")
  (if (= n 2)
	  (progn (split-window-horizontally) (other-window 2))
	(progn
	  (split-window-horizontally (/ (window-width) n))
	  (other-window 1)
	  (split-n (- n 1)))))
(defun split-3 ()
  (interactive)
  (split-n 3))
(global-set-key "\C-cv" 'split-3)

;; ;; カーソル移動1行ずつ再描画
;; (defun next-line-recenter()
;;   (interactive)
;;   (next-line)
;;   (recenter))
;; (define-key global-map "\C-n" 'next-line-recenter)

;; (defun previous-line-recenter()
;;   (interactive)
;;   (previous-line)
;;   (recenter))
;; (define-key global-map "\C-p" 'previous-line-recenter)
(setq scroll-conservatively 1)

;; eldocによるエコーエリアへの表示
(defun eldoc-print ()
  "lisp-mode-hooks"
  (when (require 'eldoc nil t)
	(setq eldoc-idle-delay 0.2)
	(setq eldoc-echo-area-use-multiline-p t)
	(turn-on-eldoc-mode)))
(add-hook 'emacs-lisp-mode-hook 'eldoc-print)

;; auto-installの設定
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  ;; (setq url-proxy-services '(("http" . "10.42.5.10:8000")))
  (auto-install-compatibility-setup))

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)

;; redo+.elのインストール
;; (install-elisp "http://www.emacswiki.org/emacs/download/redo+.el")
;; -> el-get
;; redo+の設定
(when (require 'redo+ nil t)
  ;; C-'にredoを割り当てる
  (global-set-key (kbd "C-'") 'redo))

;; package.elのインストール(24以降は不要)
;; M-x install-elisp RET http://bit.ly/pkg-el23 RET
;; package.elの設定
(when (require 'package nil t)
  (add-to-list 'package-archives
			   '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives
			   '("ELPA" . "http://tromey.com/elpa/"))
  ;; (setq url-proxy-services '(("http" . "10.42.5.10:8000")))
  ;; melpa.el のインストール
  ;; https://raw.github.com/milkypostman/melpa/master/melpa.el
  ;; (add-to-list 'package-archives
  ;; 			   '("melpa" . "http://melpa.milkbox.net/packages"))
  (package-initialize))

;; color-moccur
;; (auto-install-from-emacswiki "color-moccur.el")
;; -> el-get
(when (require 'color-moccur nil t)
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  (setq moccur-split-word t)
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  (when (and (executable-find "cmigemo")
			 (require 'migemo nil t))
	(setq moccur-use-migemo t)))

;; anything
;; M-x auto-install-batch RET anything RET
;; -> el-get
(when (require 'anything nil t)
  (setq
   anything-idle-delay 0.3 ;; 候補を表示するまでの時間
   anything-input-idle-delay 0.2 ;; タイプして再描写までの時間
   anything-candidate-number-limit 100 ;; 候補の最大表示数
   anything-quick-update t ;; 候補が多いときに体感速度を早くする
   anything-enable-shortcuts 'alphabet ;; 候補選択ショートカットをアルファベットに
   )
  (when (require 'anything-config nil t)
	(add-to-list 'anything-sources 'anything-c-source-emacs-commands)
	(setq anything-su-or-sudo "sudo"))
  (require 'anything-match-plugin nil t)
  (when (and (executable-find "cmigemo")
			 (require 'migemo nil t))
	(require 'anything-migemo nil t))
  (when (require 'anything-complete nil t)
	(anything-lisp-complete-symbol-set-timer 150))
  (require 'anything-show-completion nil t)
  (when (require 'auto-install nil t)
	(require 'anything-auto-install nil t))
  (when (require 'descbinds-anything nil t)
	(descbinds-anything-install)))
(define-key global-map (kbd "C-;") 'anything)
(define-key anything-map (kbd "C-;") 'abort-recursive-edit)
(define-key global-map (kbd "C-c r") 'anything-imenu)
;; M-yにanything-show-kill-ringを割り当てる
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)
;; anything-c-moccurの設定
;; (install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")
;; -> el-get
(when (require 'anything-c-moccur nil t)
  (setq
   anything-c-moccur-anything-idle-delay 0.1
   anything-c-moccur-hilight-info-line-flag t
   anything-c-moccur-enable-auto-look-flag t
   anything-c-moccur-enable-initial-pattern t)
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur))

;; ddskk info
(require 'info)
(add-to-list 'Info-additional-directory-list "~/.emacs.d/info")

;; ddskk
(setq skk-user-directory "~/.emacs.d/ddskk/")
(when (require 'skk-autoloads nil t)
  (global-set-key (kbd "C-x C-j") 'skk-mode)
  (setq skk-byte-compile-init-file t))

;; dired-xのdired-jumpコマンドがddskkとかぶるので変更
(when (require 'dired-x nil t)
  (global-set-key (kbd "C-x j") 'dired-jump))

;; auto-complete
;; M-x package-install RET auto-complete RET
;; -> el-get
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
			   "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;; wgrep
;; M-x package-install RET wgrep RET
;; -> el-get
(require 'wgrep nil t)

;; undohist
;; (install-elisp "http://cx4a.org/pub/undohist.el")
;; -> el-get
(when (require 'undohist nil t)
  (undohist-initialize))

;; undo-tree
;; M-x package-install RET undo-tree RET
;; -> el-get
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; point-undo
;; (auto-install-from-emacswiki "point-undo.el")
;; -> el-get
(when (require 'point-undo nil t)
  (define-key global-map (kbd "M-[") 'point-undo)
  (define-key global-map (kbd "M-]") 'point-redo)
  )

;; elscreen
;; curl -O http://kanji.zinbun.kyoto-u.ac.jp/~tomo/lemi/dist/apel/apel-10.8.tar.gz
;; tar xvf apel-10.8.tar.gz
;; cd ./apel-10.8.tar.gz
;; make LISPDIR=~/.emacs.d/elisp VERSION_SPECIFIC_LISPDIR=~/.emacs.d/elisp INFODIR=~/.emacs.d/info EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs
;; make install LISPDIR=~/.emacs.d/elisp VERSION_SPECIFIC_LISPDIR=~/.emacs.d/elisp INFODIR=~/.emacs.d/info
;; curl -O ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/elscreen-1.4.6.tar.gz
;; tar xvf elscreen-1.4.6.tar.gz
;; cp ./elscreen-1.4.6/elscreen.el ~/.emacs.d/elisp
;; -> el-get
(setq elscreen-prefix-key (kbd "C-t"))
(when (require 'elscreen nil t)
  (when (>= emacs-major-version 24)
	(elscreen-start))
  (if window-system
	  (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
	(define-key elscreen-map (kbd "C-z") 'suspend-emacs)))

;; cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; whitespace-mode
(when (require 'whitespace nil t)
  (setq whitespace-style '(face tabs tab-mark  spaces space-mark trailing))
  (setq whitespace-display-mappings
		'((space-mark ?\u3000 [?\u25a1])
		  (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
  (setq whitespace-space-regexp "\\(\u3000+\\)")
  (setq whitespace-trailing-regexp "\\(\u0020+$\\)")
  (set-face-foreground 'whitespace-tab "#adff2f")
  (set-face-background 'whitespace-tab 'nil)
  (set-face-underline 'whitespace-tab t)
  (set-face-foreground 'whitespace-space "#7cfc00")
  (set-face-background 'whitespace-space 'nil)
  (set-face-bold-p 'whitespace-space t)
  (set-face-foreground 'whitespace-trailing "#ff0000")
  (set-face-background 'whitespace-trailing 'nil)
  (set-face-underline 'whitespace-trailing t)
  (global-whitespace-mode 1)
  )

;; nxml-mode
(add-to-list 'auto-mode-alist '("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'" . nxml-mode))
;; HTML5
;; cd ~/.emacs.d/public_repos
;; git clone git://github.com/hober/html5-el.git
;; cd ./html5-el
;; make relaxng
;; -> el-get
(eval-after-load "rng-loc"
  '(add-to-list 'rng-schema-locating-files
				"~/.emacs.d/public_repos/html5-el/schemas.xml"))
(require 'whattf-dt)
;; </ を入力すると自動的にタグを閉じる
(setq nxml-slash-auto-complete-flag t)
;; M-TAB でタグを補完する
(setq nxml-bind-meta-tab-to-complete-flag t)
;; nxml-mode で auto-complete-mode を利用する
(add-to-list 'ac-modes 'nxml-mode)

;; altanative css-mode
;; M-x install-elisp RET http://www.garshol.priv.no/download/software/css-mode/css-mode.el RET
;; -> el-get
(defun css-mode-hooks ()
  "css-mode hooks"
  (setq cssm-indent-function #'cssm-c-style-indenter) ;; C style indent
  (setq cssm-indent-level 4) ;; indent-width
  (setq-default indent-tabs-mode t) ;; tab indent
  (setq cssm-newline-before-closing-bracket t))
(add-hook 'css-mode-hook 'css-mode-hooks)

;; js2-mode
;; M-x package-install RET js2-mode RET
;; -> el-get
(add-hook 'js2-mode 'js-indent-hook)

;; cperl-mode ( from package-install )
;; (package-install 'cperl-mode)
;; -> el-get
;; perl-mode を cperl-mode のエイリアスにする
(defalias 'perl-mode 'cperl-mode)
;; .psgi, .t ファイルを cperl-mode で開く
(add-to-list 'auto-mode-alist '("\\.psgi$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.t\\'" . cperl-mode))
;; cperl-mode
(setq cperl-indent-level 4
	  cperl-continued-statement-offset 4
	  cperl-brace-offset -4
	  cperl-label-offset -4
	  cperl-indent-parens-as-block t
	  cperl-close-paren-offset -4
	  cperl-tab-always-indent t
;;	  cperl-indent-subs-specially nil) ;; need package-install
	  cperl-highlight-variables-indiscriminately t)
;; perl flymake
(defun cperl-mode-hooks ()
  (flymake-mode t))
(add-hook 'cperl-mode-hook 'cperl-mode-hooks)
;; perl-completion
;; M-x install-elisp RET https://raw.github.com/imakado/perl-completion/master/perl-completion.el
;; -> el-get
(defun perl-completion-hook ()
  (when (require 'perl-completion nil t)
	(perl-completion-mode t)
	(when (require 'auto-complete nil t)
	  (auto-complete-mode t)
	  (make-variable-buffer-local 'ac-sources)
	  (setq ac-sources
			'(ac-source-perl-completion)))))
(add-hook 'cperl-mode-hook 'perl-completion-hook)

;; yaml-mode
;; M-x package-install RET yaml-mode RET
;; el-get
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

;; ruby-mode indent
(setq ruby-indent-level 4
	  ruby-deep-indent-paren-style nil
	  ruby-indent-tabs-mode t)
;; ruby-electric
;; (install-elisp "https://raw.github.com/ruby/ruby/trunk/misc/ruby-electric.el")
;; -> el-get
(require 'ruby-electric nil t)
;; inf-ruby
;; (install-elisp "https://raw.github.com/ruby/ruby/trunk/misc/inf-ruby.el")
;; -> el-get
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
;; ruby-block
;; (auto-install-from-emacswiki "ruby-block.el")
;; -> el-get
(when (require 'ruby-block nil t)
  (setq ruby-block-highlight-toggle t))
;; ruby-mode-hook
(defun ruby-mode-hooks ()
  (inf-ruby-keys)
  (ruby-electric-mode t)
  (ruby-block-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hooks)

;; python-mode
;; M-x package-install RET python-mode RET
;; -> el-get

(require 'flymake)

;; javascript flymake
;; curl -O http://www.javascriptlint.com/download/jsl-0.3.0-mac.tar.gz
;; tar xvf jsl-0.3.0-mac.tar.gz
;; sudo cp ./jsl-0.3.0-mac/jsl /usr/local/bin/jsl
(defun flymake-jsl-init ()
  (list "jsl" (list "-process" (flymake-init-create-temp-buffer-copy
								'flymake-create-temp-inplace))))
(add-to-list 'flymake-allowed-file-name-masks
			 '("\\.js\\'" flymake-jsl-init))
(add-to-list 'flymake-err-line-patterns
			 '("^\\(.+\\)(\\([0-9]+\\)): \\(.*warning\\|SyntaxError\\): \\(.*\\)"
			   1 2 nil 4))

;; ruby flymake
(defun flymake-ruby-init ()
  (list "ruby" (list "-c" (flymake-init-create-temp-buffer-copy
						   'flymake-create-temp-inplace))))
(add-to-list 'flymake-allowed-file-name-masks
			 '("\\.rb\\'" flymake-ruby-init))
(add-to-list 'flymake-err-line-patterns
			 '("\\(.*\\):(\\([0-9]+\\)): \\(.*\\)" 1 2 nil 3))

;; python flymake
;; (install-elisp "https://raw.github.com/seanfisk/emacs/sean/src/lib/flymake-python.el")
(when (require 'flymake-python nil t)
  (setq flymake-python-syntax-checker "flake8")
  ;; (setq flymake-python-syntax-checker "pep8")
  )

;; gtags
;; curl -O http://tamacom.com/global/global-6.1.tar.gz
;; tar xvf global-6.1.tar.gz
;; cd global-6.1.tar.gz
;; ./configure
;; make
;; sudo make install
;; -> el-get
(setq gtags-suggested-key-mapping t)
(require 'gtags nil t)

;; ctags
;; M-x package-install RET ctags RET
;; -> el-get
(require 'ctags nil t)
(setq tags-revert-without-query t)
;; (setq ctags-command "ctags -e -R")
(setq ctags-command "ctags -R --fields=\"+afikKlmnsSzt\" ")
(global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)

;; anything-for-tags
;; (auto-install-from-emacswiki "anything-gtags.el")
;; -> el-get
;; (auto-install-from-emacswiki "anything-exuberant-ctags.el")
;; -> el-get
(when (and (require 'anything-exuberant-ctags nil t)
		   (require 'anything-gtags nil t))
  (setq anything-for-tags
		(list anything-c-source-imenu
			  anything-c-source-gtags-select
			  ;; anything-c-source-etags-select
			  anything-c-source-exuberant-ctags-select
			  ))
  (defun anything-for-tags ()
	"Preconfigured `anything' for anything-for-tags."
	(interactive)
	(anything anything-for-tags
			  (thing-at-point 'symbol)
			  nil nil nil "*anything for tags*"))
  (define-key global-map (kbd "M-t") 'anything-for-tags))

;; git
;; (install-elisp "https://raw.github.com/byplayer/egg/master/egg.el")
;; -> el-get
;; (install-elisp "https://raw.github.com/byplayer/egg/master/egg-grep.el")
;; (when (executable-find "git")
;;   (require 'egg nil t))
(require 'magit)
(set-face-foreground 'magit-diff-add "#b9ca4a")
(set-face-foreground 'magit-diff-del "#d54e453")
(set-face-background 'magit-item-highlight "#000000")
(define-key global-map (kbd "C-c m") 'magit-status)

;; multi-term
;; M-x package-install RET multi-term RET
(when (require 'multi-term nil t)
  (setq multi-term-program "/usr/local/bin/zsh"))

;; editorconfig
;; M-x package-install RET editorconfig RET
(load "editorconfig")
(setq edconf-exec-path "/usr/local/bin/editorconfig")

;; TRAMP でバックアップファイルを作成しない
(add-to-list 'backup-directory-alist
			 (cons tramp-file-name-regexp nil))

;; woman
(setq woman-cache-filename "~/emacs.d/.wmncach.el")
(setq woman-manpath '("/usr/share/man"
					  "/usr/local/share/man"
					  "/usr/local/share/man/ja"))
;; anything man
(setq anything-for-document-sources
	  (list anything-c-source-man-pages
			anything-c-source-info-cl
			anything-c-source-info-pages
			anything-c-source-info-elisp
			anything-c-source-apropos-emacs-commands
			anything-c-source-apropos-emacs-functions
			anything-c-source-apropos-emacs-variables))
(defun anything-for-document ()
  "Preconfigured `anything' for anything-for-document."
  (interactive)
  (anything anything-for-document-sources
			(thing-at-point 'symbol) nil nil nil
			"*anything for document*"))
(define-key global-map (kbd "s-d") 'anything-for-document)

;; Emacs server を起動
; (require 'server)
; (unless (server-running-p)
;   (server-start)
;   (remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function))

(require 'w3m-load)
