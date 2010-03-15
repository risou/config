;; フォントセット追加
(create-fontset-from-ascii-font
 "-outline-MeiryoKe_Gothic-normal-r-normal-normal-12-*-*-*-*-*-iso8859-1"
 nil "mkgothic")
(set-fontset-font "fontset-mkgothic" 'japanese-jisx0208
		  '("MeiryoKe_Gothic" . "jisx0208-sjis"))
(set-fontset-font "fontset-mkgothic" 'katakana-jisx0201
		  '("MeiryoKe_Gothic" . "jisx0201-katakana"))

;; デフォルト値設定
(setq default-frame-alist
      (append (list '(alpha . 85)			;; 不透明度
		    '(background-color . "gray10")	;; 背景色
		    '(foreground-color . "white")	;; 文字色
		    '(font . "fontset-mkgothic")	;; フォント
		    '(width . 120)					;; 文字数/行
		    '(height . 40)					;; 列数
		    '(top . 100)					;; ウィンドウ開始位置（縦）
		    '(left . 100)					;; ウィンドウ開始位置（横）
		    '(cursor-color . "SlateBlue2")	;; カーソル色
		    )
	      default-frame-alist))

;; タイトルバーにファイル名を表示
(setq frame-title-format "%f")
;; ツールバーを非表示
(tool-bar-mode 0)
;; 行番号を表示
(require 'linum)
(global-linum-mode)
;; タブ幅を4に設定
(setq-default tab-width 4)
;; インデント幅を4に設定
(setq-default indent-level 4)
;; タブ文字を空白文字に戻さずに削除
(global-set-key [backspace] 'backward-delete-char)
;; オートインデント
(setq indent-line-function 'indent-relative-maybe)
(global-set-key "\C-m" 'reindent-then-newline-and-indent)
(global-set-key "\C-m" 'indent-new-comment-line)
;; 改行とかタブとか全角スペースとか
(setq jaspace-alternate-jaspace-string "□")
(setq jaspace-alternate-eol-string "\xab\n")
(setq jaspace-highlight-tabs ?> )
(defface jaspace-highlight-tab-face
	'((t (:background "gray50"))) nil)
(require 'jaspace)

;; 1行ずつスクロール
(setq scroll-step 1)
;; バックアップファイルの生成をOFF
(setq make-backup-files nil)
(setq auto-save-default nil)
;; 時計の表示
(display-time-mode 1)
;; Ctrl+hでバックスペース
(global-set-key "\C-h" 'backward-delete-char)

(global-font-lock-mode 1)

;; 初期画面非表示
(setq inhibit-startup-message t)

;; howm
(setq howm-menu-lang 'ja)
(require 'howm-mode)
