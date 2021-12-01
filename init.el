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
;; grep-find
(global-set-key (kbd "C-c g f") 'grep-find)
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
  :config
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-local-branches
                          nil t)
  (remove-hook 'magit-status-headers-hook 'magit-insert-tags-header)
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
  :hook (prog-mode . highlight-numbers-mode))

(use-package markdown-mode
  :ensure t
  :init (setq markdown-command "/usr/bin/pandoc")
  :config
  (use-package flymd
    :commands (flymd-flyit)
    :ensure t))

(use-package wc-mode
  :ensure t)

(use-package google-c-style
  :ensure t
  :hook (c-mode . google-c-style))

(use-package expand-region
  :commands ( er/expand-region er/contract-region )
  :bind (("M-=" . er/expand-region)
         ("M--" . er/contract-region))
  :ensure t)

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0 company-minimum-prefix-length 3)
  (global-company-mode t)
  (use-package company-web
    :ensure t))

; (use-package company-popup
; :quelpa ((company-popup :fetcher github :repo "gigilibala/company-popup")
;    :upgrade t))

(use-package git-commit
  :ensure t
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

(use-package go-mode
  :ensure t)

;; LSP for python
(use-package lsp-pyright
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook (go-mode . lsp)
  :hook (python-mode . lsp)
  :bind ("C-c C-r" . 'lsp-rename)
  :commands lsp)

(use-package lsp-ui
  :ensure t)

(use-package restclient
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.rest\\'" . restclient-mode))
  :config
  (use-package company-restclient
    :ensure t))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package docker
  :ensure t)

(use-package bazel
  :ensure t)

(use-package project
  :ensure t)

(use-package protobuf-mode
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package terraform-mode
  :ensure t)

(defun unfill-paragraph ()
  "define a new command to join multiple lines together."
  (interactive)
  (setq backup fill-column)
  (setq fill-column 100000)
  (fill-paragraph nil)
  (setq fill-column backup))

(defun add-keywords-faces ()
  "Defines the operators to be highlighted."
  (font-lock-add-keywords nil '(("[]~^!=<>&/%.,:;$\[\|\*\+\-]" . 'font-lock-warning-face))))
(add-hook 'prog-mode-hook 'add-keywords-faces)

(provide 'init.el)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
 '(before-save-hook '(delete-trailing-whitespace))
 '(column-number-mode t)
 '(cursor-type 'bar)
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
 '(lsp-enable-file-watchers nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(mouse-1-click-follows-link 'double)
 '(mouse-wheel-mode t)
 '(mouse-wheel-progressive-speed nil)
 '(org-startup-truncated nil)
 '(package-selected-packages
   (quote
    (terraform-mode yaml-mode protobuf-mode project bazel docker rainbow-delimiters lsp-ui lsp-pyright go-mode lsp-mode company-restclient restclient markdown-mode quelpa-use-package yasnippet-snippets which-key wc-mode use-package smooth-scrolling python-info magit ivy-rich highlight-numbers google-c-style flymd expand-region counsel company company-web company-c-headers)))
 '(rainbow-delimiters-max-face-count 9)
 '(read-process-output-max (* 1024 1024) t)
 '(save-place-mode t)
 '(send-mail-function 'mailclient-send-it)
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(split-height-threshold nil)
 '(split-width-threshold nil)
 '(tab-always-indent 'complete)
 '(tab-width 2)
 '(xterm-mouse-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "color-130"))))
 '(font-lock-constant-face ((t (:foreground "color-208"))))
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
 '(rainbow-delimiters-base-error-face ((t (:inherit rainbow-delimiters-base-face :foreground "brightred"))))
 '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :foreground "brightyellow"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "brightcyan"))))
 '(rainbow-delimiters-depth-3-face ((t (:inherit rainbow-delimiters-base-face :foreground "color-189"))))
 '(rainbow-delimiters-depth-4-face ((t (:inherit rainbow-delimiters-base-face :foreground "brightmagenta"))))
 '(rainbow-delimiters-depth-5-face ((t (:inherit rainbow-delimiters-base-face :foreground "color-26"))))
 '(rainbow-delimiters-depth-6-face ((t (:inherit rainbow-delimiters-base-face :foreground "brightwhite"))))
 '(rainbow-delimiters-depth-7-face ((t (:inherit rainbow-delimiters-base-face :foreground "green"))))
 '(rainbow-delimiters-depth-8-face ((t (:inherit rainbow-delimiters-base-face :foreground "brightmagenta"))))
 '(rainbow-delimiters-depth-9-face ((t (:inherit rainbow-delimiters-base-face :foreground "blue"))))
 '(region ((t (:background "color-240"))))
 '(show-paren-match ((t (:inherit nil :background "cyan")))))
