;;;  ====== Global settings =====

;;* ======  Personal information ======

(setq user-full-name "Matthew E. Adams"
      user-mail-address "m2eadams@gmail.com")

;;* ===== Startup behavior =====

(setq inhibit-startup-screen t) ;; stop showing startup screen
(tool-bar-mode 0)               ;; remove the icons
(menu-bar-mode 0)               ;; toggle the menu bar

(setq custom-file (expand-file-name "user/custom.el" emacs-main-dir))

;;* ===== Keybindgs using General package =====

;; For later exploration

(use-package general
  :ensure t)


(use-package hydra
  :init
  (setq hydra-is-helpful t)
  
  :config
  (require 'hydra-ox))

;;* ===== Unicode ======

(set-charset-priority 'unicode)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;;* ===== Theme and font ======

;;** Startup theme
;;(load-theme 'doom-peacock t)

;;** Set themes index
(setq owl/themes '(doom-peacock doom-tomorrow-night flatui-dark cyberpunk doom-one-light leuven eink flatui))
(setq owl/themes-index 0)

;;** Function to cycle through themes
(defun owl/cycle-theme ()
  (interactive)
  (setq owl/themes-index (% (1+ owl/themes-index) (length owl/themes)))
  (owl/load-indexed-theme))

(global-set-key (kbd "<f12>") 'owl/cycle-theme)

;;** Load indexed theme and disable previous theme to prevent overlay
(defun owl/load-indexed-theme ()
  (owl/try-load-theme (nth owl/themes-index owl/themes)))

(defun owl/try-load-theme (theme)
  (if (ignore-errors (load-theme theme :no-confirm))
      (mapcar #'disable-theme (remove theme custom-enabled-themes))
    (message "Unable to find theme file for ‘%s’" theme)))

;;** Default fonts
(add-to-list 'default-frame-alist '(font . "Input Mono 10" ))
(set-face-attribute 'default t :font "Input Mono 10" )

;;** Use variable width font faces in current buffer
(defun my-buffer-face-mode-variable ()
  "Set font to a variable width (proportional) fonts in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "GentiumPlus" :height 100))
  (buffer-face-mode))

;;** Use monospaced font faces in current buffer
(defun my-buffer-face-mode-fixed ()
  "Sets a fixed width (monospace) font in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "Input Mono" :height 100))
  (buffer-face-mode))

;;** Set default font faces for Info and ERC modes
(add-hook 'erc-mode-hook 'my-buffer-face-mode-variable)
(add-hook 'Info-mode-hook 'my-buffer-face-mode-variable)

;;** Control-c + Control-f/v to change font type
(global-set-key (kbd "C-c C-f") 'my-buffer-face-mode-fixed)
(global-set-key (kbd "C-c C-v") 'my-buffer-face-mode-variable)

;;** Control-c + Control+Arrows to change font size
(global-set-key (kbd "C-c C-<up>") 'text-scale-increase)
(global-set-key (kbd "C-c C-<down>") 'text-scale-decrease)

;;** Hydra to zoom text
(defhydra hydra-zoom (global-map "<f6>")
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out") 
  ("r" (text-scale-set 0) "reset")
  ("0" (text-scale-set 0) :bind nil :exit t)
  ("1" (text-scale-set 0) nil :bind nil :exit t))

;;* ===== Backup ======

(setq backup-inhibited t)       ;; Disable backup creation

(setq auto-save-list-file-prefix (expand-file-name "auto-save-list/saves-" emacs-main-dir))

(require 'savehist)
(setq savehist-file (concat user-emacs-directory "savehist"))
(savehist-mode 1)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))
(setq-default save-place t)

;;* ===== Visual appearance and behaviors ======

;;** Answer with y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;** Handle long lines by visual wrapping but no line-returns
(global-visual-line-mode 1)

;;** Turn on font-lock everywhere
(global-font-lock-mode t)

(auto-fill-mode -1)             ;; Disprefer auto-fill-mode
(show-paren-mode 1)             ;; Highlight parentheses
(setq show-paren-style 'mixed)  ;; Alternatives: 'expression, 'parenthesis

;;** Cursor color
;;(set-cursor-color "#ffffff")

;;** Change cursor shape
(setq-default cursor-type 'box)

;;** Show lines and column numbers
(line-number-mode 1)
(column-number-mode 1)

;;** End annoying buffers with popwin
(use-package popwin
  :ensure t
  :config
  (popwin-mode 1))

(global-set-key (kbd "C-z") popwin:keymap)

;; | Key    | Command                               |
;; |--------+---------------------------------------|
;; | b      | popwin:popup-buffer                   |
;; | l      | popwin:popup-last-buffer              |
;; | o      | popwin:display-buffer                 |
;; | C-b    | popwin:switch-to-last-buffer          |
;; | C-p    | popwin:original-pop-to-last-buffer    |
;; | C-o    | popwin:original-display-last-buffer   |
;; | SPC    | popwin:select-popup-window            |
;; | s      | popwin:stick-popup-window             |
;; | 0      | popwin:close-popup-window             |
;; | f, C-f | popwin:find-file                      |
;; | e      | popwin:messages                       |
;; | C-u    | popwin:universal-display              |
;; | 1      | popwin:one-window                     |

;;* ===== Editing =====

;;** Visual undo 

(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode t)
  :defer t
  :diminish ""
  :config
  (progn
    (define-key undo-tree-map (kbd "C-x u") 'undo-tree-visualize)
    (define-key undo-tree-map (kbd "C-/") 'undo-tree-undo)))

;;** Spell checking

(use-package flyspell-correct-ivy
  :ensure t
  :init
  (setq ispell-program-name (executable-find "hunspell")   ; Use hunspell
	ispell-dictionary "en_US"
	flyspell-correct-interface 'flyspell-correct-ivy
	ispell-local-dictionary-alist '("deutsch-hunspell"
					"[[:alpha:]]"
					"[^[:alpha:]]"
					"[']"
					t
					("-d" "de_DE")   ; Dictionary file name
					nil
					utf-8)
	ispell-local-dictionary-alist '("english-hunspell"
					"[[:alpha:]]"
					"[^[:alpha:]]"
					"[']"
					t
					("-d" "en_US")
					nil
					utf-8)))

(bind-key "C-c G"
	  (lambda ()
	    (interactive)
	    (ispell-change-dictionary "de_DE")
	    (flyspell-buffer)))

(bind-key "C-c E"
	  (lambda ()
	    (interactive)
	    (ispell-change-dictionary "en_US")
	    (flyspell-buffer))) 



(use-package flx)

;;* ===== Literate programming ======

;;** Outline-minor-mode key map
(define-prefix-command 'cm-map nil "Outline-")

;;*** Hide
(define-key cm-map "q" 'hide-sublevels)    ; Hide everything but the top-level headings
(define-key cm-map "t" 'hide-body)         ; Hide everything but headings (all body lines)
(define-key cm-map "o" 'hide-other)        ; Hide other branches
(define-key cm-map "c" 'hide-entry)        ; Hide this entry's body
(define-key cm-map "l" 'hide-leaves)       ; Hide body lines in this entry and sub-entries
(define-key cm-map "d" 'hide-subtree)      ; Hide everything in this entry and sub-entries

;;*** Show
(define-key cm-map "a" 'show-all)          ; Show (expand) everything
(define-key cm-map "e" 'show-entry)        ; Show this heading's body
(define-key cm-map "i" 'show-children)     ; Show this heading's immediate child sub-headings
(define-key cm-map "k" 'show-branches)     ; Show all sub-headings under this heading
(define-key cm-map "s" 'show-subtree)      ; Show (expand) everything in this heading & below
;;*** Move
(define-key cm-map "u" 'outline-up-heading)                ; Up
(define-key cm-map "n" 'outline-next-visible-heading)      ; Next
(define-key cm-map "p" 'outline-previous-visible-heading)  ; Previous
(define-key cm-map "f" 'outline-forward-same-level)        ; Forward - same level
(define-key cm-map "b" 'outline-backward-same-level)       ; Backward - same level
(global-set-key "\M-o" cm-map)

;;* ===== Buffer navigation & Ivy =====

;;** Direx
(use-package direx
  :ensure t
  :config
  (require 'direx)
  (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory))

;;** Ivy
(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :bind
  (:map ivy-mode-map
	("C-'" . ivy-avy))
  :init
  (use-package counsel
    :ensure t)
  :config
  (ivy-mode 1)
  ;;*** Find file actions
  ;; add ‘recentf-mode’ and bookmarks to ‘ivy-switch-buffer’.
  (setq ivy-use-virtual-buffers t)
  ;; number of result lines to display
  (setq ivy-height 10)
  ;; does not count candidates
  (setq ivy-count-format "")
  ;; no regexp by default
  (setq ivy-initial-inputs-alist nil)
  ;; configure regexp engine
  (setq ivy-re-builders-alist
	;; allow input not in order
        '((t   . ivy--regex-ignore-order))))

(use-package ivy-hydra)

;;** Eyebrowse
;; Easy workspaces creation and switching
;; (use-package eyebrowse                  
;;   :ensure t
;;   :config
;;   (setq eyebrowse-mode-line-separator " "
;; 	eyebrowse-new-workspace t)

;;   (eyebrowse-mode t))

;;* ===== Magit =====

(use-package magit
  :init (setq magit-completing-read-function 'ivy-completing-read)
  :bind
  ("<f5>" . magit-status)
  ("C-c v t" . magit-status))

;; (use-package magithub
;;   :after magit)

;;* ===== End matter
(provide 'global-settings)

;;; Local Variables:
;;; eval: (outline-minor-mode 1)
;;; outline-regexp: ";;\\*+\\|\\`"
;;; End:
