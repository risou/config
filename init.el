
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
(keyboard-translate ?\C-h ?\C-?)

;; C-x ? でヘルプ
(global-set-key (kbd "C-x ?") 'help-command)

;; 文字コードの指定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

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
(display-battery-mode t)
;; タイトルバーにフルパスを表示
(setq frame-title-format "%f")
;; 行番号を常に表示
(global-linum-mode t)
;; 半透明
(setq default-frame-alist
	  (append
	   (list
		'(alpha . (75 50))
		'(foreground-color . "white")
		'(background-color . "black")
		) default-frame-alist))

;; tabのサイズ
(setq-default tab-width 4)

;; color-theme
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-hober))

;; asciiフォント
(when (eq system-type 'darwin)
  (set-face-attribute 'default nil
					  :family "Ricty"
					  :height 140))
(when (eq system-type 'windows-nt)
  (set-face-attribute 'default nil
					  :family "Ricty"
					  :height 110))

;; 日本語フォント
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Ricty"))

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

;; redo+.elのインストール
;; (install-elisp "http://www.emacswiki.org/emacs/download/redo+.el")
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
  (package-initialize))

;; color-moccur
;; (auto-install-from-emacswiki "color-moccur.el")
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
(when (require 'anything nil t)
  (setq
   anything-idle-delay 0.3 ;; 候補を表示するまでの時間
   anything-input-idle-delay 0.2 ;; タイプして再描写までの時間
   anything-candidate-number-limit 100 ;; 候補の最大表示数
   anything-quick-update t ;; 候補が多いときに体感速度を早くする
   anything-enable-shortcuts 'alphabet ;; 候補選択ショートカットをアルファベットに
   )
  (when (require 'anything-config nil t)
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
;; M-yにanything-show-kill-ringを割り当てる
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)
;; anything-c-moccurの設定
;; (install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")
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
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
			   "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;; wgrep
;; M-x package-install RET wgrep RET
(require 'wgrep nil t)

;; undohist
;; (install-elisp "http://cx4a.org/pub/undohist.el")
(when (require 'undohist nil t)
  (undohist-initialize))

;; undo-tree
;; M-x package-install RET undo-tree RET
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; point-undo
;; (auto-install-from-emacswiki "point-undo.el")
(when (require 'point-undo nil t)
  (define-key global-map (kbd "M-[") 'point-undo)
  (define-key global-map (kbd "M-]") 'point-redo)
  )

;; nxml-mode
(add-to-list 'auto-mode-alist '("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'" . nxml-mode))
;; HTML5
;; cd ~/.emacs.d/public_repos
;; git clone git://github.com/hober/html5-el.git
;; cd ./html5-el
;; make relaxng
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
(defun css-mode-hooks ()
  "css-mode hooks"
  (setq cssm-indent-function #'cssm-c-style-indenter) ;; C style indent
  (setq cssm-indent-level 4) ;; indent-width
  (setq-default indent-tabs-mode t) ;; tab indent
  (setq cssm-newline-before-closing-bracket t))
(add-hook 'css-mode-hook 'css-mode-hooks)

;; js2-mode
;; M-x package-install RET js2-mode RET
(add-hook 'js2-mode 'js-indent-hook)

;; perl-mode を cperl-mode のエイリアスにする
(defalias 'perl-mode 'cperl-mode)
;; cperl-mode
(setq cperl-indent-level 4
	  cperl-continued-statement-offset 4
	  cperl-brace-offset -4
	  cperl-label-offset -4
	  cperl-indent-parens-as-block t
	  cperl-close-paren-offset -4
	  cperl-tab-always-indent t
	  cperl-highlight-variables-indiscriminately t)
;; perl flymake
(defun cperl-mode-hooks ()
  (flymake-mode t))
(add-hook 'cperl-mode-hook 'cperl-mode-hooks)
;; perl-completion
;; M-x install-elisp RET https://raw.github.com/imakado/perl-completion/master/perl-completion.el
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
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

;; ruby-mode indent
(setq ruby-indent-level 4
	  ruby-deep-indent-paren-style nil
	  ruby-indent-tabs-mode t)
;; ruby-electric
;; (install-elisp "https://raw.github.com/ruby/ruby/trunk/misc/ruby-electric.el")
(require 'ruby-electric nil t)
;; inf-ruby
;; (install-elisp "https://raw.github.com/ruby/ruby/trunk/misc/inf-ruby.el")
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
;; ruby-block
;; (auto-install-from-emacswiki "ruby-block.el")
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
(setq gtags-suggested-key-mapping t)
(require 'gtags nil t)

;; ctags
;; M-x package-install RET ctags RET
(require 'ctags nil t)
(setq tags-revert-without-query t)
;; (setq ctags-command "ctags -e -R")
(setq ctags-command "ctags -R --fields=\"+afikKlmnsSzt\" ")
(global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)

;; anything-for-tags
;; (auto-install-from-emacswiki "anything-gtags.el")
;; (auto-install-from-emacswiki "anything-exuberant-ctags.el")
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
;; (install-elisp "https://raw.github.com/byplayer/egg/master/egg-grep.el")
(when (executable-find "git")
  (require 'egg nil t))

;; multi-term
;; M-x package-install RET multi-term RET
(when (require 'multi-term nil t)
  (setq multi-term-program "/usr/local/bin/zsh"))

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

