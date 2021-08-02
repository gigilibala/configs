;-------------------------------------------------------------------------------
; .emacs configuration file
; Author: Amin Hassani (gigilibala4@gmail.com)
;-------------------------------------------------------------------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(defalias 'yes-or-no-p 'y-or-n-p)

;; key bindings
;; delete keys
(global-set-key [delete] 'delete-char) ;delete next character after delete
(global-set-key [backspace] 'delete-backward-char) ;delete backward with backspace
;; goto line
(global-set-key (kbd "C-c g l") 'goto-line)
;; next error or grep finding.
(global-set-key (kbd "M-n") 'next-error)
(global-set-key (kbd "M-p") 'previous-error)
;; Remove this key binding. it is so annoying. Also used by tmux.
(global-unset-key (kbd "C-t"))

;; Keys for compile
(global-set-key (kbd "M-1") 'compile)
(global-set-key (kbd "M-2") 'recompile)

(require 'use-package)

(use-package quelpa-use-package
  :ensure t)

(use-package counsel
  :ensure t
  :init
  (use-package ivy
    :ensure t
    :init
    (setq ivy-mode t)
    (setq ivy-use-virtual-buffers t)
    :config
    (define-key ivy-minibuffer-map (kbd "M-n") 'ivy-next-line)
    (define-key ivy-minibuffer-map (kbd "M-p") 'ivy-previous-line))
  (use-package ivy-rich
    :ensure t
    :init
    :config
    (ivy-rich-mode))
  :bind(("M-x" . counsel-M-x)
        ("C-c s" . swiper)
        ("C-x C-f" . counsel-find-file)
        ("C-h f" . counsel-describe-function)
        ("C-h v" . counsel-describe-variable)
        ("C-c j" . counsel-git-grep)))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :bind (:map magit-file-section-map
              ("RET" . magit-diff-visit-file-other-window)
              :map magit-hunk-section-map
              ("RET" . magit-diff-visit-file-other-window))
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
  :bind (("C-c C-y" . yas-insert-snippet))
  :config
  (yas-global-mode t)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)
  (use-package yasnippet-snippets
    :ensure t))
(use-package highlight-numbers
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'highlight-numbers-mode))

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

(use-package python-info
  :commands (info)
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package restclient
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0 company-minimum-prefix-length 3)
  (add-hook 'python-mode-hook
            (lambda () (add-to-list 'company-backends 'company-jedi)))
  (global-company-mode t)
  (use-package company-c-headers
    :ensure t)
  (use-package company-jedi
    :ensure t)
  (use-package company-go
    :ensure t)
  (use-package company-web
    :ensure t)
  (use-package company-restclient
    :ensure t))
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

; (use-package company-popup
; :quelpa ((company-popup :fetcher github :repo "gigilibala/company-popup")
;    :upgrade t))

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

(use-package which-key
  :ensure t
  :config
  (which-key-mode t))

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

(elpy-enable)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(before-save-hook (quote (delete-trailing-whitespace)))
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(electric-pair-mode t)
 '(fill-column 80)
 '(font-lock-maximum-decoration t)
 '(global-auto-revert-mode t)
 '(global-hl-line-mode t)
 '(global-subword-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(line-number-mode t)
 '(make-backup-files nil)
 '(mouse-1-click-follows-link (quote double))
 '(mouse-wheel-mode t)
 '(mouse-wheel-progressive-speed nil)
 '(org-startup-truncated nil)
 '(package-selected-packages
   (quote
    (company-go company-restclient restclient markdown-mode quelpa-use-package yasnippet-snippets which-key wc-mode use-package smooth-scrolling python-info magit ivy-rich highlight-numbers google-c-style flymd expand-region counsel company company-web company-jedi company-c-headers)))
 '(save-place-mode t)
 '(send-mail-function (quote mailclient-send-it))
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(split-height-threshold nil)
 '(split-width-threshold nil)
 '(tab-always-indent (quote complete))
 '(tab-width 2)
 '(xterm-mouse-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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
 '(show-paren-match ((t (:inherit nil :background "cyan")))))
