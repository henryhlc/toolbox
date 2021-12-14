;; Minimalize default UI
(setq inhibit-startup-message t)

(menu-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(when (display-graphic-p)
  (scroll-bar-mode 0))

(load-theme 'deeper-blue)
(set-face-attribute 'default nil :height 160)

;; Package managements
(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Shell interaction
(add-to-list 'exec-path "/usr/local/bin")

;; Search and completion
(use-package ivy
  :bind (("C-s" . swiper))
  :config (ivy-mode 1))
; note about M-o to take action on list item

(use-package counsel
  :config (counsel-mode 1))

;; Context info
(global-display-line-numbers-mode t)
(column-number-mode t)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode t)
  :config (setq which-key-idle-delay 0.8))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1)
  (setq ivy-rich-parse-remote-buffer nil)

;; Help page
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Key-bindings
(use-package general)
(use-package hydra)

(use-package evil
  :after general hydra
  :config
  (evil-mode 1)
  :init
  (setq evil-want-C-u-scroll t)
  (general-define-key
   :keymaps 'evil-normal-state-map
   "<return>" 'evil-insert)
  (general-define-key
   :keymaps 'evil-normal-state-map
   :prefix "h"
   "v" 'counsel-describe-variable
   "f" 'counsel-describe-function
   "k" 'helpful-key)
  (defhydra hydra-evil-window (global-map "C-c w")
    "evil windows"
    (">" evil-window-increase-width "increase width")
    ("<" evil-window-decrease-width "decrease width")
    ("=" evil-balance-windows "balance")
    ("+" evil-window-increase-height "increase height")
    ("-" evil-window-decrease-height "decrease height")
    ("<left>" evil-window-left "move to left")
    ("<right>" evil-window-right "move to right")
    ("<up>" evil-window-up "move to up")
    ("<down>" evil-window-down "move to down")
  )
)
;; evil-collection?

(use-package magit
  :after general
  :init (general-define-key "C-c g" 'magit-status)
)

;; Org-roam
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Dropbox/content/orgroam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode)
  :init
  (setq org-roam-v2-ack t)
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit hydra general evil helpful ivy-rich org-roam which-key rainbow-delimiters counsel use-package ivy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
