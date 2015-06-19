;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

;; Theme
(load-theme 'wombat t)

;; Stuff
;; (setq inhibit-startup-message t)

;; Evil-leader
;; (global-evil-leader-mode)

;; Evil
;; (require 'evil)
;; (evil-mode 1)

;; More Evil-leader
;; (evil-leader/set-leader ",")
;; (evil-leader/set-key "c" 'evilnc-comment-or-uncomment-lines)
;; (evil-leader/set-key "C" 'evilnc-quick-comment-or-uncomment-to-the-line)
;; (evil-leader/set-key "w" 'cleanup-whitespace)
;; (evil-leader/set-key "k" 'c-set-style "linux-tabs-only")

;; Kernel coding style for emacs
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    ;; Add kernel style
	    (c-add-style
	     "linux-tabs-only"
	     '("linux" (c-offsets-alist
			(arglist-cont-nonempty
			 c-lineup-gcc-asm-reg
			 c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
	  (lambda ()
	    (let ((filename (buffer-file-name)))
	      Enable kernel mode for the appropriate files
	      (when (and filename
			 (string-match (expand-file-name "~/src/linux-trees")
				       filename))
		(setq indent-tabs-mode t)
		(setq show-trailing-whitespace t)
		(c-set-style "linux-tabs-only")))))

(setq c-default-style "linux-tabs-only")

;; Linum
(require 'linum-relative)
(global-linum-mode 1)

;; No more Menu Bar
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Font config
(set-face-attribute 'default nil :height 90)

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.5.0/dict")
(ac-config-default)
;; (setq ac-auto-show-menu 0.2)
(setq ac-source-yasnippet nil)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Declutter
(custom-set-variables
 '(auto-save-file-name-transforms (quote ((".*" "~/.cache/emacs/autosave/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.cache/emacs/backup/")))))

(make-directory "~/.cache/emacs/autosave/" t)

;; Whitespace
(require 'whitespace)
(global-whitespace-mode 1)
(setq whitespace-style (list 'face 'trailing 'tabs 'lines-tail 'tab-mark))

;; auto-complete-c-headers
(add-hook 'c-mode-hook '(lambda ()
			  (require 'auto-complete-c-headers)
			  (add-to-list 'ac-sources 'ac-source-c-headers)))

;; Lisp
(setq inferior-lisp-program "/usr/bin/clisp")
