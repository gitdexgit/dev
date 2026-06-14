;; -*- lexical-binding: t; -*-

(require 'package)
(package-initialize)

(setq custom-file "~/.emacs.custom.el")

;; Kill noise
(setq byte-compile-warnings '(not lexical))
(setq warning-minimum-level :error)
(setq native-comp-async-report-warnings-errors 'silent)
(add-to-list 'warning-suppress-types '(lexical-binding))
;;; so

(add-to-list 'load-path "~/.emacs.local/")

;; Change this line in your .emacs
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Load RC files
(load "~/.emacs.rc/rc.el")
(load "~/.emacs.rc/misc-rc.el")
(load "~/.emacs.rc/org-mode-rc.el")
(load "~/.emacs.rc/autocommit-rc.el")

;; UI
(add-to-list 'default-frame-alist `(font . "Iosevka-18"))
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)

(rc/require-theme 'gruber-darker)
;; (rc/require-theme 'zenburn)
(eval-after-load 'zenburn
(set-face-attribute 'line-number nil :inherit 'default))




;; Ido / Smex
(rc/require 'smex 'ido-completing-read+)
(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)









;; --- UI & Global Lines ---
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; --- Global Prefix: C-c is your command map ---
; (global-unset-key (kbd "C-c"))
; (define-prefix-command 'ctrl-c-map)
; (global-set-key (kbd "C-c") 'ctrl-c-map)


(setq vterm-keymap-exceptions '("C-c" "C-x" "C-u" "C-g" "M-x"))

;; --- Vterm Configuration ---
(require 'vterm)

(define-key vterm-mode-map (kbd "C-c") nil)
(define-key vterm-mode-map (kbd "C-c C-c")
  (lambda () (interactive) (vterm-send-key "c" nil nil t)))
(define-key vterm-mode-map (kbd "C-c C-g")
  (lambda () (interactive)
    (vterm-send-key "c" nil nil t)
    (sleep-for 0.05)
    (vterm-send-key "c" nil nil t)))
(define-key vterm-mode-map (kbd "C-\\") nil)
(define-key vterm-mode-map (kbd "C-\\ C-n") 'vterm-copy-mode)
(define-key vterm-mode-map (kbd "C-v") 'vterm-yank)
(define-key vterm-copy-mode-map (kbd "i") 'vterm-copy-mode)
(add-to-list 'vterm-eval-cmds
             '("vterm-clear-scrollback" (lambda () (vterm-clear-scrollback))))

;; --- Smart Buffer Name: Show nvim file info or directory ---
(defun my-vterm-get-display-name ()
  "Return a string to display in buffer name/mode-line.
Shows terminal title (e.g., nvim filename + line number) if present,
otherwise shows current directory."
  (let* ((title (when (boundp 'vterm--title) vterm--title))
         (pwd (vterm--get-pwd))
         (dir (when pwd (file-name-nondirectory (directory-file-name pwd)))))
    (cond
     ;; If title is set and meaningful (and not just the directory), use it
     ((and title (not (string-empty-p title))
           (or (not dir) (not (string-match (regexp-quote dir) title))))
      ;; Remove any remaining escape sequences (just in case)
      (let ((clean-title (replace-regexp-in-string "\033\\[[0-9;]*m" "" title)))
        ;; Limit length to keep buffer names readable
        (if (> (length clean-title) 50)
            (concat (substring clean-title 0 47) "...")
          clean-title)))
     (dir
      (format "vterm:%s" dir))
     (t
      "vterm"))))

(defun my-vterm-update-buffer-name ()
  "Update vterm buffer name and mode-line."
  (when (and (eq major-mode 'vterm-mode)
             (buffer-live-p (current-buffer)))
    (let ((display-name (my-vterm-get-display-name)))
      ;; Rename the buffer itself – this shows in tabs, buffer list, etc.
      (rename-buffer display-name t)
      ;; Also update the mode-line to show the same info (optional but consistent)
      (setq-local mode-line-buffer-identification
                  (list " " display-name)))))

(defun my-vterm-start-polling ()
  "Start polling for changes (directory or title) in vterm."
  (when (not vterm--term) (sit-for 0.1))
  (my-vterm-update-buffer-name)
  ;; Poll every 0.5 seconds – lightweight and catches title updates from nvim
  (run-with-timer 0.5 0.5 #'my-vterm-update-buffer-name))

(add-hook 'vterm-mode-hook #'my-vterm-start-polling)

;; Disable line numbers in vterm (cleaner look)
(add-hook 'vterm-mode-hook
          (lambda ()
            (display-line-numbers-mode -1)))

(message "Emacs config loaded – vterm smart buffer names enabled")






;;; Paredit
(rc/require 'paredit)

(defun rc/turn-on-paredit ()
  (interactive)
  (paredit-mode 1))

(add-hook 'emacs-lisp-mode-hook  'rc/turn-on-paredit)
(add-hook 'clojure-mode-hook     'rc/turn-on-paredit)
(add-hook 'lisp-mode-hook        'rc/turn-on-paredit)
(add-hook 'common-lisp-mode-hook 'rc/turn-on-paredit)
(add-hook 'scheme-mode-hook      'rc/turn-on-paredit)
(add-hook 'racket-mode-hook      'rc/turn-on-paredit)

(with-eval-after-load 'paredit
  ;; 1. Move Slurp/Barf to Ctrl+Shift+Arrows
  (define-key paredit-mode-map (kbd "C-S-<right>") 'paredit-forward-slurp-sexp)
  (define-key paredit-mode-map (kbd "C-S-<left>")  'paredit-forward-barf-sexp)

  ;; 2. Unbind the original C-left/right so they fall back to M-b/M-f
  (define-key paredit-mode-map (kbd "C-<right>") nil)
  (define-key paredit-mode-map (kbd "C-<left>") nil))

;;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-j")
                            (quote eval-print-last-sexp))))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))


;;; uxntal-mode

(rc/require 'uxntal-mode)


;;; Haskell mode
(rc/require 'haskell-mode)

(setq haskell-process-type 'cabal-new-repl)
(setq haskell-process-log t)

(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-doc-mode)

(require 'basm-mode)

(require 'fasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode))

(require 'porth-mode)

(require 'noq-mode)

(require 'jai-mode)

(require 'umka-mode)

(require 'c3-mode)


;;; Whitespace mode
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(add-hook 'tuareg-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c++-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'simpc-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode 'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'lua-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'rust-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'scala-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'haskell-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'erlang-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'asm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'fasm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'go-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'nim-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'yaml-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'porth-mode-hook 'rc/set-up-whitespace-handling)








;; C-mode / Treesitter
(require 'simpc-mode)

(defun my-c-mode-huge-file-check ()
  (when (> (buffer-size) 1000000)
    (simpc-mode)))

(add-hook 'c-ts-mode-hook #'my-c-mode-huge-file-check)

(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

(setq major-mode-remap-alist '((c-mode . c-ts-mode)))

;; Line numbers
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;;; magit
;; magit requres this lib, but it is not installed automatically on
;; Windows.
(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)



;; Multiple cursors
(rc/require 'multiple-cursors)


(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-|")        'mc/skip-to-next-like-this)
;; (global-set-key (kbd "M-\"") 'mc/skip-to-previous-like-this)
(global-set-key (kbd "C-\"") 'mc/skip-to-previous-like-this)
;; For some reason this stupid key gives me [mc] repeat complex key (y/n)
;; (global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)



;; Dired
(require 'dired-x)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

;; Helm-git-grep <-- This is removed or doesn't exit in melpa anymore
;; Now it's built into emacs
;;
;; LLM Could lie so test this
;;[LLM]: Helm vs Built-in: You commented out helm-git-grep saying it is built-in. It is not.
;; Emacs has project-find-regexp, but helm-git-grep is a specific package. If your keys fail, you need that package.
; (rc/require 'helm 'helm-git-grep 'helm-ls-git)


(setq helm-ff-transformer-show-only-basename nil)

(global-set-key (kbd "C-c h t")   'helm-cmd-t)
(global-set-key (kbd "C-c h g g") 'helm-grep-do-git-grep) ; Built-in
(global-set-key (kbd "C-c h g l") 'helm-ls-git-ls)
(global-set-key (kbd "C-c h f")   'helm-find)
(global-set-key (kbd "C-c h a")   'helm-org-agenda-files-headings)
(global-set-key (kbd "C-c h r")   'helm-recentf)


;; Yasnippet
(rc/require 'yasnippet)
(setq yas/triggers-in-field nil)
(setq yas-snippet-dirs '("~/.emacs.snippets/"))
(yas-global-mode 1)

;; Word-wrap
(defun rc/enable-word-wrap ()
  (interactive)
  (toggle-word-wrap 1))

(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;;; nxml
(add-to-list 'auto-mode-alist '("\\.html\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.ant\\'" . nxml-mode))

;;; tramp
;;; http://stackoverflow.com/questions/13794433/how-to-disable-autosave-for-tramp-buffers-in-emacs
(setq tramp-auto-save-directory "/tmp")


;;; powershell
(rc/require 'powershell)
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode))
(add-to-list 'auto-mode-alist '("\\.psm1\\'" . powershell-mode))

;;; eldoc mode
(defun rc/turn-on-eldoc-mode ()
  (interactive)
  (eldoc-mode 1))

(add-hook 'emacs-lisp-mode-hook 'rc/turn-on-eldoc-mode)

;;; Company
(rc/require 'company)
(require 'company)

(global-company-mode)

(add-hook 'tuareg-mode-hook
          (lambda ()
            (interactive)
            (company-mode 0)))

;;; Typescript
(rc/require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.mts\\'" . typescript-mode))

;;; Tide
(rc/require 'tide)

(defun rc/turn-on-tide-and-flycheck ()  ;Flycheck is a dependency of tide
  (interactive)
  (tide-setup)
  (flycheck-mode 1))

(add-hook 'typescript-mode-hook 'rc/turn-on-tide-and-flycheck)


;;; Proof general
(rc/require 'proof-general)
(add-hook 'coq-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-q C-n")
                            (quote proof-assert-until-point-interactive))))


;;; LaTeX mode
(add-hook 'tex-mode-hook
          (lambda ()
            (interactive)
            (add-to-list 'tex-verbatim-environments "code")))

(setq font-latex-fontify-sectioning 'color)

;;; Move Text
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; Packages that don't require configuration
(rc/require
 'scala-mode
 'd-mode
 'yaml-mode
 'glsl-mode
 'tuareg
 'lua-mode
 'less-css-mode
 'graphviz-dot-mode
 'clojure-mode
 'cmake-mode
 'rust-mode
 'csharp-mode
 'nim-mode
 'jinja2-mode
 'markdown-mode
 'purescript-mode
 'nix-mode
 'dockerfile-mode
 'toml-mode
 'nginx-mode
 'kotlin-mode
 'go-mode
 'php-mode
 'racket-mode
 'qml-mode
 'ag
 'elpy
 'typescript-mode
 'rfc-mode
 'sml-mode
 )


(defun astyle-buffer (&optional justify)
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr"
     nil
     t)
    (goto-line saved-line-number)))


(add-hook 'simpc-mode-hook
          (lambda ()
            (interactive)
            (setq-local fill-paragraph-function 'astyle-buffer)))

(add-hook 'c-ts-mode-hook  ; New hook for C/Treesitter mode
          (lambda ()
            (interactive)
            (setq-local fill-paragraph-function 'astyle-buffer)))


(require 'compile)

;; pascalik.pas(24,44) Error: Can't evaluate constant expression

compilation-error-regexp-alist-alist

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))


;; Load custom settings
(load-file custom-file)

;; Global keys (at end to override everything)
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "C-x <right>") 'find-file)
(global-set-key (kbd "C-x <end>") 'eval-last-sexp)

(global-set-key (kbd "C-M-<right>") 'forward-sexp)
(global-set-key (kbd "C-M-<left>") 'backward-sexp)

(defun rc/comment-line-stay ()
  "Comment line, keep cursor."
  (interactive)
  (save-excursion
    (comment-line 1)))

(global-set-key (kbd "C-;") 'rc/comment-line-stay)
