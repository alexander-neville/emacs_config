; interface settings
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)
;; (defun display-startup-echo-area-message ()
;; (message ""))
(defun display-startup-echo-area-message () )
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq use-dialog-box nil)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)
(add-to-list 'load-path (concat user-emacs-directory "elisp/"))
;; (require 'splash-screen)

; font and theme
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "ETBookOT" :height 110))))
 '(default ((t ( :family "Iosevka Nerd Font" :height 90))))
 '(fixed-pitch ((t ( :family "Iosevka Nerd Font" :height 90)))))

;; (setq modus-themes-mode-line '(accented))
;; (setq modus-themes-region '(accented bg-only))
;; (setq modus-themes-completions '(opinionated))
;; (setq modus-themes-bold-constructs t)
;; (setq modus-themes-italic-constructs t)
;; (setq modus-themes-paren-match '(bold underline))
;; (setq modus-themes-syntax '(faint))
;; (setq modus-themes-subtle-line-numbers t)
;; (setq modus-themes-org-blocks 'gray-background)
;; (setq modus-themes-scale-headings t)
;; (setq modus-themes-headings '(
;; 			      (1. (rainbow bold 1.5))
;; 			      (2. (rainbow bold 1.4))
;; 			      (3. (rainbow bold 1.3))
;; 			      (4. (rainbow bold 1.2))
;; 			      (5. (rainbow bold 1.1))
;; 			      (t. (rainbow 1.1))))
;; (load-theme 'modus-operandi t)

; behaviour settings
(setq scroll-conservatively 1000) ; a big number
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq custom-file (locate-user-emacs-file "custom_vars.el"))
(load custom-file 'noerror 'nomessage)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(setq x-select-enable-clipboard nil)


; package repository initialisation
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

; install use-package to manage other plugins
(unless (package-installed-p 'use-package)
   (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

; plugins

(use-package base16-theme
  :ensure t
  :demand
  :init
  (setq base16-theme-distinct-fringe-background nil)
  (setq base16-theme-highlight-mode-line 'contrast)
  (setq base16-theme-256-color-source 'colors))
  ; :config
  ; (load-theme 'base16-gruvbox-material-dark-hard t)
  ;; Set the cursor color based on the evil state
  ; (defvar myconfig/base16-colors base16-gruvbox-material-dark-hard-theme-colors)
  ; (setq evil-emacs-state-cursor   `(,(plist-get myconfig/base16-colors :base0D) box)
  ;       evil-insert-state-cursor  `(,(plist-get myconfig/base16-colors :base0D) bar)
  ;       evil-motion-state-cursor  `(,(plist-get myconfig/base16-colors :base0E) box)
  ;       evil-normal-state-cursor  `(,(plist-get myconfig/base16-colors :base0B) box)
  ;       evil-replace-state-cursor `(,(plist-get myconfig/base16-colors :base08) bar)
  ;       evil-visual-state-cursor  `(,(plist-get myconfig/base16-colors :base09) box)))

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
;  (doom-themes-org-config)
;  (load-theme 'doom-one t))

(use-package spacemacs-common
    :ensure spacemacs-theme
    :config (load-theme 'spacemacs-light t))

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 50))

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-set-footer nil)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "www.gnu.org")
  ;; (setq dashboard-startup-banner 'official)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-items '())
  :config
  (dashboard-setup-startup-hook))

; keybindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))


(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; (evil-define-key* 'motion 'global
  ;;      ";" #'evil-ex
  ;;      ":" #'evil-repeat-find-char) 
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer myconfig/leader-keys
      :prefix "SPC"
      :global-prefix "C-c"))

(myconfig/leader-keys 'normal 'override
  "x" 'counsel-M-x
  "bb" 'counsel-switch-buffer
  "ff" 'counsel-find-file
  "d" 'dired
  "p" 'clipboard-yank
  "y" 'clipboard-kill-ring-save
  "e" 'eval-buffer
  "sb" 'counsel-switch-buffer
  "ss" 'swiper
  "st" 'counsel-load-theme
  "/" 'swiper)


(defun myconfig/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq org-hide-emphasis-markers t
	org-list-allow-alphabetical t
	org-catch-invisible-edits 'smart
	org-export-with-sub-superscripts '{}
        evil-auto-indent nil))

(require 'org-indent)
(use-package org
  :hook (org-mode . myconfig/org-mode-setup))

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                          (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(dolist (face '((org-level-1 . 1.3)
                (org-level-2 . 1.2)
                (org-level-3 . 1.1)
                (org-level-4 . 1.1)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "ETBookOT" :weight 'bold :height (cdr face)))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("●" "○" "●" "○" "●" "○" "●")))

(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil))
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.

(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-block-begin-line nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-block-end-line nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(set-face-attribute 'org-document-info-keyword nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

(use-package visual-fill-column
  :config
  (setq-default visual-fill-column-center-text t)
  (setq-default visual-fill-column-width 100))


(add-hook 'visual-line-mode-hook #'visual-fill-column-mode)
(put 'dired-find-alternate-file 'disabled nil)
