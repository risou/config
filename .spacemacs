;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     better-defaults
     emacs-lisp
     git
     markdown
     org
     gtags
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking
     version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
									  redo+
									  neotree
									  point-undo
									  yaml-mode
									  ;; php-mode
									  ddskk
									  editorconfig
									  helm-ghq
									  plenv
									  go-mode
									  comment-dwim-2
									  )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(
									evil
									flyspell
									)
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https nil
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  ;; change eyebrowse-keymap-prefix
  (setq eyebrowse-keymap-prefix (kbd "C-c w"))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; C-h でバックスペース
  (define-key key-translation-map [?\C-h] [?\C-?])

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

  ;; open .spacemacs
  (define-key global-map (kbd "C-x  ,") (lambda () (interactive) (switch-to-buffer (find-file-noselect "~/.spacemacs"))))

  ;; 時計を表示
  (setq display-time-24hr-format t)
  (display-time-mode t)

  ;; タイトルバーにフルパスを表示
  (setq frame-title-format "%f")

  ;; 行番号を常に表示
  (global-linum-mode t)
  (setq linum-format "%4d  ")

  ;; 半透明
  (setq default-frame-alist
        (append
         (list
          ;; '(alpha . (75 50))
          ;; '(alpha . (85 70))
          '(width . 200)
          '(height . 65)
          '(top . 50)
          '(left . 50)
          '(foreground-color . "white")
          '(background-color . "black")
          ) default-frame-alist))

  ;; tabのサイズ
  (setq-default c-basic-offset 4
                tab-width 4
                indent-tabs-mode nil)

  ;; avoid to write `package-selected-packages' in init.el
  (load (setq custom-file (expand-file-name "custom.el" user-emacs-directory)))

  ;; C-s/r C-w でカーソル位置の単語検索
  (defvar isearch-initial-string nil)
  (defun isearch-set-initial-string ()
    (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
    (setq isearch-string isearch-initial-string)
    (isearch-search-and-update))
  (defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
    "Interactive search forward for the symbol at point."
    (interactive "P\np")
    (if regexp-p (isearch-forward regexp-p no-recursive-edit)
      (let* ((end (progn (skip-syntax-forward "w_") (point)))
             (begin (progn (skip-syntax-backward "w_") (point))))
        (if (eq begin end)
            (isearch-forward regexp-p no-recursive-edit)
          (setq isearch-initial-string (buffer-substring begin end))
          (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
          (isearch-forward regexp-p no-recursive-edit)))))
  (define-key isearch-mode-map "\C-w" 'isearch-forward-at-point)

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
  (global-set-key (kbd "C-c l") 'windmove-right)
  (global-set-key (kbd "C-c h") 'windmove-left)
  (global-set-key (kbd "C-c j") 'windmove-down)
  (global-set-key (kbd "C-c k") 'windmove-up)
  ;; Window 移動時にループ可能にする
  (setq windmove-wrap-around t)

  ;; ddskk
  (when (require 'dired-x nil t)
	(global-set-key (kbd "C-x j") 'dired-jump))
  (require 'skk-autoloads nil t)
  (setq default-input-method "japanese-skk")
  (setq skk-server-portnum 1178)
  (setq skk-server-port "localhost")
  (global-set-key (kbd "C-x C-j") 'skk-mode)
  (setq skk-byte-compile-init-file t)
  (setq skk-jisyo-code 'utf-8)
  (setq skk-jisyo (concat (getenv "HOME") "/skk-jisyo.utf8"))
  (add-hook 'isearch-mode-hook
			(function (lambda ()
						(and (boundp 'skk-mode) skk-mode
							 (skk-isearch-mode-setup)))))
  (add-hook 'isearch-mode-end-hook
			(function (lambda ()
						(and (boundp 'skk-mode) skk-mode (skk-isearch-mode-cleanup))
						(and (boundp 'skk-mode-invoked) skk-mode-invoked
							 (skk-set-cursor-properly)))))
  ;; skk-mode on when buffer open
  (defun auto-skk-latin-mode-hook ()
	(require 'skk)
	(skk-latin-mode t))
  (dolist (hook '(find-file-hook
				  org-capture-mode-hook
				  minibuffer-setup-hook
				  with-editor-mode-hook))
	(add-hook hook 'auto-skk-latin-mode-hook))

  ;;redo+の設定
  (when (require 'redo+ nil t)
	(global-set-key (kbd "C-'") 'redo))

  ;; neotree
  (when (require 'neotree)
	(global-set-key (kbd "C-x C-d") 'neotree-toggle)
	(setq neo-show-hidden-files t)
	(setq neo-create-file-auto-open t)
	(setq neo-persist-show t)
	(setq neo-keymap-style 'concise)
	(setq neo-smart-open t)
	(setq neo-pvc-integration '(face char)))

  ;; auto-complete
  (when (require 'auto-complete-config nil t)
	(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
	(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
	(ac-config-default))

  ;; point-undo
  (when (require 'point-undo nil t)
	(define-key global-map (kbd "M-[") 'point-undo)
	(define-key global-map (kbd "M-]") 'point-redo))

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
	(global-whitespace-mode 1))

  ;; comment-dwim-2
  (define-key global-map (kbd "M-;") 'comment-dwim-2)

  ;; nxml-mode
  (add-to-list 'auto-mode-alist '("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'" . nxml-mode))
  ;; </ を入力すると自動的にタグを閉じる
  (setq nxml-slash-auto-complete-flag t)
  ;; M-TAB でタグを補完する
  (setq nxml-bind-meta-tab-to-complete-flag t)
  ;; nxml-mode で auto-complete-mode を利用する
  (add-to-list 'ac-modes 'nxml-mode)

  ;; css-mode
  (autoload 'css-mode "css-mode" nil t)
  (setq auto-mode-alist
		(cons '("\\.css\\'" . css-mode) auto-mode-alist))
  (setq css-indent-level 4)
  (defun css-mode-hooks ()
	(when (and (>= emacs-major-version 24) (>= emacs-minor-version 4))
	  (setq electric-indent-local-mode +1))
	)
  (add-hook 'css-mode-hook 'css-mode-hooks)

  ;; cperl-mode
  (defalias 'perl-mode 'cperl-mode)
  ;; .psgi, .t ファイルを cperl-mode で開く
  (add-to-list 'auto-mode-alist '("\\.psgi$" . cperl-mode))
  (add-to-list 'auto-mode-alist '("\\.t\\'" . cperl-mode))
  (setq cperl-indent-level 4
		cperl-continued-statement-offset 4
		cperl-brace-offset -4
		cperl-label-offset -4
		cperl-indent-parens-as-block t
		cperl-close-paren-offset -4
		cperl-tab-always-indent t
		;;	  cperl-indent-subs-specially nil) ;; need package-install
		cperl-highlight-variables-indiscriminately t)
  ;; disturb overlap bracket completion (by smartparents-mode and electric-pair)
  ;; ref: https://github.com/syl20bnr/spacemacs/issues/480
  (with-eval-after-load 'cperl-mode
	(define-key cperl-mode-map "{" nil)
	(define-key cperl-mode-map "[" nil)
	(define-key cperl-mode-map "(" nil))
  (require 'plenv)
  ;; perl flymake
  (require 'flymake)
  (defconst flymak-allowed-perl-file-name-masks
	'(("\\.pl$" flymake-perl-init)
	  ("\\.pm$" flymake-perl-init)
	  ("\\.psgi$" flymake-perl-init)
	  ("\\.t$" flymake-perl-init)))
  (defun flymake-perl-init ()
	(let* ((temp-file (flymake-init-create-temp-buffer-copy
					   'flymake-create-temp-inplace))
		   (local-file (file-relative-name
						temp-file
						(file-name-directory buffer-file-name))))
	  (list (guess-plenv-perl-path) (list "-MProject::Libs lib_dirs => [qw(local/lib/perl5)]" "-wc" local-file))))
  (defun cperl-mode-hooks ()
        (cperl-set-style "PerlStyle")
	(setq indent-tabs-mode nil)
	(flymake-mode t))
  (add-hook 'cperl-mode-hook 'cperl-mode-hooks)
  ;; perl-completion
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
  (when (require 'yaml-mode nil t)
	(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

  ;; ruby-mode indent
  (setq ruby-indent-level 2
		ruby-deep-indent-paren-style nil
		ruby-indent-tabs-mode nil)
  ;; ruby flymake
  (require 'flymake)
  (defun flymake-ruby-init ()
	(list "ruby" (list "-c" (flymake-init-create-temp-buffer-copy
							 'flymake-create-temp-inplace))))
  (add-to-list 'flymake-allowed-file-name-masks
			   '("\\.rb\\'" flymake-ruby-init))
  (add-to-list 'flymake-err-line-patterns
			   '("\\(.*\\):(\\([0-9]+\\)): \\(.*\\)" 1 2 nil 3))

  ;; php-mode
  ;; (require 'php-mode)
  ;; php-completion
  ;; M-x package-list-packages -> php-completion
  ;; (add-hook 'php-mode-hook
  ;; 			(lambda ()
  ;; 			  (require 'php-completion)
  ;; 			  (php-completion-mode t)
  ;; 			  (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
  ;; 			  (make-local-variable 'ac-sources)
  ;; 			  (setq ac-sources '(
  ;; 								 ac-source-words-in-same-mode-buffers
  ;; 								 ac-source-php-completion
  ;; 								 ac-source-filename
  ;; 								 ))
  ;; 			  (defun ywb-php-lineup-arglist-intro (langelem)
  ;; 				(save-excursion
  ;; 				  (goto-char (cdr langelem))
  ;; 				  (vector (+ (current-column) c-basic-offset))))
  ;; 			  (defun ywb-php-lineup-arglist-close (langelem)
  ;; 				(save-excursion
  ;; 				  (goto-char (cdr langelem))
  ;; 				  (vector (current-column))))
  ;; 			  (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
  ;; 			  (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)))

  ;; disable evil-exit-emacs-state by C-z
  (define-key evil-emacs-state-map (kbd "C-z") nil)

  ;; eyebrowse
  (define-key eyebrowse-mode-map (kbd "C-c w d") 'eyebrowse-close-window-config)
  (define-key eyebrowse-mode-map (kbd "<C-tab>") 'eyebrowse-next-window-config)
  (define-key eyebrowse-mode-map (kbd "<C-S-tab>") 'eyebrowse-prev-window-config)

  ;; magit
  (define-key global-map (kbd "C-c m") 'magit-status)

  ;; helm
  (progn
	(require 'helm)
	(require 'helm-config)
	(defvar helm-source-emacs-commands
	  (helm-build-sync-source "Emacs commands"
		:candidates (lambda ()
					  (let ((cmds))
						(mapatoms
						 (lambda (elt) (when (commandp elt) (push elt cmds))))
						cmds))
		:coerce #'intern-soft
		:action #'command-execute)
	  "A simple helm source for Emacs commands.")
	(defvar helm-source-emacs-commands-history
	  (helm-build-sync-source "Emacs commands history"
		:candidates (lambda ()
					  (let ((cmds))
						(dolist (elem extended-command-history)
						  (push (intern elem) cmds))
						cmds))
		:coerce #'intern-soft
		:action #'command-execute)
	  "Emacs commands history")
	(global-unset-key (kbd "C-z"))
	(custom-set-variables
	 '(helm-command-prefix-key "C-z"))
	;; (require 'helm-ls-git)
	(custom-set-variables
	 '(helm-truncate-lines t)
	 '(helm-delete-minibuffer-contents-from-point t)
	 '(helm-mini-default-sources '(helm-source-buffers-list
								   helm-source-recentf
								   helm-source-files-in-current-dir
								   ;;								 helm-source-ls-git
								   helm-source-emacs-commands-history
								   helm-source-emacs-commands
								   )))
	(helm-mode 1)
	(define-key global-map (kbd "C-;") 'helm-mini)
	;; (define-key global-map (kbd "M-x") 'helm-M-x)
	;; (define-key global-map (kbd "C-x C-f") 'helm-find-files)
	;; (define-key global-map (kbd "C-x C-r") 'helm-recentf)
	(define-key global-map (kbd "M-y") 'helm-show-kill-ring)
	(define-key global-map (kbd "C-c r") 'helm-imenu)
	(define-key global-map (kbd "C-x C-b") 'helm-buffers-list)
	(define-key global-map (kbd "C-x C-]") 'helm-ghq)
	(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
	(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
	(define-key helm-read-file-map (kbd "C-i") 'helm-execute-persistent-action)
	(define-key helm-find-files-map (kbd "C-i") 'helm-execute-persistent-action)
	(define-key helm-command-map (kbd "d") 'helm-descbinds)
	(define-key helm-command-map (kbd "g") 'helm-ag)
	(define-key helm-command-map (kbd "o") 'helm-occur)
	)

  ;; helm-projectile
  (define-key global-map (kbd "C-x C-t") 'helm-projectile)
  (define-key global-map (kbd "C-x C-g") 'helm-projectile-ag)

  ;; editorconfig
  ;; M-x package-install editorconfig
  (setq edconf-exec-path "/usr/local/bin/editorconfig")
  (editorconfig-mode 1)

  ;; org-mode
  ;; M-x package-list-packages org
  (require 'org-install)
  (require 'org-capture)
  (setq org-startup-truncated nil)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (setq org-use-speed-commands t)
  (setq org-hide-leading-stars t)
  (setq org-indent-mode t)
  (setq org-startup-indented t)
  (setq org-directory "~/.org/")
  (setq org-default-notes-file (concat org-directory "base.org"))
  (setq org-agenda-files (list org-directory))
  (define-key global-map (kbd "C-c n") (lambda () (interactive) (switch-to-buffer (find-file-noselect org-default-notes-file))))
  (define-key global-map (kbd "C-c c") 'org-capture)
  (define-key global-map (kbd "C-c a") 'org-agenda)
  (define-key global-map (kbd "C-c s") 'org-store-link)
  (define-key global-map (kbd "C-c t") 'org-todo)
  (define-key global-map (kbd "C-c l") 'windmove-right) ;; cancel overrided key map
  (setq org-capture-templates
		'(("t" "Todo" entry (file+headline nil "Tasks")
		   "* TODO %i%?")
		  ("m" "Memo" entry (file+headline nil "Memos")
		   "* %?\n%i\n%U")
		  ("d" "Dairy" entry (file+headline nil "Dairy")
		   "* %U\n%i%?")
		  ("w" "Daily Work Log" item (file+datetree nil)
		   "%U %i%?")
		  ("l" "List" checkitem (file+headline nil "Lists")
		   " [ ] %i%? %U")
		  ))
  (eval-after-load "org"
	'(progn
	   (define-key org-mode-map (kbd "C-'") nil)
	   ))

  ;; markdown preview
  (require 'markdown-mode)
  (defun eww-open-file-other-window (file)
	(if (one-window-p) (split-window-horizontally))
	(other-window 1)
	(eww-open-file file))
  (defun markdown-preview-eww ()
	(interactive)
	(message (buffer-file-name))
	(call-process "/usr/local/bin/pandoc" nil nil nil
				  "-f"
				  "markdown"
				  (buffer-file-name)
				  "-o"
				  "/tmp/markdown-preview-eww-result.html")
	(eww-open-file-other-window "/tmp/markdown-preview-eww-result.html"))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-command-prefix-key "C-z")
 '(helm-delete-minibuffer-contents-from-point t)
 '(helm-mini-default-sources
   (quote
	(helm-source-buffers-list helm-source-recentf helm-source-files-in-current-dir helm-source-emacs-commands-history helm-source-emacs-commands)))
 '(helm-truncate-lines t t)
 '(inhibit-default-init t)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
