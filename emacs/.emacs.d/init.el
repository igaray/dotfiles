;; Prevent the cursor from blinking
(blink-cursor-mode 0)
;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)

;; You need to set `inhibit-startup-echo-area-message' from the
;; customization interface:
;; M-x customize-variable RET inhibit-startup-echo-area-message RET
;; then enter your username
(setq inhibit-startup-echo-area-message "igaray")

; ;; MELPA
; (require 'package)
; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
; (when (< emacs-major-version 24) (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
; (package-initialize)

; ;; NEOTREE
; (add-to-list 'load-path "/some/path/neotree")
; (require 'neotree)
; (global-set-key [f8] 'neotree-toggle)
; (setq neo-smart-open t)
; (setq neo-theme (if (display-graphic-p) 'icons 'ascii))

; ;; THEMES
; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
; (custom-set-variables
;  ;; custom-set-variables was added by Custom.
;  ;; If you edit it by hand, you could mess it up, so be careful.
;  ;; Your init file should contain only one such instance.
;  ;; If there is more than one, they won't work right.
;  '(package-selected-packages
;    (quote
;     (dirtree neotree quasi-monochrome-theme zenburn-theme))))
; (custom-set-faces
;  ;; custom-set-faces was added by Custom.
;  ;; If you edit it by hand, you could mess it up, so be careful.
;  ;; Your init file should contain only one such instance.
;  ;; If there is more than one, they won't work right.
;  )
; (load-theme 'quasi-monochrome t)
