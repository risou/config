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
     rust
     shell-scripts
     csv
     python
     html
     javascript
     ruby
     (ruby :variables ruby-version-manager 'rbenv)
     sql
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
     ;; gtags
     (shell :variables
            shell-default-term-shell "/usr/local/bin/fish"
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking
     version-control
     go
     (go :variables
         go-use-gometalinter t
         go-tab-width 4
         gofmt-command "goimports")
     tabbar ;; git clone https://github.com/evacchi/tabbar-layer ~/.emacs.d/private/tabbar
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
									  migemo
									  ace-isearch
									  rotate
									  e2wm
									  flycheck
                                      all-the-icons
                                      minimap
                                      vue-mode
                                      use-package
                                      lsp-mode
                                      lsp-ui
                                      perl6-mode
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
   dotspacemacs-themes '(
                         sanityinc-tomorrow-blue
                         underwater
                         ;; deeper-blue
                         ;; subatomic
                         ;; fogus
                         ;;misterioso
                         )
   ;; dotspacemacs-themes '(spacemacs-dark
   ;;                       spacemacs-light
   ;;                       solarized-light
   ;;                       solarized-dark
   ;;                       leuven
   ;;                       monokai
   ;;                       zenburn)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   ;; dotspacemacs-default-font '("Source Code Pro"
   ;;                             :size 13
   ;;                             :weight normal
   ;;                             :width normal
   ;;                             :powerline-scale 1.1)
   ;; dotspacemacs-default-font '("Menlo for Powerline"
   ;;                             :size 12
   ;;                             :weight normal
   ;;                             :width normal
   ;;                             :powerline-scale 1.1)
   dotspacemacs-default-font '("Cica"
                               :size 14
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

  ;; tabbar
  (setq tabbar-use-images nil) 
  ;; 左に表示されるボタンを無効化
  (dolist (btn '(tabbar-buffer-home-button
                 tabbar-scroll-left-button
                 tabbar-scroll-right-button))
    (set btn (cons (cons "" nil)
                   (cons "" nil))))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; set $GOPATH
  (add-to-list 'exec-path (expand-file-name "~/bin"))
  (setenv "GOPATH" "/Users/risou/")

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

  ;; disable xterm-mouse-mode
  (xterm-mouse-mode -1)

  ;; 時計を表示
  (setq display-time-24hr-format t)
  (display-time-mode t)

  ;; タイトルバーにフルパスを表示
  (setq frame-title-format "%f")

  ;; 行番号を常に表示
  ;; (global-linum-mode t)
  ;; (setq linum-format "%4d  ")

  ;; 行間
  (setq-default line-spacing 0.5)

  ;; spacemacs
  (defun toggle-spacemacs-config ()
    ;; highlight current line
    ;; (spacemacs/toggle-highlight-current-line-globally-on)
    ;; highlight indentation level
    ;; (spacemacs/toggle-highlight-indentation-on)
    ;; highlight indentation current column
    (spacemacs/toggle-highlight-indentation-current-column-on)
    (set-face-background  'highlight-indentation-current-column-face "#00ADB9")
    ;; battery
    (spacemacs/toggle-mode-line-battery-on)
    ;; point position
    (spacemacs/toggle-mode-line-point-position-on)
    ;; version control
    (spacemacs/toggle-mode-line-version-control-on)
    )
  (add-hook 'find-file-hook 'toggle-spacemacs-config)

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
          ;; '(foreground-color . "white")
          ;; '(background-color . "black")
          ) default-frame-alist))
  ;; transparent on iTerm2
  (defun make-term-frame-trans (frame)
    (unless (display-graphic-p frame)
      (set-face-background 'default "unspecified-bg" frame)
      (set-face-background 'font-lock-comment-face "unspecified-bg" frame)))
  (add-hook 'after-make-frame-functions 'make-term-frame-trans)

  ;; tabのサイズ
  (setq-default c-basic-offset 4
                tab-width 4
                indent-tabs-mode nil)

  ;; MacOS copy/paste
  (if (eq system-type 'darwin)
      (progn
        (defun copy-from-osx ()
          (shell-command-to-string "reattach-to-user-namespace pbpaste"))
        (defun paste-to-osx (text &optional push)
          (let ((process-connection-type nil))
            (let ((proc (start-process "pbcopy" "*Messages*" "reattach-to-user-namespace" "pbcopy")))
              (process-send-string proc text)
              (process-send-eof proc))))
        (setq interprogram-cut-function 'paste-to-osx)
        (setq interprogram-paste-function 'copy-from-osx)
        )
    (message "This platform is not mac")
    )

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
  ;; (define-key isearch-mode-map "\C-w" 'isearch-forward-at-point)
  (define-key global-map (kbd "C-c C-s") 'isearch-forward-at-point)

  ;; (global-ace-isearch-mode 1)

  ;; minimap
  (require 'minimap)

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

  ;; all-the-icons
  (require 'all-the-icons)

  ;; neotree
  (when (require 'neotree)
    (defun neotree-projectile-dir ()
      "Open NeoTree using the project root, using find-file-in-project, or the current buffer directory."
      (let ((project-dir
             (ignore-errors
               (projectile-project-root)
               ))
            (file-name (buffer-file-name))
            (neo-smart-open t))
        (progn
          (neotree-show)
          (if project-dir
              (neotree-dir project-dir))
          (if file-name
              (neotree-find file-name)))))
	;;(global-set-key (kbd "C-x C-d") 'neotree-toggle)
	(global-set-key (kbd "C-x C-d") (lambda ()
                                      (interactive)
                                      (if (neo-global--window-exists-p)
                                          (neotree-hide)
                                        (neotree-projectile-dir))))
                                        ; (neotree-projectile-action))))
	(setq neo-show-hidden-files t)
	(setq neo-create-file-auto-open t)
	(setq neo-persist-show t)
	(setq neo-keymap-style 'concise)
	(setq neo-smart-open t)
	(setq neo-pvc-integration '(face char))
	(setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

  ;; auto-complete
  (when (require 'auto-complete-config nil t)
	(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
	(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
	(ac-config-default))

  ;; point-undo
  (when (require 'point-undo nil t)
	(define-key global-map (kbd "<f5>") 'point-undo)
	(define-key global-map (kbd "<f6>") 'point-redo))

  ;; whitespace-mode
  (when (require 'whitespace nil t)
	(setq whitespace-style '(face tabs tab-mark spaces space-mark trailing))
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
	(set-face-background 'whitespace-trailing "#ffc0c0")
	(set-face-underline 'whitespace-trailing t)
	(global-whitespace-mode 1))

  ;; comment-dwim-2
  (define-key global-map (kbd "M-;") 'comment-dwim-2)

  ;; rotate
  (require 'rotate)
  (define-key global-map (kbd "C-c TAB") 'rotate-window)
  (defadvice rotate-window (after rotate-cursor activate)
    (other-window -1))
  ;; e2wm
  (require 'e2wm)
  (define-key global-map (kbd "C-c ; X") 'e2wm:start-management)

  ;; nxml-mode
  (add-to-list 'auto-mode-alist '("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'" . nxml-mode))
  ;; </ を入力すると自動的にタグを閉じる
  (setq nxml-slash-auto-complete-flag t)
  ;; M-TAB でタグを補完する
  (setq nxml-bind-meta-tab-to-complete-flag t)
  ;; nxml-mode で auto-complete-mode を利用する
  (add-to-list 'ac-modes 'nxml-mode)

  (add-hook 'after-init-hook #'global-flycheck-mode)

  ;; javascript-mode
  (add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
  (setq js-indent-level 2)

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
  ;; (require 'flymake)
  ;; (defconst flymak-allowed-perl-file-name-masks
  ;;       '(("\\.pl$" flymake-perl-init)
  ;;         ("\\.pm$" flymake-perl-init)
  ;;         ("\\.psgi$" flymake-perl-init)
  ;;         ("\\.t$" flymake-perl-init)))
  ;; (defun flymake-perl-init ()
  ;;       (let* ((temp-file (flymake-init-create-temp-buffer-copy
  ;;       				   'flymake-create-temp-inplace))
  ;;       	   (local-file (file-relative-name
  ;;       					temp-file
  ;;       					(file-name-directory buffer-file-name))))
  ;;         (list (guess-plenv-perl-path) (list "-MProject::Libs lib_dirs => [qw(local/lib/perl5)]" "-wc" local-file))))
  (defun cperl-mode-hooks ()
        (cperl-set-style "PerlStyle")
	(setq indent-tabs-mode nil)
	;; (flymake-mode t))
        )
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
  (custom-set-variables
   '(ruby-insert-encoding-magic-comment nil))
  ;; ruby flymake
  (require 'flymake)
  (defun flymake-ruby-init ()
	(list "ruby" (list "-c" (flymake-init-create-temp-buffer-copy
							 'flymake-create-temp-inplace))))
  (add-to-list 'flymake-allowed-file-name-masks
			   '("\\.rb\\'" flymake-ruby-init))
  (add-to-list 'flymake-err-line-patterns
			   '("\\(.*\\):(\\([0-9]+\\)): \\(.*\\)" 1 2 nil 3))
  (define-key ruby-mode-map (kbd "C-c C-s") nil)
  (define-key ruby-mode-map (kbd "C-c C-r") nil)

  ;; web-mode
  (require 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))

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

  ;; ggtags-mode
  ;; (require 'ggtags)
  ;; (add-hook 'cperl-mode-hook (lambda () (ggtags-mode)))
  ;; (add-hook 'go-mode-hook (lambda () (ggtags-mode)))
  ;; helm-gtags-mode
  ;; (require 'helm-gtags)
  ;; (add-hook 'helm-gtags-mode-hook
  ;;           '(lambda ()
  ;;              (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
  ;;              (local-set-key (kbd "M-,") 'helm-gtags-pop-stack)
  ;;              (local-set-key (kbd "M-t") 'helm-gtags-find-rtag)
  ;;              )
  ;;           )
  ;; (add-hook 'cperl-mode-hook (lambda () (helm-gtags-mode)))
  ;; (add-hook 'go-mode-hook (lambda () (helm-gtags-mode)))

  ;; flycheck-gometalinter
  ;; skips 'vendor' directories and sets GO15VENDOREXPERIMENT=1
  (setq flycheck-gometalinter-vendor t)
  ;; only show errors
  (setq flycheck-gometalinter-errors-only t)
  ;; only run fast linters
  (setq flycheck-gometalinter-fast t)
  ;; use in tests files
  (setq flycheck-gometalinter-test t)
  ;; disable linters
  (setq flycheck-gometalinter-disable-linters '("gotype" "gocyclo"))
  ;; Only enable selected linters
  (setq flycheck-gometalinter-disable-all t)
  (setq flycheck-gometalinter-enable-linters '("golint"))
  ;; Set different deadline (default: 5s)
  (setq flycheck-gometalinter-deadline "10s")


  ;; migemo
  (require 'migemo)
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (load-library "migemo")
  (migemo-init)

  ;; eyebrowse
  ;; (define-key eyebrowse-mode-map (kbd "C-c w d") 'eyebrowse-close-window-config)
  ;; (define-key eyebrowse-mode-map (kbd "<C-tab>") 'eyebrowse-next-window-config)
  ;; (define-key eyebrowse-mode-map (kbd "<C-S-tab>") 'eyebrowse-prev-window-config)

  ;; magit
  (require 'magit)
  (define-key magit-file-mode-map (kbd "C-x g") nil)
  (define-key magit-mode-map (kbd "M-n") nil)
  (define-key magit-mode-map (kbd "M-p") nil)
  (define-key magit-mode-map (kbd "<C-tab>") nil)
  (define-key global-map (kbd "C-c m") 'magit-status)
  ;; (setq-default git-magit-status-fullscreen t) 
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)

  ;; vc-annotate で現在の行が merge された PR を開く
  (require 'vc-annotate)
  (defun vc-annotate-open-pr-at-line ()
    (interactive)
    (let* ((rev-at-line (vc-annotate-extract-revision-at-line))
           (rev (car rev-at-line)))
      (shell-command (concat "open-pr-from-commit " rev))))
  (define-key vc-annotate-mode-map (kbd "P") 'vc-annotate-open-pr-at-line)

  ;; lsp
  (require 'lsp-mode)
  (require 'lsp-ui)
  (add-hook 'ruby-mode-hook #'lsp)
  (add-hook 'web-mode-hook #'lsp)
  (defun lsp-mode-init ()
    (lsp)
    (global-set-key (kbd "M-*") 'xref-pop-marker-stack)
    (global-set-key (kbd "M-.") 'xref-find-definitions)
    (global-set-key (kbd "M-/") 'xref-find-references))
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-max-width 150)
  (setq lsp-ui-doc-max-height 30)
  (setq lsp-ui-peek-enable t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)

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
    ;; (setq helm-exit-idle-delay nil)
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
  (eval-after-load "helm"
    (helm-migemo-mode +1)
    )

  ;; helm-ag add option
  ;; to avoid bug https://github.com/ggreer/the_silver_searcher/issues/1038#issuecomment-322267309
  (custom-set-variables '(helm-ag-command-option "--mmap --ignore /dist/"))

  ;; helm-projectile
  (define-key global-map (kbd "C-x t") 'helm-projectile)
  (define-key global-map (kbd "C-x g") 'helm-projectile-ag)
  (custom-set-variables
   '(projectile-enable-caching t))
  (projectile-global-mode t)

  ;; editorconfig
  ;; M-x package-install editorconfig
  (setq edconf-exec-path "/usr/local/bin/editorconfig")
  (editorconfig-mode 1)

  ;; tabbar
  (require 'tabbar)
  (tabbar-mode 1)
  (setq tabbar-buffer-groups-function nil)
  ;; (setq tabbar-separator '(0.5))
  (set-face-attribute
   'tabbar-default nil
   :background "#34495E"
   :foreground "#EEEEEE"
   :bold nil
   :height 0.95
   ;; :background "brightblue"
   ;; :foreground "white"
   )
  (set-face-attribute
   'tabbar-unselected nil
   :background "#34495E"
   :foreground "#EEEEEE"
   :bold nil
   :box nil
   )
  (set-face-attribute
   'tabbar-modified nil
   :background "#E67E22"
   :foreground "#EEEEEE"
   :bold t
   :box nil
   ;; :background "brightred"
   ;; :foreground "brightwhite"
   )
  (set-face-attribute
   'tabbar-selected nil
   :background "#E74C3C"
   :foreground "#EEEEEE"
   :bold nil
   ;; :background "#ff5f00"
   ;˜; :foreground "brightwhite"
   :box nil
   )
  (set-face-attribute
   'tabbar-button nil
   :box nil)
  (set-face-attribute
   'tabbar-separator nil
   :height 2.0)
  (defun tabbar-buffer-tab-label (tab)
    "Return a label for TAB.
That is, a string used to represent it on the tab bar."
    (let ((label  (if tabbar--buffer-show-groups
                      (format "[%s]" (tabbar-tab-tabset tab))
                    (format "%s" (tabbar-tab-value tab)))))
      ;; Unless the tab bar auto scrolls to keep the selected tab
      ;; visible, shorten the tab label to keep as many tabs as possible
      ;; in the visible area of the tab bar.
      (if tabbar-auto-scroll-flag
          label
        (tabbar-shorten
         label (max 1 (/ (window-width)
                         (length (tabbar-view
                                  (tabbar-current-tabset)))))))))

  ;; タブに表示するバッファをフィルタするカスタム関数
  ;; (defun my-tabbar-buffer-list ()
  ;;   (delq nil
  ;;         (mapcar #'(lambda (b)
  ;;                     (cond
  ;;                      ((eq (current-buffer) b) b)
  ;;                      ((buffer-file-name b) b)
  ;;                      ((char-equal ?\  (aref (buffer-name b) 0)) nil)
  ;;                      ;;((equal "*scratch*" (buffer-name b)) b)
  ;;                      ((char-equal ?* (aref (buffer-name b) 0)) nil)
  ;;                      ((buffer-live-p b) b)))
  ;;                 (buffer-list))))
  ;; ;; カスタム関数を登録
  ;; (setq tabbar-buffer-list-function 'my-tabbar-buffer-list)
  ;; タブの長さ
  (setq tabbar-separator '(2.2))
  ;; タブに表示させるバッファの設定
  (defvar my-tabbar-displayed-buffers
    '("*vc-")
    "*Regexps matches buffer names always included tabs.")
  (defun my-tabbar-buffer-list ()
    "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or an asterisk.
The current buffer and buffers matches `my-tabbar-displayed-buffers'
are always included."
    (let* ((hides (list ?\  ?\*))
           (re (regexp-opt my-tabbar-displayed-buffers))
           (cur-buf (current-buffer))
           (tabs (delq nil
                       (mapcar (lambda (buf)
                                 (let ((name (buffer-name buf)))
                                   (when (or (string-match re name)
                                             (not (or (memq (aref name 0) hides)
                                                      (string-match "magit" name))))
                                     buf)))
                               (buffer-list)))))
      ;; Always include the current buffer.
      (if (memq cur-buf tabs)
          tabs
        (cons cur-buf tabs))))
  (setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

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
  (setq org-directory "~/GoogleDrive/org/")
  (setq org-default-notes-file (concat org-directory "base.org"))
  (setq org-agenda-files (list org-directory))
  (define-key global-map (kbd "C-c n") (lambda () (interactive) (switch-to-buffer (find-file-noselect org-default-notes-file))))
  (define-key global-map (kbd "C-c c") 'org-capture)
  (define-key global-map (kbd "C-c a") 'org-agenda)
  (define-key global-map (kbd "C-c s") 'org-store-link)
  (define-key global-map (kbd "C-c t") 'org-todo)
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
       (define-key org-mode-map (kbd "C-c l") nil)
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

  ;; emacs-open-github-from-here
  ;; install: ghq get -p shibayu36/emacs-open-github-from-here.git
  (eval-when-compile
    (add-to-list 'load-path "/Users/risou/src/github.com/shibayu36/emacs-open-github-from-here/")
    (require 'open-github-from-here))

  ;; This is only needed once, near the top of the file
  (eval-when-compile
    ;; Following line is not needed if use-package.el is in ~/.emacs.d
    (add-to-list 'load-path "<path where use-package is installed>")
    (require 'use-package))

  ;; bind-key (from use-package)
  (bind-key* "C-;" 'helm-mini)
  (bind-key* "C-'" 'redo)
  (bind-key* "C-x g" 'helm-projectile-ag)
  (bind-key* "C-c b" 'vc-annotate)
  (bind-key* "C-c o" 'open-github-from-here)
  (bind-key* "C-c C-s" 'isearch-forward-at-point)
  (bind-key* "C-c C-r" 'window-resizer)
  (bind-key* "C-c l" 'windmove-right)
  (bind-key* "C-c h" 'windmove-left)
  (bind-key* "C-c j" 'windmove-down)
  (bind-key* "C-c k" 'windmove-up)
  (bind-key* "M-n" 'tabbar-forward-tab)
  (bind-key* "M-p" 'tabbar-backward-tab)
  ;; (bind-key* "C-TAB" 'tabbar-forward-tab)
  ;; (bind-key* "C-S-TAB" 'tabbar-backward-tab)
  (bind-key* "<C-tab>" 'tabbar-forward-tab)
  (bind-key* "<C-S-tab>" 'tabbar-backward-tab)
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
 '(helm-truncate-lines t)
 '(inhibit-default-init t)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256")))
 '(package-selected-packages
   (quote
    (tabbar lsp-ui yapfify web-mode unfill tagedit slim-mode scss-mode sass-mode pyvenv pytest pyenv-mode py-isort pug-mode pip-requirements org-category-capture alert log4e gntp org-mime markdown-mode magit-popup live-py-mode hy-mode helm-pydoc helm-css-scss haml-mode gitignore-mode fringe-helper git-gutter+ git-gutter fuzzy flyspell-correct pos-tip flycheck magit transient git-commit with-editor emmet-mode window-layout vue-mode edit-indirect ssass-mode vue-html-mode web-beautify minimap livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc company-tern dash-functional tern coffee-mode all-the-icons memoippze font-lock+ go-guru go-eldoc flycheck-gometalinter company-go atom-one-dark-theme yaml-mode xterm-color ws-butler window-numbering which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org sql-indent spacemacs-theme spaceline smeargle shell-pop rvm ruby-tools ruby-test-mode rubocop rspec-mode rotate robe restart-emacs redo+ rbenv rake rainbow-delimiters quelpa popwin point-undo plenv persp-mode paradox orgit org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree mwim multi-term move-text mmm-mode minitest migemo markdown-toc magit-gitflow macrostep lorem-ipsum linum-relative link-hint info+ indent-guide ido-vertical-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-projectile helm-mode-manager helm-make helm-gtags helm-gitignore helm-ghq helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag google-translate golden-ratio go-mode gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md ggtags flyspell-correct-helm flycheck-pos-tip flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help elisp-slime-nav editorconfig e2wm dumb-jump diff-hl define-word ddskk company-statistics comment-dwim-2 column-enforce-mode clean-aindent-mode chruby bundler auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ace-isearch ac-ispell)))
 '(tabbar-separator (quote (0.5))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
