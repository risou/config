;; cl は deplicated だよの警告を非表示にする
(setq byte-compile-warnings '(not cl-functions obsolete))

;; ----------------

;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

;; ----------------

;; 文字コードの設定
(set-language-environment 'Japanese)
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)

;; Ctrl-h をバックスペースに割り当て
(global-set-key "\C-h" 'delete-backward-char)

;; open ~/.emacs.d/init.el
(define-key global-map (kbd "\C-x ,") (lambda () (interactive) (switch-to-buffer (find-file-noselect "~/.emacs.d/init.el"))))

;; Window移動時にループ可能にする
(setq windmove-wrap-around t)

(leaf-keys (
	    ("C-c b" . vc-annotate)
	    ;; C-c(hjkl)でWindow移動
	    ("C-c l" . windmove-right)
	    ("C-c h" . windmove-left)
	    ("C-c j" . windmove-down)
	    ("C-c k" . windmove-up)
	    ))

;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;; 初期画面を無効化
(setq inhibit-splash-screen t)

;; ウィンドウサイズ
(if (boundp 'window-system)
    (add-hook 'after-init-hook (lambda()
				 (set-frame-position
				  (selected-frame)
				  (/ (display-pixel-width) 4)
				  (/ (display-pixel-height) 4))
				 (set-frame-size
				  (selected-frame)
				  (/ (display-pixel-width) 2)
				  (/ (display-pixel-height) 2)
				  t)
				 )))

;; フォント
(set-face-attribute 'default nil
		    :family "Cica"
		    :height 240)

;; ----------------

(leaf ivy
  :doc "Incremental Vertical completYon"
  :req "emacs-24.5"
  :tag "matching" "emacs>=24.5"
  :url "https://github.com/abo-abo/swiper"
  :emacs>= 24.5
  :ensure t
  :blackout t
  :leaf-defer nil
  :custom ((ivy-initial-inputs-alist . nil)
           (ivy-re-builders-alist . '((t . ivy--regex-fuzzy)
                                      (swiper . ivy--regex-plus)))
           (ivy-use-selectable-prompt . t)
	   (ivy-use-virtual-buffers . t) ;; add recentf to ivy-switch-buffer
	   )
  :global-minor-mode t
  :bind (("C-;" . ivy-switch-buffer)) ;; instead of helm-mini
  :config
  (leaf swiper
    :doc "Isearch with an overview. Oh, man!"
    :req "emacs-24.5" "ivy-0.13.0"
    :tag "matching" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :bind (("C-s" . swiper)))

  (leaf counsel
    :doc "Various completion functions using Ivy"
    :req "emacs-24.5" "swiper-0.13.0"
    :tag "tools" "matching" "convenience" "emacs>=24.5"
    :url "https://github.com/abo-abo/swiper"
    :emacs>= 24.5
    :ensure t
    :blackout t
    :bind (("C-S-s" . counsel-imenu)
           ("C-x C-r" . counsel-recentf))
    :custom `((counsel-yank-pop-separator . "\n----------\n")
              (counsel-find-file-ignore-regexp . ,(rx-to-string '(or "./" "../") 'no-group)))
    :global-minor-mode t))

(leaf ivy-rich
  :doc "More friendly display transformer for ivy."
  :req "emacs-24.5" "ivy-0.8.0"
  :tag "ivy" "emacs>=24.5"
  :emacs>= 24.5
  :ensure t
  :after ivy
  :global-minor-mode t)
    
(leaf prescient
  :doc "Better sorting and filtering"
  :req "emacs-25.1"
  :tag "extensions" "emacs>=25.1"
  :url "https://github.com/raxod502/prescient.el"
  :emacs>= 25.1
  :ensure t
  :commands (prescient-persist-mode)
  :custom `((prescient-aggressive-file-save . t)
            (prescient-save-file . ,(locate-user-emacs-file "prescient")))
  :global-minor-mode prescient-persist-mode)
  
(leaf ivy-prescient
  :doc "prescient.el + Ivy"
  :req "emacs-25.1" "prescient-4.0" "ivy-0.11.0"
  :tag "extensions" "emacs>=25.1"
  :url "https://github.com/raxod502/prescient.el"
  :emacs>= 25.1
  :ensure t
  :after prescient ivy
  :custom ((ivy-prescient-retain-classic-highlighting . t))
  :global-minor-mode t)

(leaf flycheck
  :doc "On-the-fly syntax checking"
  :req "dash-2.12.1" "pkg-info-0.4" "let-alist-1.0.4" "seq-1.11" "emacs-24.3"
  :tag "minor-mode" "tools" "languages" "convenience" "emacs>=24.3"
  :url "http://www.flycheck.org"
  :emacs>= 24.3
  :ensure t
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error))
  :global-minor-mode global-flycheck-mode)

