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
(add-to-list 'default-frame-alist `(font . "Iosevka-17"))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)

(require 'mouse-drag)

;; Bind Left Mouse Button (1) to drag the buffer
(global-set-key [down-mouse-3] 'mouse-drag-drag)

;; Important: Disable "copy on drag" so it doesn't mess with text selection
(setq mouse-drag-copy-region nil)

;; Enable pixel-level smoothness (Emacs 29+)
(pixel-scroll-precision-mode 1)


(with-eval-after-load 'info
  (define-key Info-mode-map [mouse-8] 'Info-history-back)
  (define-key Info-mode-map [mouse-9] 'Info-history-forward))



;; Esensial modes
(winner-mode 1)
(global-visual-line-mode 1)
(blink-cursor-mode 0)



(rc/require-theme 'gruber-darker)
;; (rc/require-theme 'zenburn)
(eval-after-load 'zenburn
(set-face-attribute 'line-number nil :inherit 'default))

(rc/require 'xclip)
(xclip-mode 1)

;; This is the built-in mode that makes the mouse work in terminals
(xterm-mouse-mode 1)

;; Optional: Makes scrolling feel more natural
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)



;; Ido / Smex
; (rc/require 'smex 'ido-completing-read+)
; (ido-mode 1)
; (ido-everywhere 1)
; (ido-ubiquitous-mode 1)

; (global-set-key (kbd "M-x") 'smex)
; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;
;
;
; ;; vertico orderless consult
;
; (rc/require 'vertico)
; (rc/require 'orderless)
; (rc/require 'consult)
;
; (require 'vertico-multiform)
; (require 'vertico-flat)
;
; (vertico-mode 1)
; (vertico-multiform-mode 1)
; (savehist-mode 1) ;; Provides Smex-style sorting logic
; (setq vertico-flat-max-lines 3) ;; allows the mini-buffer list to wrap shows more commands as needed I guess
;
; (setq consult-preview-key 'any) ;; by default it moves as I move but keep it to garentee it moves
; ; (consult-customize consult-buffer :preview-key nil) ;; Buffers: No lag. It won't try to render ERC or heavy files while you scroll.
;
;
; ;; 2. The "Smex" logic (Sort by history/frequency)
; (setq vertico-sort-function #'vertico-sort-history-alpha)
;
; (setq vertico-multiform-commands
;       '((execute-extended-command flat) ; M-x
;         ; (switch-to-buffer flat)          ; C-x b I don't need this with vertico lol
;         (find-file flat)                 ; C-x C-f
;         (dired flat)                     ; C-x d
;         (read-file-name flat)))          ; General file prompts
;
; ; (setq completion-styles '(orderless basic))
; (setq completion-styles '(orderless flex basic)) ;; makes it feel like ido more
;
; ;; make it like fzf-lua.resume to an extent mostly what I need
; (require 'vertico-repeat)
; (add-hook 'minibuffer-setup-hook #'vertico-repeat-save)
;
; ;; This is like "fzf-lua.resume"
; (global-set-key (kbd "C-c '") #'vertico-repeat)
;
; ;; Keybinds (My fzf-lua style)
; (global-set-key (kbd "C-c /")   'consult-line)      ;; blines
; (global-set-key (kbd "C-c g /") 'consult-ripgrep)   ;; grep_project
;
; ;; change default buffer switch to consult-buffer because it's just better gives fzf-lua-buffer feel
; ; (global-set-key [remap switch-to-buffer] 'consult-buffer)
; ; (add-to-list 'vertico-multiform-commands '(consult-buffer flat)) ;; fixes the look
; ;; this died because it lags in erc lol.... it was nice to try but I don't like it lol
;
; (ido-mode 'buffer)


; ;; --- Vertico, Orderless, Consult (Modern Ido/Smex) ---
; (rc/require 'vertico)
; (rc/require 'orderless)
; (rc/require 'consult)
; (require 'vertico-multiform)
; (require 'vertico-flat)
; (require 'vertico-repeat)
;
; (vertico-mode 1)
; (vertico-multiform-mode 1)
; (savehist-mode 1)
;
; (setq vertico-flat-max-lines 3)
; (setq vertico-cycle t)
; (setq vertico-sort-function #'vertico-sort-history-alpha) ; Smex-style sorting
; (setq consult-preview-key 'any)                           ; Live movement
; (setq completion-styles '(orderless flex basic))          ; Ido-style matching
;
; (setq vertico-multiform-commands
;       '((execute-extended-command flat)
;         (consult-buffer flat)
;         (find-file flat)
;         (dired flat)
;         (read-file-name flat)))
;
; ;; Keybinds
; (global-set-key [remap switch-to-buffer] 'consult-buffer)
; (global-set-key (kbd "C-c /")   'consult-line)
; (global-set-key (kbd "C-c g /") 'consult-ripgrep)
; (global-set-key (kbd "C-c '")   'vertico-repeat)
; (add-hook 'minibuffer-setup-hook #'vertico-repeat-save)


;; --- 1. SMEX & IDO (For M-x and Buffers) ---
(rc/require 'smex)
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)

;; Bind M-x to Smex (This is the "Ido feel" for commands)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Force Ido for buffers (prevents the ERC lag you had)
(setq ido-mode 'buffer)



;; --- 2. VERTICO & CONSULT (For Files and Searching) ---
(rc/require 'vertico)
(rc/require 'orderless)
(rc/require 'consult)
(require 'vertico-multiform)
(require 'vertico-flat)
(require 'vertico-repeat)

(vertico-mode 1)
(vertico-multiform-mode 1)
(savehist-mode 1)

(setq vertico-cycle t)                          ;; Allows you to go from last to first item
(setq vertico-flat-max-lines 3)                 ;; Keeps the horizontal view clean
(setq consult-preview-key 'any)                 ;; Makes ripgrep/line search preview instantly

;; This makes Vertico use "Orderless" (type words in any order)
(setq completion-styles '(orderless flex basic))

;; This makes "Find File" look horizontal (like Ido)
(setq vertico-multiform-commands
      '((find-file flat)
        (dired flat)
        (read-file-name flat)))

;; Keybinds for the "fzf-lua" feel
(global-set-key (kbd "C-c /")   'consult-line)      ;; Search inside buffer
(global-set-key (kbd "C-c g /") 'consult-ripgrep)   ;; Search in project
(global-set-key (kbd "C-c '")   'vertico-repeat)    ;; Resume last search
(add-hook 'minibuffer-setup-hook #'vertico-repeat-save)

;; Ensure Vertico doesn't interfere with Ido/Smex
(setq vertico-multiform-map (make-sparse-keymap))
(add-to-list 'vertico-multiform-commands '(execute-extended-command disabled))






;; quick-fix list that is good similar to consult compilation or grep buffer but more universal. similar to nvim quick-fix list
(rc/require 'embark)
(define-key vertico-map (kbd "C-q") #'embark-export)

;; --- Harpoon (Manual Slot Management) ---
(rc/require 'harpoon)

;; 1. The Menu
(global-set-key (kbd "C-c h e") 'harpoon-toggle-quick-menu)

;; 2. Add / Prepend
(global-set-key (kbd "C-c h a") 'harpoon-add-file)

(defun harpoon-prepend ()
  "Add current file to the first slot."
  (interactive)
  (harpoon-add-file)
  (save-window-excursion
    (with-current-buffer (harpoon--toggle-quick-menu)
      (goto-char (point-max))
      (forward-line -1)
      (let ((line (delete-and-extract-region (line-beginning-position) (line-end-position))))
        (goto-char (point-min))
        (insert line "\n"))
      (save-buffer)
      (kill-buffer))))

(global-set-key (kbd "C-c h A") 'harpoon-prepend)

;; 3. Selection (1-9)
(global-set-key (kbd "C-c h 1") 'harpoon-go-to-1)
(global-set-key (kbd "C-c h 2") 'harpoon-go-to-2)
(global-set-key (kbd "C-c h 3") 'harpoon-go-to-3)
(global-set-key (kbd "C-c h 4") 'harpoon-go-to-4)
(global-set-key (kbd "C-c h 5") 'harpoon-go-to-5)
(global-set-key (kbd "C-c h 6") 'harpoon-go-to-6)
(global-set-key (kbd "C-c h 7") 'harpoon-go-to-7)
(global-set-key (kbd "C-c h 8") 'harpoon-go-to-8)
(global-set-key (kbd "C-c h 9") 'harpoon-go-to-9)

;; 4. Replace Logic
(global-set-key (kbd "C-c h !") (lambda () (interactive) (harpoon-delete-1) (harpoon-prepend)))
(global-set-key (kbd "C-c h @") (lambda () (interactive) (harpoon-delete-2) (harpoon-add-file)))
(global-set-key (kbd "C-c h #") (lambda () (interactive) (harpoon-delete-3) (harpoon-add-file)))
(global-set-key (kbd "C-c h $") (lambda () (interactive) (harpoon-delete-4) (harpoon-add-file)))







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
(global-set-key (kbd "C-x <down>") 'switch-to-next-buffer)
(global-set-key (kbd "C-x <end>") 'eval-last-sexp)

(global-set-key (kbd "C-M-<right>") 'forward-sexp)
(global-set-key (kbd "C-x 4 <right>") 'ido-find-file-other-window)


(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-M-<left>") 'backward-sexp)

(defun rc/comment-line-stay ()
  "Comment line, keep cursor."
  (interactive)
  (save-excursion
    (comment-line 1)))

(global-set-key (kbd "C-;") 'rc/comment-line-stay)


;; --- changing the default C-x C-b to be using the M-x ibuffer because it's nicer than the default one.
(global-set-key [remap list-buffers] 'ibuffer)







;; --- ERC AUTOJOIN FORCED FIX (v19 - SASL + no shadow bug) ---
(require 'erc)
(require 'erc-sasl)
(require 'auth-source)

;; --- 1. SPELLING FIX ---
(setq ispell-program-name "hunspell")
(setq ispell-dictionary "en_US")
(setq ispell-hunspell-dict-alist-pos 1)


(defun my-erc-hook-spelling ()
  "Enable flyspell safely in ERC buffers."
  (require 'flyspell)
  (ignore-errors
    (setq-local flyspell-generic-check-word-predicate 'erc-check-ispell-without-commands)
    (flyspell-mode 1))
    (text-scale-set -1))


(add-hook 'erc-mode-hook 'my-erc-hook-spelling)

;; --- 2. M-x ERC DEFAULTS ---
(setq erc-nick "dex3rd")
(setq erc-user-full-name "dex3rd")
(setq erc-server "irc.libera.chat")
(setq erc-port 6697)
(setq erc-prompt-for-password nil)

;; --- 3. MANUAL COMMANDS (renamed — erc-login is core fn, don't shadow) ---
(defun erc-identify ()
  "Manual command to identify if SASL didn't fire (DC/timeout)."
  (interactive)
  (let* ((secret (plist-get (car (auth-source-search :host "irc.libera.chat" :user "dex3rd")) :secret))
         (password (if (functionp secret) (funcall secret) secret)))
    (if password
        (progn
          (erc-message "PRIVMSG" (format "NickServ IDENTIFY %s" password))
          (message "ERC: Sent manual IDENTIFY."))
      (message "ERC Error: No password found in .authinfo"))))

;; --- 8. TOGGLE CHANNEL-INFO SPAM (numerics only, JOIN/PART/etc stay hidden) ---
(defvar my-erc-info-codes '("324" "328" "329" "332" "333" "353" "366")
  "Numeric channel-info codes toggled by `erc-toggle-spam'.")
(defvar my-erc-info-hidden t
  "State: t = info codes hidden, nil = shown.")
(defun erc-toggle-spam ()
  "Toggle visibility of channel-info numerics (topic/url/names/etc).
JOIN/PART/QUIT/NICK/MODE/NOTICE stay hidden always."
  (interactive)
  (if my-erc-info-hidden
      (progn
        (setq erc-hide-list (cl-set-difference erc-hide-list my-erc-info-codes :test #'string=))
        (setq my-erc-info-hidden nil)
        (message "ERC: channel info UNHIDDEN."))
    (progn
      (setq erc-hide-list (append erc-hide-list my-erc-info-codes))
      (setq my-erc-info-hidden t)
      (message "ERC: channel info HIDDEN."))))



(defun erc-ghost ()
  "Kill stuck dex3rd session, reclaim nick, identify."
  (interactive)
  (let* ((secret (plist-get (car (auth-source-search :host "irc.libera.chat" :user "dex3rd")) :secret))
         (password (if (functionp secret) (funcall secret) secret)))
    (if password
        (progn
          (erc-message "PRIVMSG" (format "NickServ GHOST dex3rd %s" password))
          (run-at-time "2 sec" nil
                       (lambda ()
                         (erc-cmd-NICK "dex3rd")
                         (erc-identify)))
          (message "ERC: Ghosting old session..."))
      (message "ERC Error: No password found in .authinfo"))))

;; --- 4. SASL (auto-auth on connect, no "Not Registered" error) ---
(setq erc-sasl-mechanism 'plain)
(setq erc-sasl-user "dex3rd")
;; password pulled from auth-source automatically by erc-sasl

;; --- 5. AUTOJOIN & SPAM ---
(setq-default erc-hide-list '("JOIN" "PART" "QUIT" "NICK" "MODE" "NOTICE"
                              "324" "328" "329" "332" "333" "353" "366"))
(setq erc-autojoin-on-identify 'all)
(setq erc-autojoin-channels-alist
      '(("Libera.Chat" "##programming" "#bash" "#emacs" "#kali" "#linux"
         "#hackers" "#c" "#c++" "#ai" "#c++-general"
         "#c++-basic" "#rust" "#lua" "#go-nuts" "#odin" "#ctf"
         "#picoctf" "#networking" "#python")))

;; --- 6. MODULES ---
(setq erc-modules '(netsplit fill button match track completion
                    readonly networks ring autojoin services
                    bufbar stamp sasl))
(erc-update-modules)

;; --- 7. UI & TIMESTAMPS ---
(setq erc-timestamp-format "[%H:%M] ")
(setq erc-insert-timestamp-function 'erc-insert-timestamp-left)
(setq erc-header-line-format "%t")
(setq erc-bufbar-width 15)

;; for live preview
(with-eval-after-load 'man
  (define-key Man-mode-map (kbd "M-i") 'consult-imenu)) ;; <--- Changed 'imenu to 'consult-imenu

;; Keep the 'q' fix
(add-hook 'Man-mode-hook
          (lambda ()
            (local-set-key (kbd "q") 'save-buffers-kill-terminal)))

