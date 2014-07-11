(setq user-full-name "Daniel Mai")
(setq user-mail-address "daniel@danielmai.net")

(setq inhibit-startup-screen t)
(prefer-coding-system 'utf-8-unix)
(setq indent-tabs-mode nil)
(setq require-final-newline t)

(setq initial-scratch-message "")
(setq inhibit-startup-message nil)

; Package manager
(load "package")
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(defvar my-packages '(
		      auto-complete
		      cider
		      clojure-mode
		      color-theme-solarized
		      expand-region
		      ido-ubiquitous
		      ido-vertical-mode
		      jedi
		      magit
		      markdown-mode
		      org
		      paredit
		      python-mode
		      smex
		      twittering-mode
		      visual-regexp
		      visual-regexp-steroids
		      color-theme-solarized
		      yasnippet))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

; add directories to load path
;; (add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/customizations")

; handy function to load all elisp files in a directory
(load-file "~/.emacs.d/load-directory.el")

; load customizations
(mapcar 'load-directory '("~/.emacs.d/customizations"))

; load mac configurations if running emacs on a Mac
(if (string-equal system-type "darwin")
    (mapcar 'load-directory '("~/.emacs.d/mac-customizations")))

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(background-color "#fcf4dc")
 '(background-mode dark)
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(blink-cursor-delay 0.5)
 '(cursor-color "#52676f")
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("60f04e478dedc16397353fb9f33f0d895ea3dab4f581307fbf0aa2f07e658a40" "fe6330ecf168de137bb5eddbf9faae1ec123787b5489c14fa5fa627de1d9f82b" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(fci-rule-color "#383838")
 '(foreground-color "#52676f")
 '(ns-antialias-text t)
 '(org-agenda-files (quote ("~/Dropbox/Work/time.org")))
 '(org-insert-mode-line-in-empty-file t)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;(add-hook 'comint-output-filter-functions
;'comint-watch-for-password-prompt)

;(global-linum-mode t)

;; Remap M-x functionality
(global-set-key "\C-x\C-m" 'smex)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; backward kill word
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; solarized dark theme
(load-theme 'solarized-dark t)

;; tomorrow-bright theme
;(load-theme 'sanityinc-tomorrow-bright)

;; ido
(require 'ido)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

; ido everywhere (for real)
(require 'ido-ubiquitous)
(ido-ubiquitous-mode)

; use vertical layout for ido
(require 'ido-vertical-mode)
(ido-vertical-mode 1)

;; jedi
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(add-hook 'python-mode-hook 'jedi:setup)

;; auto-complete
;; (global-auto-complete-mode t)

;; see file-path in the title bar
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b"))))

(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

; turn off the blinking cursor
(blink-cursor-mode -1)

; markdown mode setup and associations
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; define key for magit-status
(global-set-key "\C-cg" 'magit-status)

;; define keys for resizing the current window
(global-set-key (kbd "s-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "s-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "s-C-<down>") 'shrink-window)
(global-set-key (kbd "s-C-<up>") 'enlarge-window)

; expand region key binding
(global-set-key (kbd "C-@") 'er/expand-region)

; delete selection
(delete-selection-mode 1)

; use shift to select text
(setq shift-select-mode t)

(setq ispell-program-name "/usr/local/Cellar/ispell/3.3.02/bin/ispell")

; turn off mail composition
(put 'compose-mail 'disabled t)

; use smex
(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key (kbd "M-n") 'scroll-up-line)
(global-set-key (kbd "M-p") 'scroll-down-line)

; don't ring the audible bell. Just use a visual square
(setq visible-bell t)

; use visual line mode everywhere
(global-visual-line-mode t)

; disable native fullscreen for OS X and redefine key binding for fullscreen
(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "C-<f11>") 'toggle-frame-fullscreen)
(global-set-key (kbd "\C-x\C-z") 'toggle-frame-fullscreen)

; fci-mode
(require 'fill-column-indicator)

;; ; default window width and height
;; (defun custom-set-frame-size ()
;;   (add-to-list 'default-frame-alist '(height . 65))
;;   (add-to-list 'default-frame-alist '(width . 99)))
;; (custom-set-frame-size)
;; (add-hook 'before-make-frame-hook 'custom-set-frame-size)

(global-set-key "\C-cad" 'dash-at-point)
(global-set-key (kbd "H-d") 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)

; don't count two spaces after a period to be the end of the sentence. just
; count one
(setq sentence-end-double-space nil)

; fix magit emacsclient so it doesn't open another emacs instance (while running
; Homebrew Emacs)
(set-variable 'magit-emacsclient-executable "/usr/local/Cellar/emacs/24.3/bin/emacsclient")
(put 'dired-find-alternate-file 'disabled nil)


; Taken from [[http://www.masteringemacs.org/articles/2012/05/29/compiling-running-scripts-emacs/]]
;;; Shut up compile saves
(setq compilation-ask-about-save nil)
;;; Don't save *anything*
(setq compilation-save-buffers-predicate '(lambda () nil))

; turn on smartscan everywhere
; (global-smartscan-mode 1)

; highlights parentheses
(show-paren-mode t)

; This makes sure that brace structures (), [], {}, etc. are closed as soon as the opening character is typed.
(require 'autopair)

; Nobody likes to have to type out the full yes or no when Emacs asks. Which it does quite often. Make it one character.
(defalias 'yes-or-no-p 'y-or-n-p)

; redefine key bindings for smartscan
(global-set-key [(super n)] 'smartscan-symbol-go-forward)
(global-set-key [(super p)] 'smartscan-symbol-go-backward)

; define key for hippie expand
(global-set-key "\M-/" 'hippie-expand)

; set the return key to create a newline and indent
(global-set-key (kbd "RET") 'newline-and-indent)


(defun save-and-recompile ()
  "Save the current buffer and recompile."
  (interactive) (save-buffer) (recompile))
(global-set-key (kbd "H-s") 'save-and-recompile)

(setq compilation-scroll-output 'first-error)

; exec-path-from-shell
;; set $PATH variables for Emacs to be the same as the one from the terminal
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

; powerline
;; (require 'powerline)
;; (powerline-default-theme)

;; ; set the colors for solarized dark
;; (setq powerline-color1 "#073642")
;; (setq powerline-color2 "#002b36")

;; ; Powerline modeline colors for solarized-dark
;; (set-face-attribute 'mode-line nil
;;                     :foreground "#fdf6e3"
;;                     :background "#207B74"
;;                     :box nil
;; 		    :inverse-video nil)
;; (set-face-attribute 'mode-line-inactive nil
;;                     :box nil
;; 		    :inverse-video nil)

;; ;; ; solarized-light mode line
;; ;; (set-face-attribute 'mode-line nil
;; ;;                     :foreground "#222"
;; ;;                     :background "#c6ba85"
;; ;;                     :box nil
;; ;; 		    :inverse-video nil)


;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

; yasnippet
(yas-global-mode)

; TODO: set the comment for asm-mode to the "#" character


; org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (C . t)
   (latex . t)
   (java . t)
   (ruby . t)
   (scheme . t)))

(defun my-org-confirm-babel-evaluate (lang body)
  (not (or (string= lang "C")
	   (string= lang "java")
	   (string= lang "python"))))  ; don't ask for c, java, or python
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)


; python debugging
(defvar python--pdb-breakpoint-string "import pdb; pdb.set_trace()"
  "Python breakpoint string used by `python-insert-breakpoint'")


(defadvice compile (before ad-compile-smart activate)
  "Advises `compile' so it sets the argument COMINT to t
if breakpoints are present in `python-mode' files"
  (when (derived-mode-p major-mode 'python-mode)
    (save-excursion
      (save-match-data
        (goto-char (point-min))
        (if (re-search-forward (concat "^\\s-*" python--pdb-breakpoint-string "$")
                               (point-max) t)
            ;; set COMINT argument to `t'.
            (ad-set-arg 1 t))))))


; re-builder
(require 're-builder)
(setq reb-re-syntax 'string)


; turn on syntax highlighting for src code blocks in org mode
(setq org-src-fontify-natively t)

; show the current time in the modeline
(display-time)

;; Highlight tabulations
(setq-default highlight-tabs t)

; erc settings
;; ignore messages I don't care to see
(setq erc-hide-list '("JOIN" "PART" "QUIT"))

;; beautify erc
(setq erc-fill-function 'erc-fill-static)
(setq erc-fill-static-center 22)

;; c-eldoc setup
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
(put 'narrow-to-region 'disabled nil)

;; visual-regexp
;; (require 'visual-regexp)
;; (define-key global-map (kbd "C-c r") 'vr/replace)
;; (define-key global-map (kbd "C-c q") 'vr/query-replace)
;; ;; if you use multiple-cursors, this is for you:
;; (define-key global-map (kbd "C-c m") 'vr/mc-mark)

(require 'visual-regexp-steroids)
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
;; if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)
;; to use visual-regexp-steroids's isearch instead of the built-in regexp isearch, also include the following lines:
(define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
(define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s

(add-hook 'org-mode-hook 'abbrev-mode)


; idle highlight mode
;; (add-hook 'java-mode-hook 'idle-highlight-mode)


; ace-jump-mode
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c a SPC") 'ace-jump-mode)
(put 'upcase-region 'disabled nil)

;; shell key bindings
(global-set-key (kbd "C-x m") 'shell)
(global-set-key (kbd "C-x M") 'ansi-term)


;; rebind just-one-space so it doesn't conflict with Alfred
(global-set-key (kbd "H-SPC") 'just-one-space)