(leaf company
  :doc "Modular text completion framework"
  :req "emacs-24.3"
  :tag "matching" "convenience" "abbrev" "emacs>=24.3"
  :url "http://company-mode.github.io/"
  :emacs>= 24.3
  :ensure t
  :blackout t
  :leaf-defer nil
  :bind ((company-active-map
          ("M-n" . nil)
          ("M-p" . nil)
          ("C-s" . company-filter-candidates)
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ("<tab>" . company-complete-selection))
         (company-search-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)))
  :custom ((company-idle-delay . 0)
           (company-minimum-prefix-length . 1)
           (company-transformers . '(company-sort-by-occurrence)))
  :global-minor-mode global-company-mode)

(leaf company-c-headers
  :doc "Company mode backend for C/C++ header files"
  :req "emacs-24.1" "company-0.8"
  :tag "company" "development" "emacs>=24.1"
  :added "2020-03-25"
  :emacs>= 24.1
  :ensure t
  :after company
  :defvar company-backends
  :config
  (add-to-list 'company-backends 'company-c-headers))

(leaf projectile
  :ensure t
  :custom ((projectile-completion-system . 'ivy))
  :blackout t
  :config
  (projectile-mode 1)
  (leaf counsel-projectile
    :ensure t
    :config
    (counsel-projectile-mode 1)
    :bind (("C-x t" . counsel-projectile)
	   ("C-x g" . counsel-projectile-ag))
    ))


(leaf all-the-icons
  :ensure t
  :init (leaf memoize :ensure t)
  :require t
  :custom
  ((all-the-icons-scale-factor . 0.9)
   (all-the-icons-default-adjust . 0.0))
  )

(leaf neotree
  :ensure t
  :commands
  (neotree-show neotree-hide neotree-dir neotree-find)
  :custom
  ((neo-theme . 'nerd2)
   (neo-autorefresh . t)
   (neo-toggle-window-keep-p . t))
  )

(leaf doom-themes
  :ensure t neotree
  :custom
  (doom-themes-enable-italic . nil)
  (doom-themes-enable-bold . nil)
  :config
  (load-theme 'deeper-blue t)
  (doom-themes-neotree-config)
  (doom-themes-org-config)
  )

(leaf magit
  :bind (("C-c m" . magit-status))
  :ensure t
  :init
  :config
  (setq magit-completing-read-function 'ivy
	magit-refs-show-commit-count 'all
	magit-log-buffer-file-locked t
	))

(leaf ivy-ghq
  :if (executable-find "ghq")
  :el-get analyticd/ivy-ghq
  :bind (("C-x C-]" . ivy-ghq-open))
  )

(leaf undo-tree
  :ensure t
  :custom ((global-undo-tree-mode . t))
  :bind (("C-/" . undo-tree-undo)
	 ("C-'" . undo-tree-redo)))

(leaf comment-dwim-2
  :ensure t
  :leaf-defer nil
  :bind* ("M-;" . comment-dwim-2))

;; ----------------

