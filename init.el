
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
  (setq url-proxy-services '(("http" . "10.42.5.10:8000")))
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
  (setq url-proxy-services '(("http" . "10.42.5.10:8000")))
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