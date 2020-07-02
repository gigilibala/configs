;-------------------------------------------------------------------------------
; .emacs configuration file
; Author: Amin Hassani (ahassani4@gmail.com)
; Last modified: 08/17/2014
;-------------------------------------------------------------------------------

;; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
(require 'use-package)

(column-number-mode t)
(delete-selection-mode t)
(delete-selection-mode t)
(electric-pair-mode t)
(global-auto-revert-mode t)
(global-hl-line-mode t)
(global-subword-mode t) ;; For camel case.
(line-number-mode t)
(save-place-mode t)
(show-paren-mode t)
(show-paren-mode t)
(xterm-mouse-mode t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; key bindings
;; delete keys
(global-set-key [delete] 'delete-char) ;delete next character after delete
(global-set-key [backspace] 'delete-backward-char) ;delete backward with backspace
;; goto line
(global-set-key (kbd "C-c g l") 'goto-line)
;; I don't know what these do exactly.
(define-key input-decode-map "\e\e[A" [(meta up)])
(define-key input-decode-map "\e\e[B" [(meta down)])
;; next error or grep finding.
(global-set-key (kbd "M-n") 'next-error)
(global-set-key (kbd "M-p") 'previous-error)
;; remove this key binding. it is so annoying
(global-unset-key (kbd "C-t"))

;; Key for compile
(global-set-key (kbd "C-c C-c") 'recompile)


(use-package quelpa-use-package
  :ensure t)

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0
	company-minimum-prefix-length 3)
  (add-hook 'python-mode-hook (lambda ()
				(add-to-list 'company-backends 'company-jedi)))
  (global-company-mode t)
  (use-package company-c-headers
    :ensure t)
  (use-package company-jedi
    :ensure t)
  (use-package company-web
    :ensure t))

(use-package counsel
  :ensure t
  :init
  (setq ivy-mode t)
  (setq ivy-use-virtual-buffers t)
  (use-package ivy-rich
    :config
    (ivy-rich-mode)
    :ensure t)
  :bind(("M-x" . counsel-M-x)
	("C-c s" . swiper)
	("C-x C-f" . counsel-find-file)
	("C-h f" . counsel-describe-function)
	("C-h v" . counsel-describe-variable)
	("C-c j" . counsel-git-grep)))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :custom-face
  (magit-branch-current ((t (:inherit magit-branch-local :box 1))))
  (magit-branch-local ((t (:foreground "red"))))
  (magit-diff-added ((t (:foreground "#22aa22"))))
  (magit-diff-added-highlight ((t (:inherit magit-section-highlight :foreground "#22aa22"))))
  (magit-diff-context-highlight ((t (:inherit magit-section-highlight))))
  (magit-diff-removed ((t (:foreground "#aa2222"))))
  (magit-diff-removed-highlight ((t (:inherit magit-section-highlight :foreground "#aa2222"))))
  (magit-section-highlight ((t (:background "color-236")))))

(use-package smooth-scrolling
  :ensure t
  :config
  (setq scroll-conservatively 10000
	scroll-step 1
	smooth-scroll-margin 1))

(use-package yasnippet
  :ensure t
  :config
  (setq yas-global-mode t)
  (use-package yasnippet-snippets
    :ensure t))

(use-package highlight-numbers
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'highlight-numbers-mode))

(use-package ecb
  :ensure t
  :commands (ecb-activate)
  :config
  (setq ecb-layout-name "left9"
				ecb-options-version "2.50"
				ecb-show-sources-in-directories-buffer (quote always)
				ecb-source-path (quote ("/usr/local/google/home/ahassani"))
				ecb-tip-of-the-day nil)
  :custom-face
  (speedbar-tag-face ((t (:foreground "#d7ff00"))))
  (ecb-method-non-semantic-face ((t (:inherit ecb-methods-general-face :foreground "brightyellow"))))
  (ecb-source-in-directories-buffer-face ((t (:inherit ecb-directories-general-face :foreground "cyan"))))
  (ecb-tag-header-face ((t (:background "blue")))))

(use-package flymd
  :commands (flymd-flyit)
  :ensure t)

(use-package wc-mode
  :ensure t)

(use-package google-c-style
  :ensure t
  :init
  (add-hook 'c-mode-common-hook 'google-set-c-style))

(use-package expand-region
  :commands ( er/expand-region er/contract-region )
  :bind (("M-=" . er/expand-region)
	 ("M--" . er/contract-region))
  :ensure t)

(use-package wakatime-mode
  :ensure t
  :init
  (when (executable-find "wakatime")
    (global-wakatime-mode)
    (setq wakatime-api-key "90e9b493-f22f-4151-8882-4abe73f1146d")))

(use-package python-info
  :commands (info)
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package company-popup
  :quelpa ((company-popup :fetcher github :repo "gigilibala/company-popup")
	   :upgrade t))

(use-package git-commit
  :ensure nil
  :preface
  (defun me/git-commit-set-fill-column ()
    (setq-local comment-auto-fill-only-comments nil)
    (setq git-commit-summary-max-length 50)
    (setq fill-column 72))
  :config
  (advice-add 'git-commit-turn-on-auto-fill :before #'me/git-commit-set-fill-column))

(add-hook 'java-mode-hook '(lambda () (setq fill-column 100)))
(add-to-list 'auto-mode-alist '("\\.ebuild\\'" . sh-mode))

;; windows system
(when (window-system)
  (set-background-color "gray20")
  (set-foreground-color "white")
  (global-set-key "\C-x\C-c" 'ask-before-closing)
  (tool-bar-mode -1))

;; ask to exit before closing
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
	  (save-buffers-kill-terminal)
    (message "Cancelled exit")))

(defun unfill-paragraph ()
  "define a new command to join multiple lines together."
  (interactive)
  (setq backup fill-column)
  (setq fill-column 100000)
  (fill-paragraph nil)
  (setq fill-column backup))

(defun set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (window-resize (selected-window) (- 82 (window-width)) t))

(defun add-keywords-faces ()
  "Defines the operators to be highlighted."
  (font-lock-add-keywords nil '(("[]~^!=<>&/%.,:;$\[\|\*\+\-]" . 'font-lock-warning-face))))
(add-hook 'prog-mode-hook 'add-keywords-faces)

;; (defun copy-line (arg)
;;   "Copy lines (as many as prefix argument) in the kill ring"
;;   (interactive "p")
;;   (kill-ring-save (line-beginning-position)
;;                   (line-beginning-position (+ 1 arg))))
;; (global-set-key (kbd "C-k") 'kill-whole-line)
;; (global-set-key (kbd "C-c k") 'copy-line)

(provide 'init.el)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(before-save-hook (quote (delete-trailing-whitespace)))
 '(ecb-options-version "2.50")
 '(fill-column 80)
 '(font-lock-maximum-decoration t)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(mouse-1-click-follows-link (quote double))
 '(mouse-wheel-mode t)
 '(mouse-wheel-progressive-speed nil)
 '(org-startup-truncated nil)
 '(package-selected-packages
   (quote
    (company-popup markdown-mode quelpa-use-package yasnippet-snippets which-key wc-mode wakatime-mode use-package smooth-scrolling python-info popup magit ivy-rich highlight-numbers google-c-style flymd expand-region ecb counsel company company-web company-jedi company-c-headers)))
 '(send-mail-function (quote mailclient-send-it))
 '(show-paren-delay 0)
 '(split-height-threshold nil)
 '(split-width-threshold nil)
 '(tab-always-indent (quote complete))
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-method-non-semantic-face ((t (:inherit ecb-methods-general-face :foreground "brightyellow"))))
 '(ecb-source-in-directories-buffer-face ((t (:inherit ecb-directories-general-face :foreground "cyan"))))
 '(ecb-tag-header-face ((t (:background "blue"))))
 '(font-lock-comment-face ((t (:foreground "color-130"))))
 '(font-lock-constant-face ((t (:foreground "color-45"))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face :foreground "chocolate"))))
 '(font-lock-function-name-face ((t (:foreground "brightcyan"))))
 '(font-lock-keyword-face ((t (:foreground "brightmagenta"))))
 '(font-lock-negation-char-face ((t (:foreground "brightred"))))
 '(font-lock-string-face ((t (:foreground "brightgreen"))))
 '(font-lock-type-face ((t (:foreground "color-196"))))
 '(font-lock-variable-name-face ((t (:foreground "color-154"))))
 '(font-lock-warning-face ((t (:inherit nil :foreground "color-214"))))
 '(highlight ((t (:background "color-235"))))
 '(lazy-highlight ((t (:background "brightblack"))))
 '(magit-branch-current ((t (:inherit magit-branch-local :box 1))))
 '(magit-branch-local ((t (:foreground "red"))))
 '(magit-diff-added ((t (:foreground "#22aa22"))))
 '(magit-diff-added-highlight ((t (:inherit magit-section-highlight :foreground "#22aa22"))))
 '(magit-diff-context-highlight ((t (:inherit magit-section-highlight))))
 '(magit-diff-removed ((t (:foreground "#aa2222"))))
 '(magit-diff-removed-highlight ((t (:inherit magit-section-highlight :foreground "#aa2222"))))
 '(magit-section-highlight ((t (:background "color-236"))))
 '(match ((t (:background "color-136"))))
 '(minibuffer-prompt ((t (:foreground "brightcyan"))))
 '(region ((t (:background "color-240"))))
 '(show-paren-match ((t (:inherit nil :background "cyan"))))
 '(speedbar-tag-face ((t (:foreground "#d7ff00")))))
