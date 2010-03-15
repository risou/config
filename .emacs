;; �t�H���g�Z�b�g�ǉ�
(create-fontset-from-ascii-font
 "-outline-MeiryoKe_Gothic-normal-r-normal-normal-12-*-*-*-*-*-iso8859-1"
 nil "mkgothic")
(set-fontset-font "fontset-mkgothic" 'japanese-jisx0208
		  '("MeiryoKe_Gothic" . "jisx0208-sjis"))
(set-fontset-font "fontset-mkgothic" 'katakana-jisx0201
		  '("MeiryoKe_Gothic" . "jisx0201-katakana"))

;; �f�t�H���g�l�ݒ�
(setq default-frame-alist
      (append (list '(alpha . 85)			;; �s�����x
		    '(background-color . "gray10")	;; �w�i�F
		    '(foreground-color . "white")	;; �����F
		    '(font . "fontset-mkgothic")	;; �t�H���g
		    '(width . 120)					;; ������/�s
		    '(height . 40)					;; ��
		    '(top . 100)					;; �E�B���h�E�J�n�ʒu�i�c�j
		    '(left . 100)					;; �E�B���h�E�J�n�ʒu�i���j
		    '(cursor-color . "SlateBlue2")	;; �J�[�\���F
		    )
	      default-frame-alist))

;; �^�C�g���o�[�Ƀt�@�C������\��
(setq frame-title-format "%f")
;; �c�[���o�[���\��
(tool-bar-mode 0)
;; �s�ԍ���\��
(require 'linum)
(global-linum-mode)
;; �^�u����4�ɐݒ�
(setq-default tab-width 4)
;; �C���f���g����4�ɐݒ�
(setq-default indent-level 4)
;; �^�u�������󔒕����ɖ߂����ɍ폜
(global-set-key [backspace] 'backward-delete-char)
;; �I�[�g�C���f���g
(setq indent-line-function 'indent-relative-maybe)
(global-set-key "\C-m" 'reindent-then-newline-and-indent)
(global-set-key "\C-m" 'indent-new-comment-line)
;; ���s�Ƃ��^�u�Ƃ��S�p�X�y�[�X�Ƃ�
(setq jaspace-alternate-jaspace-string "��")
(setq jaspace-alternate-eol-string "\xab\n")
(setq jaspace-highlight-tabs ?> )
(defface jaspace-highlight-tab-face
	'((t (:background "gray50"))) nil)
(require 'jaspace)

;; 1�s���X�N���[��
(setq scroll-step 1)
;; �o�b�N�A�b�v�t�@�C���̐�����OFF
(setq make-backup-files nil)
(setq auto-save-default nil)
;; ���v�̕\��
(display-time-mode 1)
;; Ctrl+h�Ńo�b�N�X�y�[�X
(global-set-key "\C-h" 'backward-delete-char)

(global-font-lock-mode 1)

;; ������ʔ�\��
(setq inhibit-startup-message t)

;; howm
(setq howm-menu-lang 'ja)
(require 'howm-mode)
