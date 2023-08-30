;; ======================================================================
;;
;; 1. Make sure you read through the "~/.config/emacs/config_readme.org"
;;    before making any changes.
;;
;; 2. If you want to know more about Emacs-Lisp, go and have a look at
;;    "~/.config/emacs/lisp_readme.org".
;;
;; ======================================================================

;; ======================================================================
;; Base settings
;; ======================================================================
(org-babel-load-file (expand-file-name "~/.config/emacs/settings.org"))

;; ======================================================================
;; Package init and settings
;; ======================================================================
(org-babel-load-file (expand-file-name "~/.config/emacs/package.org"))

;; ======================================================================
;; Enable system clipboard
;; ======================================================================
(org-babel-load-file (expand-file-name "~/.config/emacs/xclip.org"))

;; ======================================================================
;; Command log
;; ======================================================================
(org-babel-load-file (expand-file-name "~/.config/emacs/command_log_mode.org"))

;; ======================================================================
;; Better help buffer
;; ======================================================================
(org-babel-load-file (expand-file-name "~/.config/emacs/helpful.org"))

;; ======================================================================
;; Edit/UX improve related
;; ======================================================================

;; Goyo-liked
(org-babel-load-file (expand-file-name "~/.config/emacs/olivetti.org"))

;; Display keybinding in group
(org-babel-load-file (expand-file-name "~/.config/emacs/which_key.org"))

;; Highlight indent
(org-babel-load-file (expand-file-name "~/.config/emacs/highlight-indent.org"))

;; Complection
;; (org-babel-load-file (expand-file-name "~/.config/emacs/ivy_rich.org"))
(org-babel-load-file (expand-file-name "~/.config/emacs/vertico.org"))

;; Vim motion
(org-babel-load-file (expand-file-name "~/.config/emacs/evil.org"))

;; Org mode stuff
(org-babel-load-file (expand-file-name "~/.config/emacs/org_mode.org"))


;; ======================================================================
;; Treesitter
;; ======================================================================
(org-babel-load-file (expand-file-name "~/.config/emacs/treesitter.org"))

;; ======================================================================
;; Treemacs
;; ======================================================================
(org-babel-load-file (expand-file-name "~/.config/emacs/treemacs.org"))

;; ======================================================================
;; LSP related
;; ======================================================================
;; (org-babel-load-file (expand-file-name "~/.config/emacs/lsp.org"))
(org-babel-load-file (expand-file-name "~/.config/emacs/eglot.org"))


;; ======================================================================
;; Keybindings
;; ======================================================================
(org-babel-load-file (expand-file-name "~/.config/emacs/keybindings.org"))

;; ======================================================================
;; Color theme
;; ======================================================================
(org-babel-load-file (expand-file-name "~/.config/emacs/color_theme.org"))


(set-face-attribute 'mode-line-active nil :background "systemGreenColor")
(set-face-attribute 'mode-line-inactive nil :background nil)

;; Function name
(set-face-attribute 'font-lock-function-name-face nil :foreground "#2AA198" :weight 'bold)
;; docstring
(set-face-attribute 'font-lock-doc-face nil :foreground "#96A7A9" :weight 'normal)
;; comment
(set-face-attribute 'font-lock-comment-delimiter-face nil :weight 'normal)
(set-face-attribute 'font-lock-comment-face nil :weight 'normal)
