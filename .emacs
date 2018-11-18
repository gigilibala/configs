;-------------------------------------------------------------------------------
; .emacs configuration file
; Author: Amin Hassani (ahassani4@gmail.com)
; Last modified: 08/17/2014
;-------------------------------------------------------------------------------

;; package
(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) 
(package-initialize)

;(require 'google-ycmd)

(add-hook 'java-mode-hook '(lambda () (setq fill-column 100)))
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'jedi:ac-setup)

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

;; define a new command to join multiple lines together.
(defun unfill-paragraph () (interactive)
 (setq backup fill-column)
 (setq fill-column 100000)
 (fill-paragraph nil)
 (setq fill-column backup)
)

(setq split-height-threshold nil
      split-width-threshold nil)

(defun set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (window-resize (selected-window) (- 82 (window-width)) t))

;; key bindings
;; delete keys
(global-set-key [delete] 'delete-char) ;delete next character after delete
(global-set-key [backspace] 'delete-backward-char) ;delete backward with backspace
;; goto line
(global-set-key (kbd "C-c g l") 'goto-line)
(define-key input-decode-map "\e\e[A" [(meta up)])
(define-key input-decode-map "\e\e[B" [(meta down)])

;; next error or grep finding
(global-set-key (kbd "M-n") 'next-error)
(global-set-key (kbd "M-p") 'previous-error)

(global-set-key (kbd "C-c k") 'delete-window)

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key "\C-s" 'swiper)
(global-set-key "\C-r" 'swiper)
(global-set-key (kbd "C-c j") 'counsel-git-grep)

(global-set-key (kbd "C-x g") 'magit-status)

;; remove this key binding. it is so annoying
(global-unset-key (kbd "C-t"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:inherit diff-changed :background "#ddffdd" :foreground "black"))))
 '(diff-hunk-header ((t (:inherit diff-header :foreground "black"))))
 '(diff-indicator-removed ((t (:inherit diff-removed :foreground "black"))))
 '(diff-refine-changed ((t (:background "#ffff55" :foreground "black"))))
 '(diff-removed ((t (:inherit diff-changed :background "#ffdddd" :foreground "black"))))
 '(ecb-method-non-semantic-face ((t (:inherit ecb-methods-general-face :foreground "brightyellow"))))
 '(ecb-source-in-directories-buffer-face ((t (:inherit ecb-directories-general-face :foreground "cyan"))))
 '(ecb-tag-header-face ((t (:background "blue"))))
 '(ediff-current-diff-A ((t (:background "#ffdddd" :foreground "black"))))
 '(ediff-current-diff-B ((t (:background "#ddffdd" :foreground "black"))))
 '(ediff-current-diff-C ((t (:background "#ffffaa" :foreground "black"))))
 '(ediff-even-diff-A ((t (:background "light grey" :foreground "black"))))
 '(ediff-even-diff-C ((t (:background "light grey" :foreground "black"))))
 '(ediff-fine-diff-C ((t (:background "#ffff55" :foreground "black"))))
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
 '(show-paren-match ((t (:inherit nil :foreground "color-117"))))
 '(speedbar-button-face ((t (:foreground "green"))))
 '(speedbar-directory-face ((t (:foreground "brightwhite"))))
 '(speedbar-tag-face ((t (:foreground "brightcyan")))))

(defun add-keywords-faces ()
  "Defines the operators to be highlighted."
  (font-lock-add-keywords nil '(("[]~^!=<>&/%.,:;$\[\|\*\+\-]" . 'font-lock-warning-face))))
(add-hook 'prog-mode-hook 'add-keywords-faces)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

(add-to-list 'auto-mode-alist '("\\.ebuild\\'" . sh-mode))

(setq mode-line-position
  (append
   mode-line-position
   '((wc-mode
      (6 (:eval (if (use-region-p)
		    (format " %d,%d,%d"
			    (abs (- (point) (mark)))
			    (count-words-region (point) (mark))
			    (abs (- (line-number-at-pos (point))
				    (line-number-at-pos (mark)))))
		  (format " %d,%d,%d"
			  (- (point-max) (point-min))
			  (count-words-region (point-min) (point-max))
			  (line-number-at-pos (point-max))))))
      nil))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(column-number-mode t)
 '(company-idle-delay 0)
 '(compilation-scroll-output t)
 '(delete-selection-mode t)
 '(ecb-layout-name "left9")
 '(ecb-options-version "2.50")
 '(ecb-show-sources-in-directories-buffer (quote always))
 '(ecb-source-path (quote ("/usr/local/google/home/ahassani")))
 '(ecb-tip-of-the-day nil)
 '(enable-recursive-minibuffers t)
 '(fill-column 80)
 '(flycheck-global-modes nil)
 '(font-lock-maximum-decoration t)
 '(global-company-mode t)
 '(global-hl-line-mode t)
 '(inhibit-startup-screen t)
 '(ivy-mode t)
 '(ivy-use-virtual-buffers t)
 '(jedi:complete-on-dot t)
 '(line-number-mode t)
 '(make-backup-files t)
 '(mouse-1-click-follows-link (quote double))
 '(mouse-wheel-mode t)
 '(mouse-wheel-progressive-speed nil)
 '(package-selected-packages
   (quote
    (async ghub git-commit graphql magit-popup treepy with-editor gerrit-download magit magit-gerrit wc-mode smooth-scrolling yasnippet-snippets counsel ivy swiper concurrent ctable epc jedi jedi-core popup python-environment company-jedi dash deferred epl f google google-c-style let-alist parent-mode pkg-info request request-deferred rtags s yasnippet ycmd company company-c-headers company-rtags highlight-numbers hl-spotlight ecb company-ycmd flymd auto-complete)))
 '(scroll-conservatively 10000)
 '(scroll-step 1)
 '(send-mail-function (quote mailclient-send-it))
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(smooth-scroll-margin 1)
 '(xterm-mouse-mode t)
 '(yas-global-mode t))
