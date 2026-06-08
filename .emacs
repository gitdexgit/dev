;; -*- lexical-binding: t; -*-

(setq custom-file "~/.emacs.custom.el")
 
(add-to-list 'warning-suppress-types '(lexical-binding))

( add-to-list 'load-path "~/.emacs.d/")
(require 'simpc-mode)
 
(defun my-c-mode-huge-file-check ()
  (when (> (buffer-size) 1000000)
    (simpc-mode)
    (display-line-numbers-mode -1)))

(add-hook 'c-ts-mode-hook #'my-c-mode-huge-file-check)
;; Kill lexical noise
(setq byte-compile-warnings '(not lexical))
(setq warning-minimum-level :error)
(setq native-comp-async-report-warnings-errors 'silent)



(setq major-mode-remap-alist '((c-mode . c-ts-mode)))

(add-to-list 'default-frame-alist `(font . "Iosevka-18"))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(global-display-line-numbers-mode)

;; let's try to make Capslock universal thingy match
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "C-x <right>") 'find-file)

(load-file custom-file)
