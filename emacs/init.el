;;
;; For MacOS
;;
(if (string-equal "darwin" system-type)
        (progn
                (setq mac-command-modifier 'meta)
                (message ">>> MacOS, set 'super' key as 'meta' key." system-type)
        )
)

 ;;
 ;; For Linux
 ;;
 (if (string-equal "gnu/linux" system-type)
         (progn
                 (setq x-super-keysym 'meta)
                 (message ">>> Linux, set 'super' key as 'meta' key." system-type)
         )
 )

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t
      use-dialog-box nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(setq make-backup-files nil
      auto-save-default nil)

;; Enable it
;;(save-place-mode 1)

;; Disable it
(setq save-place-mode nil)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq column-number-mode t)

;; (when window-system (global-hl-line-mode t))
(global-hl-line-mode t)

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; (when window-system (global-hl-line-mode t))
(setq dired-listing-switches "-lhta")

(setq help-window-select t)

(setq display-buffer-alist
      '(
         ("\\*helpful" 
             (display-buffer-reuse-window display-buffer-in-side-window)
             (side . right)
             (window-width . 0.5)
         )
       )
)

(setq tab-width 4)

(setq org-src-window-setup 'current-window)
;; (setq org-src-window-setup 'split-window-rIght)

(electric-pair-mode)

(setq native-comp-async-report-warnings-errors nil)

(setq org-image-actual-width nil)
(setq org-startup-with-inline-images t)

;; Just for debugging purpose:
;;
;; When developing your dynamically Loaded Module for emacs, you can
;; add your library output folder to the 'load-path' for testing.
;;
;; After adding your testing library folder to 'load-path', then you
;; can load it by running:
;; 
;; (require 'YOUR_LIB_FILENAME_HERE)
;; (CALL_YOUR_MODULE_FUNCTION)
;; ...
;;
(push (expand-file-name "~/zig/emacs-module-in-zig/zig-out/lib") load-path)

(push "~/.config/emacs/lib" load-path)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives
;;	     '(
;;	       ("melpa" . "https://melpa.org/packages/")
;;	       ("org" . "https://orgmode.org/elpa/")
;;	       ("elpa" . "https://elpa.gun.org/packages/")
;;	       ))

(unless package-archives
        (package-refresh-contents))
;;(package-refresh-contents)
(package-initialize)

;;
;; (unless condition nil
;;         statement-to-execute)
;;
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

;; Auto install all missing packages when using =(use-packge)`
;; It's equal to use `:ensure t` in `(use-package)`
(setq use-package-always-ensure t)

(use-package xclip
   :config
       (xclip-mode 1)
)

(use-package command-log-mode
    :defer t
    :config
        (global-command-log-mode 1)
)

(use-package helpful
    :defer t
    ;; ;;
    ;; ;; 'counsel' related configuration
    ;; ;;
    ;; :init
    ;;     (setq counsel-describe-function-function #'helpful-callable)
    ;;     (setq counsel-describe-variable-function #'helpful-variable)
    ;;     :bind
    ;;     ([remap describe-function] . counsel-describe-function)
    ;;     ([remap describe-variable] . counsel-describe-variable)
    ;;     ([remap describe-command] . helpful-command)
    ;;     ([remap describe-key] . helpful-key)
)

(use-package olivetti
  :defer t
  :init
      (setq olivetti-body-width 0.6)
)

(use-package which-key
  :defer t
  :init
      (which-key-setup-side-window-right-bottom)
      (setq which-key-idle-delay 0.2)
      ;; (setq which-key-sort-order 'which-key-local-then-key-order)
      (setq which-key-sort-order 'which-key-prefix-then-key-order)
      (setq which-key-prefix-prefix "> " )
  :config
      (which-key-mode)
)

(use-package highlight-indent-guides
  :defer t
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
      ;;(setq highlight-indent-guides-method 'character)
      (setq highlight-indent-guides-method 'column)
      (setq highlight-indent-guides-character ?\|)
      ;;(setq highlight-indent-guides-responsive 'top)
)

(use-package vertico
  :init
     (vertico-mode)
     (vertico-multiform-mode)

     ;;
     ;; Configure Vertico modes per command or completion category.
     ;;
     ;; 'buffer' means 'vertico-buffer-mode' to display vertico in a buffer instead of minibuffer
     ;;
     ;; For more details, watch this video: https://www.youtube.com/watch?v=hPwDbx--Waw
     ;;
     (setq vertico-multiform-commands
         '((consult-imenu buffer)
           (consult-ripgrep buffer)
          )
     )

     ;; How many lines needs to show in minibuffer before hit the top or bottom
     (setq vertico-scroll-margin 3)

     ;; Show more lines in minibuffer
     (setq vertico-count 20)

     ;; Grow and shrink the Vertico minibuffer
     ;; (setq vertico-resize t)

     ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
     (setq vertico-cycle t)

  :config

     ;;
     ;; Auto tidy up the directory prompt when changing to '~' or '/' directory
     ;; This works with 'file-name-shadow-mode' enabled. When you're in the sub directory, and you
     ;; type '~' or '/' path in 'find-file' or 'dired', then 'vertico' clear the old path and keep
     ;; the curent path.
     ;;
     (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)
)

(use-package savehist
 :init
     (savehist-mode)
)

(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
     ;; Marginalia must be activated in the :init section of use-package such that
     ;; the mode gets enabled right away. Note that this forces loading the
     ;; package.
     (marginalia-mode)
)

;; Enable rich annotations using the Marginalia package
(use-package consult
  :after vertico
)

;;
;; Only enabled in GUI mode!!!
;;
(if (display-graphic-p nil)
  (use-package vertico-posframe
      :after vertico
      :init
          ;;
          ;; The following setting is saying:
          ;;
          ;; All rest 'vertico-multiform-commands' use default popup
          ;; except the 'consult-imenu' and 'consult-ripgrep' (use 'vertico-buffer-mode')
          ;;
          (setq vertico-multiform-commands
              '(
                 (consult-imenu buffer)     ; Uses 'vertico-buffer-mode'
                 (consult-ripgrep buffer)   ; Uses 'vertico-buffer-mode'

                 ;;
                 ;; Use popup as default
                 ;;
                 (t posframe
                     (vertico-posframe-poshandler . posframe-poshandler-frame-center)
                     (vertico-posframe-border-width . 2)
                 )
               )
          )

          ;; The popup position specified by the 'vertico-posframe-poshandler' and the
          ;; default value is 'posframe-poshandler-frame-center'.
          ;;
          ;; You can change it on your own, the value defined in:
          ;; '~/.config/emacs/elpa/posframe-20230714.227/posframe.el'
          ;;
          ;; The builtin poshandler functions are listed below:
          ;;
          ;; posframe-poshandler-frame-center
          ;; posframe-poshandler-frame-top-center
          ;; posframe-poshandler-frame-top-left-corner
          ;; posframe-poshandler-frame-top-right-corner
          ;; posframe-poshandler-frame-top-left-or-right-other-corner
          ;; posframe-poshandler-frame-bottom-center
          ;; posframe-poshandler-frame-bottom-left-corner
          ;; posframe-poshandler-frame-bottom-right-corner
          ;; posframe-poshandler-window-center
          ;; posframe-poshandler-window-top-center
          ;; posframe-poshandler-window-top-left-corner
          ;; posframe-poshandler-window-top-right-corner
          ;; posframe-poshandler-window-bottom-center
          ;; posframe-poshandler-window-bottom-left-corner
          ;; posframe-poshandler-window-bottom-right-corner
          ;; posframe-poshandler-point-top-left-corner
          ;; posframe-poshandler-point-bottom-left-corner
          ;; posframe-poshandler-point-bottom-left-corner-upward
          ;; posframe-poshandler-point-window-center
          ;; posframe-poshandler-point-frame-center
          ;;
          ;; (setq vertico-posframe-poshandler 'posframe-poshandler-frame-center)

          ;;
          ;; Control popup left and right paddings
          ;;
          (setq vertico-posframe-parameters
              '((left-fringe . 10)
                (right-fringe . 10)
               )
          )

      :config
          (vertico-multiform-mode 1)

          ;;
          ;; When enabling 'vertico-multiform-mode', 'vertico-posframe-mode' will be
          ;; activated/deactivated by 'vertico-multiform-mode' dynamically when you
          ;; add ‘posframe’ setting to 'vertico-multiform-commands,' please do not
          ;; enable 'vertico-posframe-mode' globally at the moment!!!
          ;;
          ;; (vertico-posframe-mode 1)
  )
)

(defun embark-which-key-indicator ()
  "An embark indicator that displays keymaps using which-key.
The which-key help message will show the type and value of the
current target followed by an ellipsis if there are further
targets."
  (lambda (&optional keymap targets prefix)
    (if (null keymap)
        (which-key--hide-popup-ignore-command)
      (which-key--show-keymap
       (if (eq (plist-get (car targets) :type) 'embark-become)
           "Become"
         (format "Act on %s '%s'%s"
                 (plist-get (car targets) :type)
                 (embark--truncate-target (plist-get (car targets) :target))
                 (if (cdr targets) "…" "")))
       (if prefix
           (pcase (lookup-key keymap prefix 'accept-default)
             ((and (pred keymapp) km) km)
             (_ (key-binding prefix 'accept-default)))
         keymap)
       nil nil t (lambda (binding)
                   (not (string-suffix-p "-argument" (cdr binding))))))))

(use-package embark
  :init
    ;; Optionally replace the key help with a completing-read interface
    (setq prefix-help-command #'embark-prefix-help-command)

    ;;
    ;; Work with 'which-key', 'embark-which-key-indicator' must defined!!!
    ;;
    ;; (setq embark-indicators '(embark-which-key-indicator
    ;;                           embark-highlight-indicator
    ;;                           embark-isearch-highlight-indicator)
    ;; )

  :config
    ;;
    ;; Hide the mode line of the Embark live/completions buffers
    ;;
    ;; (add-to-list 'display-buffer-alist
    ;; 						'("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
    ;; 						nil
    ;; 						(window-parameters (mode-line-format . none))))
)

;;
;; Consult users will also want the embark-consult package.
;;
(use-package embark-consult
  :hook
      (embark-collect-mode . consult-preview-at-point-mode))

;;
;; Evil custom settings, you can found all settings here:
;; https://evil.readthedocs.io/en/latest/settings.html
;;

;; Switch between last buffers
(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))

;;
;; Set the following mode to 'normal state after 'evil-mode' loaded
;;
;; Why do this?
;; 
;; If the buffer switches to 'Evil-Normal-State' by default, then the upcomming
;; keybindins "(evil-global-set-key 'normal)" which targets to 'normal' state will
;; work automatically.
;; 
;; That will save a lot of keybinding settings.
;;
(defun rune/evil-hook ()
  (dolist (mode '(helpful-mode
                  help-mode
                  debugger-mode
                  package-menu-mode
                  term-mode
                  custom-mode))
      (evil-set-initial-state mode 'normal)
  )
)

(use-package evil
    :init
      (setq evil-auto-indent t          ; Enable auto indent
            evil-echo-state t           ; Don't show the state/mode in status bar
            evil-want-C-u-scroll t      ; Enable <C-u> scroll up
            evil-want-C-i-jump t        ; <C-i> inserts a tab character
            evil-want-Y-yank-to-eol t   ; Enable `Y`: Yank to end of line
            evil-vsplit-window-right t  ; Always vsplit window on the rigth
            evil-want-integration t     ;This is optional since it's already set to t by default.
            evil-want-keybinding nil
      )
    :custom
      (evil-undo-system 'undo-redo)
    :config
      (evil-mode 1)

      ;; Leader key
      (evil-set-leader '(normal visual) (kbd "SPC"))
      (rune/evil-hook)
)

(use-package evil-collection
  :after evil
  :config
      (evil-collection-init))

(use-package evil-surround
    :init
    (global-evil-surround-mode 1)
    :config
        (add-hook 'org-mode-hook (lambda ()
                                    (push '(?= . ("=" . "=")) evil-surround-pairs-alist)))
)

(use-package evil-goggles
  :ensure t
  :init
     ;;
     ;; Only enalbe yank effect, 't' by default
     ;;
     ;; (setq evil-goggles-enable-yank t)

     ;;
     ;; Disable the following effects
     ;;
     (setq evil-goggles-enable-delete nil
           evil-goggles-enable-change nil
           evil-goggles-enable-indent nil
           evil-goggles-enable-join nil
           evil-goggles-enable-fill-and-move nil
           evil-goggles-enable-paste nil
           evil-goggles-enable-shift nil
           evil-goggles-enable-surround nil
           evil-goggles-enable-commentary nil
           evil-goggles-enable-nerd-commenter nil
           evil-goggles-enable-replace-with-register nil
           evil-goggles-enable-set-marker nil
           evil-goggles-enable-undo nil
           evil-goggles-enable-redo nil
           evil-goggles-enable-record-macro nil)
  :config
  (evil-goggles-mode)

  ;; optionally use diff-mode's faces; as a result, deleted text
  ;; will be highlighed with `diff-removed` face which is typically
  ;; some red color (as defined by the color theme)
  ;; other faces such as `diff-added` will be used for other actions
  (evil-goggles-use-diff-faces))

(defun my/org-mode-setup()
  (org-indent-mode)           ;; Enable org indent mode
  (variable-pitch-mode -1)
  (visual-line-mode 1)

  ;;
  ;; Heading font size (only works in GUI mode)
  ;; 
  ;; But the following settings only work in =GUI= mode, nothing will happen in =Terminal= mode!!!
  ;;
  (dolist (face '((org-level-1 . 1.5)
		  (org-level-2 . 1.3)
		  (org-level-3 . 1.2)
		  (org-level-4 . 1.1)
		  (org-level-5 . 1.0)
		  (org-level-6 . 1.0)
		  (org-level-7 . 1.0)))
    (set-face-attribute (car face) nil
			:font "SauceCodePro Nerd Font"
			:weight 'regular
			:height (cdr face))
  )
)

(use-package org
   :config
	(setq org-ellipsis " ......"         ; Ellipsis string when `S-TAB`
	      org-hide-emphasis-markers t    ; Hide the marker (bold, link etc)
	)
	(add-hook 'org-mode-hook #'my/org-mode-setup)
 )


(use-package org-bullets
  :after org
  :init
    ;;(setq org-bullets-bullet-list '("①" "②" "③" "④" "⑤" "⑥"))
    (setq org-bullets-bullet-list '("➊" "➋" "➌" "➍" "➎" "➏"))
  :config
     (add-hook 'org-mode-hook #'org-bullets-mode)
)

(defun my-enable-org-auto-tangle()
   (message "[ my-enable-org-auto-tangle ]")
   (org-auto-tangle-mode nil)
   (message "[ my-enable-org-auto-tangle ] - Done.")
)

(use-package org-auto-tangle
  :after org
  :config
     (add-hook 'org-mode-hook #'my-enable-org-auto-tangle)
)

(setq treesit-language-source-alist
  '((c "https://github.com/tree-sitter/tree-sitter-c")
    (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
    (zig "https://github.com/maxxnino/tree-sitter-zig")
    (rust "https://github.com/tree-sitter/tree-sitter-rust")
    (bash "https://github.com/tree-sitter/tree-sitter-bash")
    (cmake "https://github.com/uyha/tree-sitter-cmake")
    (css "https://github.com/tree-sitter/tree-sitter-css")
    (elisp "https://github.com/Wilfred/tree-sitter-elisp")
    (go "https://github.com/tree-sitter/tree-sitter-go")
    (html "https://github.com/tree-sitter/tree-sitter-html")
    (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
    (json "https://github.com/tree-sitter/tree-sitter-json")
    (make "https://github.com/alemuller/tree-sitter-make")
    (markdown "https://github.com/ikatyang/tree-sitter-markdown")
    (python "https://github.com/tree-sitter/tree-sitter-python")
    (toml "https://github.com/tree-sitter/tree-sitter-toml")
    (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
    (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
    (yaml "https://github.com/ikatyang/tree-sitter-yaml")
    (fish "https://github.com/ram02z/tree-sitter-fish")
    (java "https://github.com/tree-sitter/tree-sitter-java")
   )
)

;;
;; Change the default major mode
;;
(add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-ts-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-or-c++-ts-mode))
(add-to-list 'auto-mode-alist '("CMakeLists.txt" . cmake-ts-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.fish\\'" . fish-mode))
(add-to-list 'auto-mode-alist '("lfrc" . bash-mode))
(add-to-list 'auto-mode-alist '("bspwmrc" . bash-mode))
(add-to-list 'auto-mode-alist '("\\.clang-format\\'" . bash-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-ts-mode))


;;
;; remap the non-treesitter mode to treesitter mode
;;
(setq major-mode-remap-alist
 '((c-mode . c-ts-mode)
   (c++-mode . c++-ts-mode)
   (bash-mode . bash-ts-mode)
   (sh-mode . bash-ts-mode)
   (cmake-mode . cmake-ts-mode)
   (css-mode . css-ts-mode)
   (elisp-mode . elisp-ts-mode)
   (go-mode . go-ts-mode)
   (html-mode . html-ts-mode)
   (js-mode . js-ts-mode)
   (make-mode . make-ts-mode)
   (json-mode . json-ts-mode)
   (js-json-mode . json-ts-mode)
   (python-mode . python-ts-mode)
   (tsx-mode . tsx-ts-mode)
   (typescript-mode . typescript-ts-mode)
   (yaml-mode . yaml-ts-mode)
   (java-mode . java-ts-mode)
  )
)

(dolist (map (list
              global-map
              evil-window-map
              evil-normal-state-map
              evil-motion-state-map
              ))
    (define-key map (kbd "C-j") nil)
    (define-key map (kbd "C-k") nil)
    ;;(message "State: %s" state);
)

(evil-define-key 'normal org-mode-map (kbd "C-j") nil)
(evil-define-key 'normal org-mode-map (kbd "C-k") nil)

(dolist (map (list
              vertico-map
              ))
  (define-key map (kbd "C-j") 'vertico-next)
  (define-key map (kbd "C-k") 'vertico-previous)
)

;;
;; 'org-mode'
;;
(defun my-org-next-heading()
  (interactive)
  (org-forward-heading-same-level nil)
  (evil-scroll-line-to-center nil)
)

(defun my-org-previous-heading()
  (interactive)
  (org-backward-heading-same-level nil)
  (evil-scroll-line-to-center nil)
)

(evil-define-key 'normal org-mode-map (kbd "C-j") 'my-org-next-heading)
(evil-define-key 'normal org-mode-map (kbd "C-k") 'my-org-previous-heading)

;;
;; Bind to the local buffer keymap against the following delay modes
;;
(defun my-markdown-next-heading()
  (interactive)
  (outline-next-visible-heading 1)
  (evil-scroll-line-to-center nil)
)

(defun my-markdown-previous-heading()
  (interactive)
  (outline-next-visible-heading -1)
  (evil-scroll-line-to-center nil)
)

(defun my-bind-markdown-heading-jumping-local()
  (define-key evil-normal-state-local-map (kbd "C-j") 'my-markdown-next-heading)
  (define-key evil-normal-state-local-map (kbd "C-k") 'my-markdown-previous-heading)
)

(dolist (hook '(
               markdown-mode-hook
               markdown-view-mode-hook
               ))
  (add-hook hook #'my-bind-markdown-heading-jumping-local)
)

(setq my-tab-width 4)

;;
;; 
;;
(defun my-c-style-settings()
    ;;
    ;; Very important to reset!!!
    ;;
    (setq tab-width my-tab-width)                

    ;;
    ;;This setting ONLY for for 'c-mode'!!!
    ;;
    (setq c-default-style "linux")               ;; Default is 'gun'
    (setq c-basic-offset my-tab-width)           ;; Default is 2

    ;;
    ;; In 'c-ts-mode' you have to use another settings!!!
    ;;
    (setq c-ts-mode-indent-style "linux")        ;; Default is 'gun'
    (setq c-ts-mode-indent-offset my-tab-width)  ;; Default is 2

    ;;
    ;; Back to normal TAB behavior rather than 'indent-for-tab-command' 
    ;;
    (define-key evil-insert-state-local-map (kbd "TAB") 'tab-to-tab-stop)

    (message ">>> my-c-style-settings [done]")
)

;; ;;
;; ;; In 'c-ts-mode' you have to use another settings!!!
;; ;;
;; (defun my-c-treesitter-style-settings()
;;     (setq c-ts-mode-indent-style "linux")        ;; Default is 'gun'
;;     (setq c-ts-mode-indent-offset my-tab-width)  ;; Default is 2
;;     (message ">>> my-c-treesitter-style-settings [done]")
;; )

;;
;;
;;
(defun my-emacs-lisp-style-settings()
    (setq tab-width 4)
    (message ">>> my-emacs-lisp-style-settings [done]")
)

(add-hook 'c-mode-hook #'my-c-style-settings)
(add-hook 'c-ts-mode-hook #'my-c-style-settings)
(add-hook 'c++-ts-mode-hook #'my-c-style-settings)
(add-hook 'zig-mode-hook #'my-c-style-settings)
(add-hook 'rust-ts-mode-hook #'my-c-style-settings)
(add-hook 'python-ts-mode-hook #'my-c-style-settings)
(add-hook 'emacs-lisp-mode-hook #'my-emacs-lisp-style-settings)
(add-hook 'cmake-ts-mode-hook #'my-c-style-settings)
(add-hook 'typescript-ts-mode-hook #'my-c-style-settings)
(add-hook 'java-ts-mode-hook #'my-c-style-settings)

(defun start-eglot()
   (eglot-ensure)
   (setq eldoc-echo-area-prefer-doc-buffer t)
   (message ">>> start-elogt")
)

(dolist (hook '(c-mode-hook
                c-ts-mode-hook
                c++-ts-mode-hook
                rust-ts-mode-hook
                zig-mode-hook
                python-ts-mode-hook 
                cmake-ts-mode-hook
                javascript-ts-mode-hook
                typescript-ts-mode-hook
                java-ts-mode-hook
                ))
   (add-hook hook #'start-eglot)
)

(use-package company
  :custom
     (company-minimum-prefix-length 2)
     (company-idle-delay 0.0)
     (company-tooltip-align-annotations t)
     (company-show-numbers t)
     (company-selection-wrap-around t)
     (company-transformers '(company-sort-by-occurrence))
  :config
      ;;
      ;; Enable completion for all buffers
      ;;
      (global-company-mode 1)
)

(add-to-list 'load-path "~/.config/emacs/snippets")

;;
;; Fix 'company' can't list 'yasnippet' candidates in dropdown list
;;
(defun my-fix-company-yasnippet()
   ;; (add-to-list 'company-backends '(company-capf :with company-yasnippet))

   ;;
   ;; Make 'yassnippet' list first
   ;;
   (add-to-list 'company-backends '(:separate company-yasnippet company-capf))
)

(use-package yasnippet
  :config
    ;;
    ;; Enable 'yasnippet' in global minor mode
    ;;
    ;; (yas-global-mode 1)

    ;;
    ;; But I prefer only neable 'yasnippet' in coding mode
    ;;
    (yas-reload-all)

    (add-hook 'c-ts-mode-hook #'yas-minor-mode)
    (add-hook 'c++-ts-mode-hook #'yas-minor-mode)
    (add-hook 'rust-ts-mode-hook #'yas-minor-mode)
    (add-hook 'zig-mode-hook #'yas-minor-mode)
    (add-hook 'zig-mode-hook #'yas-minor-mode)
    (add-hook 'org-mode-hook #'yas-minor-mode)
    (add-hook 'cmake-ts-mode-hook #'yas-minor-mode)
    (add-hook 'java-ts-mode-hook #'yas-minor-mode)

    ;;
    ;; Fix 'company' can't list 'yasnippet' candidates in dropdown list
    ;;
    (add-hook 'eglot-managed-mode-hook #'my-fix-company-yasnippet)
)

(use-package evil-nerd-commenter
  :after lsp-mode
)

(use-package zig-mode)

(use-package rust-mode)

(use-package fish-mode)

(use-package markdown-mode)

(use-package all-the-icons)

(use-package doom-themes
    :config
    ;; Global settings (defaults)
    (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
          doom-themes-enable-italic t) ; if nil, italics is universally disabled

    ;; Load theme, pick the one you like
    ;; (load-theme 'doom-gruvbox t)
    ;;(load-theme 'doom-nord-aurora t)
    (load-theme 'doom-one t)
    ;;(load-theme 'doom-solarized-dark t)
    ;;(load-theme 'doom-solarized-light t)
    ;;(load-theme 'doom-pine t)
    ;;(load-theme 'doom-zenburn t)
    ;;(load-theme 'doom-laserwave t)
    ;;(load-theme 'doom-henna t)
    ;;(load-theme 'doom-xcode t)
    ;; (load-theme 'doom-lantern t)
    ;;(load-theme 'doom-miramare t)
    ;;(load-theme 'doom-old-hope t)

    ;; Enable flashing mode-line on errors
    ;;(doom-themes-visual-bell-config)

    ;; Enable custom neotree theme (all-the-icons must be installed!)
    (doom-themes-neotree-config)
    ;; or for treemacs users
    (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
    (doom-themes-treemacs-config)
    ;; Corrects (and improves) org-mode's native fontification.
    (doom-themes-org-config)
  )

(set-face-attribute 'mode-line-active nil :background "systemGreenColor")
;; Function name
(set-face-attribute 'font-lock-function-name-face nil :foreground "#2AA198" :weight 'bold)
;; docstring
(set-face-attribute 'font-lock-doc-face nil :foreground "#96A7A9" :weight 'normal)
;; comment
(set-face-attribute 'font-lock-comment-delimiter-face nil :weight 'normal)
(set-face-attribute 'font-lock-comment-face nil :weight 'normal)

;; -------------------------------------------------------------------------------
;; All custom faces (font settings)
;; -------------------------------------------------------------------------------
(defface my-modeline-light-blue-font '((t :foreground "#ACE6FE" :inherit italic bold)) "Modeline light blue font")
(defface my-modeline-blue-green-font '((t :foreground "#4BB5BE")) "Modeline blue-green font")
(defface my-modeline-light-orange-font '((t :foreground "#DEB45B")) "Modeline light-orange font")
(defface my-modeline-orange-font '((t :foreground "#FF9F1C")) "Modeline orange font")
(defface my-modeline-yellow-font '((t :foreground "#FFE64D")) "Modeline yellow font")
(defface my-modeline-light-red-font '((t :foreground "#f44747")) "Modeline light-red font")
(defface my-modeline-light-green-font '((t :foreground "#BBF0EF")) "Modeline light-green font")
(defface my-modeline-dark-green-font '((t :foreground "#5A7387")) "Modeline dark-green font")
(defface my-modeline-purple-font '((t :foreground "systemPurpleColor")) "Modeline purple font")
(defface my-modeline-indigo-font '((t :foreground "systemIndigoColor")) "Modeline indigo font")
(defface my-modeline-black-font '((t :foreground "gridColor")) "Modeline black font")



;; -------------------------------------------------------------------------------
;; Override the default face for change mode line background
;; -------------------------------------------------------------------------------
(set-face-attribute 'mode-line-active nil :background "#31033d")
(set-face-attribute 'mode-line-inactive nil :background "#322f33")


;; -------------------------------------------------------------------------------
;; All modeline variables
;; -------------------------------------------------------------------------------

;;
;; 'my-modeline-major-mode' variable related
;;
(defun my-get-major-mode()
  "Return 'major-mode' as a string."
  (string-replace "-mode" "" (symbol-name major-mode)))

(defun my-get-major-mode-capitalize()
  "Return capitalized 'major-mode' as a string."
  (capitalize (string-replace "-mode" "" (symbol-name major-mode))))

(defvar-local my-modeline-major-mode
  '(:eval
      (propertize (my-get-major-mode) 'face 'my-modeline-indigo-font))
  "Mode line constructor to display major mode"
)

;;
;; 'my-modeline-buffer-name' variable related
;;
(defun my-get-current-name () 
   (if (mode-line-window-selected-p)
       (buffer-name)
       (format " %s" (buffer-name))
   )
)

(defvar-local my-modeline-buffer-name
  '(:eval
      (propertize (my-get-current-name) 'face 'my-modeline-black-font))
  "Mode line constructor to display buffer name"
)

(defvar-local my-modeline-buffer-file-name
  '(:eval
      (propertize (format " %s" (buffer-file-name)) 'face 'my-modeline-dark-green-font))
  "Mode line constructor to display buffer name"
)

;;
;; 'my-modeline-evil-state' variable related
;;
(defun my-get-evil-state()
  "Return 'evil-state' as a string."
  (format " %s  " (upcase (symbol-name evil-state))))

(defvar-local my-modeline-evil-state
  '(:eval
      (when (mode-line-window-selected-p)
         (propertize (my-get-evil-state) 'face 'my-modeline-dark-green-font)))
  "Mode line constructor to display current evil state"
)


;;
;; 'my-modeline-git-branch' variable related
;;
(defun my-get-git-branch-name()
   (format "%s %s" (nerd-icons-mdicon "nf-md-source_branch") (substring vc 5))
)

(defvar-local my-modeline-git-branch
  '(:eval
      (when (mode-line-window-selected-p)
          (when-let (vc vc-mode)
              (propertize (my-get-git-branch-name) 'face 'my-modeline-yellow-font)
          ))
   )
)

;;
;; 'my-modeline-flymake' variable related
;;
(declare-function flymake--severity "flymake" (type))
(declare-function flymake-diagnostic-type "flymake" (diag))

;; Based on `flymake--mode-line-counter'.
(defun prot-modeline-flymake-counter (type)
  "Compute number of diagnostics in buffer with TYPE's severity.
TYPE is usually keyword `:error', `:warning' or `:note'."
  (let ((count 0))
    (dolist (d (flymake-diagnostics))
      (when (= (flymake--severity type)
               (flymake--severity (flymake-diagnostic-type d)))
        (cl-incf count)))
    (when (cl-plusp count)
      (number-to-string count))))

(defun my-get-lsp-error-indicator()
  ;; (insert (nerd-icons-octicon "nf-oct-bug"))  2
  ;; (insert (nerd-icons-codicon "nf-cod-bug"))  2
  ;; (insert (nerd-icons-faicon "nf-fa-bug"))    2
  (nerd-icons-octicon "nf-oct-bug")
)

(defun my-modeline-flymake-error()
   (when-let (count (prot-modeline-flymake-counter (intern ":error")))
       (propertize
           (format " %s %s" (my-get-lsp-error-indicator) count)
           'face
           'my-modeline-light-red-font)
   )
)

(defun my-get-lsp-warning-indicator()
  ;; (insert (nerd-icons-octicon "nf-oct-copilot_warning"))  2
  ;; (insert (nerd-icons-codicon "nf-cod-warning"))          2
  ;; (insert (nerd-icons-faicon "nf-fa-warning"))            2
  (nerd-icons-faicon "nf-fa-warning")
)

(defun my-modeline-flymake-warning()
   (when-let (count (prot-modeline-flymake-counter (intern ":warning")))
       (propertize
           (format " %s %s" (my-get-lsp-warning-indicator) count)
           'face
           'my-modeline-yellow-font)
   )
)

(defun my-get-lsp-note-indicator()
  ;; (insert (nerd-icons-faicon "nf-fa-exclamation"))          2
  ;; (insert (nerd-icons-mdicon "nf-md-exclamation_thick"))   󱈸 2
  ;; (insert (nerd-icons-faicon "nf-fa-exclamation_circle"))   2
  (nerd-icons-faicon "nf-fa-exclamation_circle")
)

(defun my-modeline-flymake-note()
   (when-let (count (prot-modeline-flymake-counter (intern ":note")))
       (propertize
           (format " %s %s" (my-get-lsp-note-indicator) count)
           'face
           'my-modeline-dark-green-font)
   )
)

(defvar-local my-modeline-flymake
    `(:eval
      (when (and (bound-and-true-p flymake-mode)
                 (mode-line-window-selected-p))
        (list
         '(:eval (my-modeline-flymake-error))
         '(:eval (my-modeline-flymake-warning))
         '(:eval (my-modeline-flymake-note))
         )))
  "Mode line construct displaying `flymake-mode-line-format'.
Specific to the current window's mode line.")


;;
;; 'my-modeline-misc-info' variable related
;;
(defvar-local my-modeline-misc-info
    '(:eval
      (when (mode-line-window-selected-p)
        mode-line-misc-info))
  "Mode line construct displaying `mode-line-misc-info'.
Specific to the current window's mode line.")


;; -------------------------------------------------------------------------------
;; Keep that in mind: Each mode line variable (insdie the 'mode-line-format') must have
;; the 'risky-local-variable' property and set to 't'!!!
;; -------------------------------------------------------------------------------
(dolist (my-var '(my-modeline-major-mode
                  my-modeline-buffer-name
                  my-modeline-evil-state
                  my-modeline-git-branch
                  my-modeline-flymake
                                      my-modeline-misc-info))
  (put my-var 'risky-local-variable t)
)



;; -------------------------------------------------------------------------------
;;
;; Set the 'mode-line-format' as default value.
;;
;; - If you use 'setq' here, then it only applies to the current local buffer, but you see
;; the instant effects.
;;
;; - If you use 'setq-default' here, then it applies to all buffersc, but you can't see
;; the instant effects until re-launch Emacs.
;; -------------------------------------------------------------------------------
(setq-default mode-line-format
  '("%e"
    my-modeline-evil-state
    my-modeline-buffer-name
    "  "
    ;;(:eval (format "MODE: %s" (propertize (symbol-name major-mode) 'face 'warning)))
    my-modeline-major-mode
    "  "
    my-modeline-git-branch
    "  "
    my-modeline-flymake
    "  "
    my-modeline-misc-info
    )
)

(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/sbzi/personal/org-roam"))
 ;; :bind (("<leader> n l" . org-roam-buffer-toggle)
 ;;        ("<leader> n f" . org-roam-node-find)
 ;;        ("<leader> n g" . org-roam-graph)
 ;;        ("<leader> n i" . org-roam-node-insert)
 ;;        ("<leader> n c" . org-roam-capture)
 ;;        ;; Dailies
 ;;        ("<leader> n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "<leader>sp") 'flyspell-mode)
  (define-key map (kbd "C-c s p") 'flyspell-mode)
)

;;
;; Enable
;;
(setq my-enable-which-key-customized-description t)

;;
;; Disable
;;
;; (setq my-enable-which-key-customized-description nil)

(setf (cdr help-mode-map) nil)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(dolist (map (list
              evil-insert-state-map
              evil-motion-state-map
              ))
    (define-key map (kbd "C-z") nil)
)

(define-key evil-motion-state-map (kbd "<SPC>") nil)
(define-key evil-normal-state-map (kbd "<SPC>") nil)

(dolist (map (list
              evil-motion-state-map
              evil-normal-state-map
              ))
    (define-key map (kbd "Q") 'delete-window)
    (define-key map (kbd "SPC q q") 'save-buffers-kill-terminal)
    (define-key map (kbd "C-c q q") 'save-buffers-kill-terminal)
    ;; (message ">>> bind 'Q/<leader>q/C-c q' in '%s'" map);
)


;;
;; Bind to the local buffer keymap against the following delay modes
;;
(defun my-bind-q-kill-current-window-local()
  (define-key evil-normal-state-local-map (kbd "Q") 'delete-window)
)

(dolist (hook '(
               dired-mode-hook
               xref--xref-buffer-mode-hook
               ))
  (add-hook hook #'my-bind-q-kill-current-window-local)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC q q" "Save and exit")
        (which-key-add-key-based-replacements "C-c q q" "Save and exit")
    ))

(dolist (map (list
              evil-motion-state-map
              evil-normal-state-map
              ))
    (define-key map (kbd "SPC 1") 'delete-other-windows)
    (define-key map (kbd "C-c 1") 'delete-other-windows)
)


;;
;; Bind to the local buffer keymap against the following delay modes
;;
(defun my-bind-1-delete-other-windows-local()
  (define-key evil-normal-state-local-map (kbd "SPC 1") 'delete-other-windows)
)

(dolist (hook '(
               dired-mode-hook
               xref--xref-buffer-mode-hook
               ))
  (add-hook hook #'my-bind-1-delete-other-windows-local)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC 1" "Delete other windows")
        (which-key-add-key-based-replacements "C-c 1" "Delete other windows")
    ))

(dolist (map (list
              evil-motion-state-map
              evil-normal-state-map
              ))
  (define-key map (kbd "SPC d f") 'helpful-callable)
  (define-key map (kbd "C-c d f") 'helpful-callable)
  (define-key map (kbd "SPC d v") 'helpful-variable)
  (define-key map (kbd "C-c d v") 'helpful-variable)
  (define-key map (kbd "SPC d k") 'describe-key)
  (define-key map (kbd "C-c d k") 'helpful-key)
  (define-key map (kbd "SPC d b") 'describe-bindings)
  (define-key map (kbd "C-c d b") 'describe-bindings)
  (define-key map (kbd "SPC d m") 'describe-mode)
  (define-key map (kbd "C-c d m") 'describe-mode)
  ;;(message "State: %s" state);
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC d" "Describe ...")
        (which-key-add-key-based-replacements "C-c d" "Describe ...")

        (which-key-add-key-based-replacements "SPC d f" "Function")
        (which-key-add-key-based-replacements "C-c d f" "Function")
        (which-key-add-key-based-replacements "SPC d v" "Variable")
        (which-key-add-key-based-replacements "C-c d v" "Variable")
        (which-key-add-key-based-replacements "SPC d k" "Keys")
        (which-key-add-key-based-replacements "C-c d k" "Keys")
        (which-key-add-key-based-replacements "SPC d m" "Mode")
        (which-key-add-key-based-replacements "C-c d m" "Mode")
        (which-key-add-key-based-replacements "SPC d b" "Bindings")
        (which-key-add-key-based-replacements "C-c d b" "Bindings")
    ))

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "SPC l") 'clm/toggle-command-log-buffer)
  (define-key map (kbd "C-c l") 'clm/toggle-command-log-buffer)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC l" "Command Log")
        (which-key-add-key-based-replacements "C-c l" "Command Log")
    ))

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "SPC e e") 'eval-last-sexp)
  (define-key map (kbd "C-c e e") 'eval-last-sexp)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC e" "Evalute/Emoji")
        (which-key-add-key-based-replacements "C-c e" "Evalute/Emoji")
        (which-key-add-key-based-replacements "SPC e e" "Evalute Lisp")
        (which-key-add-key-based-replacements "C-c e e" "Evalute Lisp")
    ))

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "W") 'save-buffer)
)

(defun xwl-jj-as-esc ()
(interactive)
(if (memq evil-state '(insert replace))
    (let ((changed? (buffer-modified-p)))
        (insert "j")
        (let* ((tm (current-time))
            (ch (read-key)))
        (if (and (eq ch ?j)
                (< (time-to-seconds (time-since tm)) 0.3))
            (save-excursion
                (delete-char -1)
                (evil-force-normal-state)
                (set-buffer-modified-p changed?))
            (insert ch))))
(call-interactively 'evil-next-line)))

(define-key evil-insert-state-map  "j" 'xwl-jj-as-esc)
(define-key evil-replace-state-map "j" 'xwl-jj-as-esc)

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "H") 'evil-first-non-blank)
  (define-key map (kbd "L") 'evil-end-of-line)
  ;;(message "State: %s" state);
)

(defun my-goto-last-marked-position()
  (interactive)
  (evil-goto-mark ?M)
)

(dolist (map (list
              evil-motion-state-map
              ))
    (define-key map (kbd "gb") 'my-goto-last-marked-position)
    ;;(message "State: %s" state);
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "gb" "Go back")
    ))

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "SPC f") 'find-file)
  (define-key map (kbd "C-c f") 'find-file)
  (define-key map (kbd "SPC b") 'consult-buffer)
  (define-key map (kbd "C-c b") 'consult-buffer)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC f" "Find files")
        (which-key-add-key-based-replacements "C-c f" "Find files")
        (which-key-add-key-based-replacements "SPC b" "Buffer list")
        (which-key-add-key-based-replacements "C-c b" "Buffer list")
    ))

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "SPC p f") 'project-find-file)
  (define-key map (kbd "C-c p f") 'project-find-file)

  (define-key map (kbd "SPC p d") 'project-dired)
  (define-key map (kbd "C-c p d") 'project-dired)

  (define-key map (kbd "SPC p s") 'project-switch-project)
  (define-key map (kbd "C-c p s") 'project-switch-project)

  (define-key map (kbd "SPC p b") 'project-switch-to-buffer)
  (define-key map (kbd "C-c p b") 'project-switch-to-buffer)

  (define-key map (kbd "SPC p c") 'project-async-shell-command)
  (define-key map (kbd "C-c p c") 'project-async-shell-command)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC p" "Projects")
        (which-key-add-key-based-replacements "SPC p f" "Fuzzy searching in project")
        (which-key-add-key-based-replacements "SPC p d" "Open dired in project")
        (which-key-add-key-based-replacements "SPC p b" "Switch buffer in project")
        (which-key-add-key-based-replacements "SPC p s" "Switch to another project")
        (which-key-add-key-based-replacements "SPC p c" "Run async shell command")
    ))

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "SPC SPC") 'switch-to-last-buffer)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC SPC" "Last Buffer")
    ))

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "SPC RET") 'olivetti-mode)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC RET" "Toggle Focus mode")
    ))

;;
;; Unbind the default <C-s> for 'isearch-forward'
;;
(define-key global-map (kbd "C-s") nil)

;;
;; Replace current word or selection using vim style for evil mode
;;
(defun evil-replace-word-selection()
  (interactive)
  (if (use-region-p)
      (let ((selection (buffer-substring-no-properties (region-beginning) (region-end))))
          (if (= (length selection) 0)
              (message "empty string")
              (evil-ex (concat "'<,'>s/" selection "/"))
          )
      )
      (evil-ex (concat "%s/" (thing-at-point 'word) "/"))))

;;
;; Rebind <C-s>
;;
(define-key evil-motion-state-map (kbd "C-s") 'evil-replace-word-selection)

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "SPC r") 'consult-ripgrep)
  (define-key map (kbd "C-c r") 'consult-ripgrep)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC r" "Rg search")
        (which-key-add-key-based-replacements "C-c r" "Rg search")
    ))

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "SPC i m") 'consult-imenu)
  (define-key map (kbd "C-c i m") 'consult-imenu)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC i" "iMenu/Insert")
        (which-key-add-key-based-replacements "C-c i" "iMenu/Insert")
    ))

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "SPC v s") 'evil-window-vsplit)
  (define-key map (kbd "C-c v s") 'evil-window-vsplit)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC v" "Vertical split")
        (which-key-add-key-based-replacements "C-c v" "Vertical split")
        (which-key-add-key-based-replacements "SPC v s" "Vertical split")
        (which-key-add-key-based-replacements "C-c v s" "Vertical split")
    ))

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "C-l") 'evil-window-right)
  (define-key map (kbd "C-h") 'evil-window-left)
 ;; (define-key map (kbd "C-j") 'evil-window-down)
 ;; (define-key map (kbd "C-k") 'evil-window-up)
  ;;(message "State: %s" state);
)

(defun my-increase-window-width ()
  (interactive)
  (evil-window-increase-width 5)
)

(defun my-decrease-window-width ()
  (interactive)
  (evil-window-increase-width -5)
)

(defun my-increase-window-height ()
  (interactive)
  (evil-window-increase-height 5)
)

(defun my-decrease-window-height ()
  (interactive)
  (evil-window-increase-height -5)
)

(dolist (map (list
              evil-motion-state-map
              evil-normal-state-map
              ))
  (define-key map (kbd "|") 'balance-windows)
  (define-key map (kbd "=") 'my-increase-window-width)
  (define-key map (kbd "-") 'my-decrease-window-width)
  (define-key map (kbd "+") 'my-increase-window-height)
  (define-key map (kbd "_") 'my-decrease-window-height)
)

;;
;; Bind to the local buffer keymap against the following delay modes
;;
(defun my-bind-window-resize-local()
  (define-key evil-normal-state-local-map (kbd "|") 'balance-windows)
  (define-key evil-normal-state-local-map (kbd "=") 'my-increase-window-width)
  (define-key evil-normal-state-local-map (kbd "-") 'my-decrease-window-width)
  (define-key evil-normal-state-local-map (kbd "+") 'my-increase-window-height)
  (define-key evil-normal-state-local-map (kbd "_") 'my-decrease-window-height)
)

(dolist (hook '(
               dired-mode-hook
               ))
  (add-hook hook #'my-bind-window-resize-local)
)

(defun my-open-emacs-configuration-file()
    (interactive)
    (find-file "~/.config/emacs/configuration.org")
)

;; Unbind this!!!
(define-key global-map (kbd "C-c o") nil)

(dolist (map (list
            evil-motion-state-map
            evil-normal-state-map
            ))
(define-key map (kbd "SPC o c") 'my-open-emacs-configuration-file)
(define-key map (kbd "C-c o c") 'my-open-emacs-configuration-file)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC o" "Open ....")
        (which-key-add-key-based-replacements "C-c o" "Open ....")
        (which-key-add-key-based-replacements "SPC o c" "Config file")
        (which-key-add-key-based-replacements "C-c o c" "Config file")
    ))

(defun my-open-yasnippet-folder()
    (interactive)
    (find-file-other-window "~/.config/emacs/snippets")
)

;; Unbind this!!!
(define-key global-map (kbd "C-c o") nil)

(dolist (map (list
            evil-motion-state-map
            evil-normal-state-map
            ))
(define-key map (kbd "SPC o s") 'my-open-yasnippet-folder)
(define-key map (kbd "C-c o s") 'my-open-yasnippet-folder)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC o s" "Snippet folder")
        (which-key-add-key-based-replacements "C-c o s" "Snippet folder")
    ))

(dolist (map (list
              evil-motion-state-map
              evil-normal-state-map
              ))
    (define-key map (kbd "SPC s s") 'nil)
    (define-key map (kbd "C-c s s") 'nil)
)

(defun my-open-eshell()
   (interactive)
   (split-window-below)
   (windmove-down)
   (eshell)
)

(dolist (map (list
              evil-motion-state-map
              ))
    (define-key map (kbd "SPC s s") 'my-open-eshell)
    (define-key map (kbd "C-c s s") 'my-open-eshell)

    (if my-enable-which-key-customized-description
        (progn
            (which-key-add-key-based-replacements "SPC s s" "Shell")
            (which-key-add-key-based-replacements "C-c s s" "Shell")
        ))
)

(defun my-open-sbzi-folder()
  (interactive)
  (dired "~/sbzi")
)
(defun my-open-notes-folder()
  (interactive)
  (dired "~/sbzi/personal/denote")
)

;;
;; Bind
;;
(dolist (map (list
              evil-motion-state-map
              evil-normal-state-map
              ))
    (define-key map (kbd "SPC o d") 'my-open-sbzi-folder)
    (define-key map (kbd "C-c o d") 'my-open-sbzi-folder)

    (define-key map (kbd "SPC o n") 'my-open-notes-folder)
    (define-key map (kbd "C-c o n") 'my-open-notes-folder)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC o d" "directory")
        (which-key-add-key-based-replacements "C-C o d" "directory")

        (which-key-add-key-based-replacements "SPC o n" "directory")
        (which-key-add-key-based-replacements "C-C o n" "directory")
    ))

(dolist (map (list
               evil-motion-state-map
               evil-normal-state-map
               ))
   (define-key map (kbd "SPC e i") 'emoji-insert)
   (define-key map (kbd "C-c e i") 'emoji-insert)
 )

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC e i" "Insert emoji")
        (which-key-add-key-based-replacements "C-c e i" "Insert emoji")
    ))

(dolist (map (list
               evil-motion-state-map
               evil-normal-state-map
               ))
   (define-key map (kbd "SPC e r") 'emoji-recent)
   (define-key map (kbd "C-c e r") 'emoji-recent)
 )

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC e r" "Recent emoji")
        (which-key-add-key-based-replacements "C-c e r" "Recent emoji")
    ))

;;
;; Unbind 'n' and 'N'
;;
(define-key evil-motion-state-map (kbd "n") nil)
(define-key evil-motion-state-map (kbd "N") nil)

(defun my-search-next()
  (interactive)
  (evil-search-next)
  (evil-scroll-line-to-center nil)
)

(defun my-search-previous()
  (interactive)
  (evil-search-previous)
  (evil-scroll-line-to-center nil)
)

(define-key evil-motion-state-map (kbd "n") 'my-search-next)
(define-key evil-motion-state-map (kbd "N") 'my-search-previous)

(defun my-org-mode-return-cycle-local()
  (define-key evil-normal-state-local-map (kbd "RET") 'org-cycle)
)

(defun my-org-mode-insert-and-open-link-local()
  (define-key evil-normal-state-local-map (kbd "SPC i l") 'org-insert-link)
  (define-key evil-normal-state-local-map (kbd "C-c i l") 'org-insert-link)
  (define-key evil-normal-state-local-map (kbd "SPC o l") 'org-open-at-point)
  (define-key evil-normal-state-local-map (kbd "C-c o l") 'org-open-at-point)

  (if my-enable-which-key-customized-description
      (progn
          (which-key-add-key-based-replacements "SPC o l" "Open at point")
          (which-key-add-key-based-replacements "C-c o l" "Open at point")
          (which-key-add-key-based-replacements "SPC i l" "Insert link")
          (which-key-add-key-based-replacements "C-c i l" "Insert link")
      ))
)

(defun my-org-mode-local-bindings()
   ;; (my-org-mode-create-elisp-code-block-local)
   (my-org-mode-return-cycle-local)
   (my-org-mode-insert-and-open-link-local)
)

(add-hook 'org-mode-hook #'my-org-mode-local-bindings)

(evil-define-key 'normal markdown-mode-map (kbd "RET") 'markdown-cycle)
(evil-define-key 'normal markdown-view-mode-map (kbd "RET") 'markdown-cycle)

;;
;; Close the 'helful' window and kill its buffer
;;
(defun kill-helpful-window-and-buffers ()
    (interactive)
    (message ">>> [ kill-helpful-window-and-buffers ] - ....... ")

    (cl-loop for buf in (buffer-list)
            do (if (string-match-p "^*helpful" (buffer-name buf))
               (progn
                   ;;
                   ;; Try to close its window first if exists.
                   ;;
                   (setq window-to-be-killed (get-buffer-window (buffer-name buf) nil))
                   (if window-to-be-killed
                      (progn
                          (delete-window window-to-be-killed)
                          (message ">>> [ kill-helpful-window-and-buffers] - Closed window associated with buffer: %s" (buffer-name buf))
                      )
                   )

                   ;;
                   ;; Kill buffer.
                   ;;
                   (message ">>> [ kill-helpful-window-and-buffers] - Killed buffer: %s" (buffer-name buf))
                   (kill-buffer buf)
               )
            )
    )

    (message ">>> [ kill-helpful-window-and-buffers ] - [done] ")
)

(define-key evil-motion-state-map (kbd "SPC k h") 'kill-helpful-window-and-buffers)
(define-key evil-normal-state-map (kbd "C-c k h") 'kill-helpful-window-and-buffers)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC k" "Kill")
        (which-key-add-key-based-replacements "C-c k" "Kill")
        (which-key-add-key-based-replacements "SPC k h" "Help window and buffer")
        (which-key-add-key-based-replacements "C-c k h" "Help window and buffer")
    ))

;;
;; Close the 'eldoc' window and kill its buffer
;;
(defun kill-eldoc-window-and-buffers ()
    (interactive)
    (message ">>> [ kill-eldoc-window-and-buffers ] - ....... ")

    (cl-loop for buf in (buffer-list)
       do (if (string-match-p "^*eldoc" (buffer-name buf))
           (progn
              ;;
              ;; Try to close its window first if exists.
              ;;
              (setq window-to-be-killed (get-buffer-window (buffer-name buf) nil))
              (if window-to-be-killed
                  (progn
                      (delete-window window-to-be-killed)
                      (message ">>> [ kill-eldoc-window-and-buffers] - Closed window associated with buffer: %s" (buffer-name buf))
                  )
              )

              ;;
              ;; Kill buffer.
              ;;
              (message ">>> [ kill-eldoc-window-and-buffers] - Killed buffer: %s" (buffer-name buf))
              (kill-buffer buf)
           )
       )
    )

    (message ">>> [ kill-eldoc-window-and-buffers ] - [done] ")
)

(define-key evil-motion-state-map (kbd "SPC k d") 'kill-eldoc-window-and-buffers)
(define-key evil-normal-state-map (kbd "C-c k d") 'kill-eldoc-window-and-buffers)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC k d" "Doc window and buffer")
        (which-key-add-key-based-replacements "C-c k d" "Doc window and buffer")
    ))

;;
;; Close the 'embark' window and kill its buffer
;;
(defun kill-embark-window-and-buffers ()
   (interactive)
   (message ">>> [ kill-embark-window-and-buffers ] - ....... ")

   (cl-loop for buf in (buffer-list)
      do (if (string-match-p "^*Embark" (buffer-name buf))
         (progn
             ;;
             ;; Try to close its window first if exists.
             ;;
             (setq window-to-be-killed (get-buffer-window (buffer-name buf) nil))
             (if window-to-be-killed
                 (progn
                     (delete-window window-to-be-killed)
                     (message ">>> [ kill-embark-window-and-buffers] - Closed window associated with buffer: %s" (buffer-name buf))
                 )
             )

             ;;
             ;; Kill buffer.
             ;;
             (message ">>> [ kill-embark-window-and-buffers] - Killed buffer: %s" (buffer-name buf))
             (kill-buffer buf)
         )
      )
   )

   (message ">>> [ kill-embark-window-and-buffers ] - [done] ")
)

(define-key evil-motion-state-map (kbd "SPC k e") 'kill-embark-window-and-buffers)
(define-key evil-normal-state-map (kbd "C-c k e") 'kill-embark-window-and-buffers)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC k e" "Embark window and buffer")
        (which-key-add-key-based-replacements "C-c k e" "Embark window and buffer")
    ))

(defun rebind-general-leader-x-bindings-to-local-buffer-scope()
  ;;
  ;; Quick
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC q") 'save-buffers-kill-terminal)

  ;;
  ;; Describe related
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC d f") 'helpful-callable)
  (define-key evil-normal-state-local-map (kbd "SPC d v") 'helpful-variable)
  (define-key evil-normal-state-local-map (kbd "SPC d k") 'describe-key)
  (define-key evil-normal-state-local-map (kbd "SPC d b") 'describe-bindings)
  (define-key evil-normal-state-local-map (kbd "SPC d m") 'describe-mode)

  ;;
  ;; Command log
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC l") 'clm/toggle-command-log-buffer)

  ;;
  ;; Evalate
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC e e") 'eval-last-sexp)

  ;;
  ;; Find and switch related
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC f") 'find-file)
  (define-key evil-normal-state-local-map (kbd "SPC r") 'consult-ripgrep)
  (define-key evil-normal-state-local-map (kbd "SPC b") 'consult-buffer)
  (define-key evil-normal-state-local-map (kbd "SPC SPC") 'switch-to-last-buffer)

  ;;
  ;; Project scope related
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC p f") 'project-find-file)
  (define-key evil-normal-state-local-map (kbd "SPC p d") 'project-dired)
  (define-key evil-normal-state-local-map (kbd "SPC p s") 'project-switch-project)
  (define-key evil-normal-state-local-map (kbd "SPC p b") 'project-switch-to-buffer)
  (define-key evil-normal-state-local-map (kbd "SPC p c") 'project-async-shell-command)

  ;;
  ;; Focus mode
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC RET") 'olivetti-mode)

  ;;
  ;; iMenu
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC i m") 'consult-imenu)



  ;;
  ;; Window split and movement
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC v s") 'evil-window-vsplit)

  ;;
  ;; Quick open related
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC o c") 'my-open-emacs-configuration-file)
  (define-key evil-normal-state-local-map (kbd "SPC o s") 'my-open-yasnippet-folder)

  ;;
  ;; Emoji related
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC e i") 'emoji-insert)
  (define-key evil-normal-state-local-map (kbd "SPC e r") 'emoji-recent)

  ;;
  ;; Kill specific buffer and opened windows
  ;;
  (define-key evil-normal-state-local-map (kbd "SPC k h") 'kill-helpful-window-and-buffers)
  (define-key evil-normal-state-local-map (kbd "SPC k d") 'kill-eldoc-window-and-buffers)
  (define-key evil-normal-state-local-map (kbd "SPC k e") 'kill-embark-window-and-buffers)

  (message "[ rebind-general-leader-x-bindings-to-local-buffer-scope ] - Done.")
)

(defun my-dired-h-l-to-directory-navigating-local()
  (define-key evil-normal-state-local-map (kbd "h") 'dired-up-directory)
  (define-key evil-normal-state-local-map (kbd "l") 'dired-find-file)
)

(defun my-dired-o-to-open-file-local()
  (define-key evil-normal-state-local-map (kbd "o") 'dired-find-file-other-window)
)

(dolist (map (list
              evil-motion-state-map
              ))
    (define-key map (kbd "C-c j") 'dired-jump)
)

(defun my-goto-home-directory()
   (interactive)
   (dired "~/")
)
(defun my-goto-shell-backup-directory()
   (interactive)
   (dired "~/sbzi/dot-config")
)
(defun my-goto-c-directory()
   (interactive)
   (dired "~/sbzi/c")
)
(defun my-goto-emacs-directory()
   (interactive)
   (dired "~/.config/emacs")
)
(defun my-goto-downloads-directory()
   (interactive)
   (dired "~/Downloads")
)
(defun my-goto-sbzi-directory()
   (interactive)
   (dired "~/sbzi")
)
(defun my-goto-temp-directory()
   (interactive)
   (dired "~/temp")
)
(defun my-goto-photo-directory()
   (interactive)
   (dired "~/Photos")
)

(defun my-dired-custom-go-to-local()
  (define-key evil-normal-state-local-map (kbd "gh") 'my-goto-home-directory)
  (define-key evil-normal-state-local-map (kbd "gb") 'my-goto-shell-backup-directory)
  (define-key evil-normal-state-local-map (kbd "gd") 'my-goto-downloads-directory)
  (define-key evil-normal-state-local-map (kbd "gc") 'my-goto-c-directory)
  (define-key evil-normal-state-local-map (kbd "ge") 'my-goto-emacs-directory)
  (define-key evil-normal-state-local-map (kbd "gp") 'my-goto-photo-directory)
  (define-key evil-normal-state-local-map (kbd "gs") 'my-goto-sbzi-directory)
  (define-key evil-normal-state-local-map (kbd "gt") 'my-goto-temp-directory)
)

(setq dired-omit-files "^\\...+$")

(defun my-dired-toggle-hidden-files-local()
  (define-key evil-normal-state-local-map (kbd "SPC h") 'dired-omit-mode)
  (define-key evil-normal-state-local-map (kbd "C-c h") 'dired-omit-mode)

  (if my-enable-which-key-customized-description
      (progn
          (which-key-add-key-based-replacements "SPC h" "Hidden mode")
          (which-key-add-key-based-replacements "C-c h" "Hidden mode")
      ))
)

(defun my-dired-toggle-read-only-local()
  (define-key evil-normal-state-local-map (kbd "SPC m") 'dired-toggle-read-only)
  (define-key evil-normal-state-local-map (kbd "C-c m") 'dired-toggle-read-only)

  (if my-enable-which-key-customized-description
      (progn
          (which-key-add-key-based-replacements "SPC m" "Modify mode")
          (which-key-add-key-based-replacements "C-c m" "Modify mode")
      ))
)

(defun my-dired-yank-full-path ()
   (interactive)
   (dired-copy-filename-as-kill 0)
)

(defun my-dired-yank-full-path-local()
  (define-key evil-normal-state-local-map (kbd "SPC y p") 'my-dired-yank-full-path)
  (define-key evil-normal-state-local-map (kbd "C-c y p") 'my-dired-yank-full-path)

  (if my-enable-which-key-customized-description
      (progn
          (which-key-add-key-based-replacements "SPC y" "Yank")
          (which-key-add-key-based-replacements "C-c y" "Yank")
          (which-key-add-key-based-replacements "SPC y p" "Yank full path")
          (which-key-add-key-based-replacements "C-c y p" "Yank full path")
      ))
)

(defun my-dired-customized-bindings()
   (my-dired-h-l-to-directory-navigating-local)
   (my-dired-o-to-open-file-local)
   (my-dired-custom-go-to-local)
   (my-dired-toggle-hidden-files-local)
   (my-dired-toggle-read-only-local)
   (my-dired-yank-full-path-local)

   ;;
   ;; Rebind all SPC related bindings to local buffer scope
   ;;
   (rebind-general-leader-x-bindings-to-local-buffer-scope)
)

(add-hook 'dired-mode-hook #'my-dired-customized-bindings)

(evil-define-key '(normal) image-mode-map (kbd "=") 'image-transform-fit-to-window)

(defun my-lsp-error-jumping-in-local-buffer()
  (define-key evil-normal-state-local-map (kbd "C-n") 'flymake-goto-next-error)
  (define-key evil-normal-state-local-map (kbd "C-p") 'flymake-goto-prev-error)

  (message ">>> [ my-lsp-error-jumping-in-local-buffer ] Set 'C-n' and 'C-p' to local buffer")
)

(defun my-lsp-format-buffer()
  ;;(define-key evil-normal-state-local-map (kbd "<leader>ff") 'lsp-format-buffer)

  (define-key evil-normal-state-local-map (kbd "SPC f f") 'eglot-format-buffer)

  (message ">>> [ my-lsp-format-buffer ] Set '<leader>ff' to local buffer")
)

(defun my-lsp-rename-buffer()
  ;; (define-key evil-normal-state-local-map (kbd "<leader>rn") 'lsp-rename)

  (define-key evil-normal-state-local-map (kbd "SPC r n") 'eglot-rename)

  (message ">>> [ my-lsp-rename-buffer ] Set '<leader>rn' to local buffer")
)

(defun my-lsp-show-error()
  (define-key evil-normal-state-local-map (kbd "SPC s e") 'flymake-show-buffer-diagnostics)

  (message ">>> [ my-lsp-show-error ] Set '<leader>se' to local buffer")
)

(defun my-lsp-code-action()
  ;; (define-key evil-normal-state-local-map (kbd "<leader>ca") 'lsp-execute-code-action)
  ;; (define-key evil-normal-state-local-map (kbd "C-c c a") 'lsp-execute-code-action)

  (define-key evil-normal-state-local-map (kbd "SPC c a") 'eglot-code-action-quickfix)

  (message ">>> [ my-lsp-code-action ] Set '<leader>ca' to local buffer")
)

(defun my-lsp-toggle-comment()
  (define-key evil-visual-state-local-map (kbd "SPC /") 'evilnc-comment-or-uncomment-lines)

  (message ">>> [ my-lsp-toggle-comment ] Set '<leader>/' to local buffer")
)

(defun my-lsp-toggle-inlay-hint()
  (interactive)
  (message ">>>>> called.")
  (if eglot-inlay-hints-mode
      (progn
          (message ">>> [ my-lsp-toggle-inlay-hint ] Inlay hint is 'on', turn it 'off' now.")
          (eglot-inlay-hints-mode -1)
      )
      (progn
          (message ">>> [ my-lsp-toggle-inlay-hint ] Inlay hint is 'off', turn it 'on' now.")
          (eglot-inlay-hints-mode 1)
      )
  )
)

(defun my-setup-toggle-inlay-hint()
    (define-key evil-normal-state-local-map (kbd "SPC t h") 'my-lsp-toggle-inlay-hint)
    (message ">>> [ my-setup-toggle-inlay-hint ] Set '<leader>th' to local buffer")
)

(defun my-lsp-bindings()
   (my-lsp-error-jumping-in-local-buffer)
   (my-lsp-format-buffer)
   (my-lsp-rename-buffer)
   (my-lsp-show-error)
   (my-lsp-code-action)
   (my-lsp-toggle-comment)
   (my-setup-toggle-inlay-hint)

   (if my-enable-which-key-customized-description
       (progn
           (which-key-add-major-mode-key-based-replacements major-mode "SPC f" "Format")
           (which-key-add-major-mode-key-based-replacements major-mode "SPC f f" "Format")
           (which-key-add-major-mode-key-based-replacements major-mode "SPC r" "Rename")
           (which-key-add-major-mode-key-based-replacements major-mode "SPC r n" "Rename")
           (which-key-add-major-mode-key-based-replacements major-mode "SPC s" "Show errors")
           (which-key-add-major-mode-key-based-replacements major-mode "SPC s e" "Show errors")
           (which-key-add-major-mode-key-based-replacements major-mode "SPC c" "Code actions")
           (which-key-add-major-mode-key-based-replacements major-mode "SPC c a" "Code actions")
           (which-key-add-major-mode-key-based-replacements major-mode "SPC /" "Comment")
           (which-key-add-major-mode-key-based-replacements major-mode "SPC t" "Toggle")
           (which-key-add-major-mode-key-based-replacements major-mode "SPC t h" "Toggle hints")
       ))
)

(dolist (hook '(c-mode-hook
                c-ts-mode-hook
                c++-mode-hook
                c++-ts-mode-hook
                zig-mode-hook
                zig-ts-mode-hook
                rust-mode-hook
                rust-ts-mode-hook
                typescript-ts-mode-hook
                python-ts-mode-hook
                java-ts-mode-hook
                ))
   (add-hook hook #'my-lsp-bindings)
)

;; (define-key global-map (kbd "C-,") 'embark-act)
(define-key global-map (kbd "C-e") 'embark-act)

(use-package org-download
    ;; Drag-and-drop to `dired`
    :config
    (add-hook 'dired-mode-hook 'org-download-enable)
)

(use-package pdf-tools
    :load-path "~/.config/emacs/elpa/pdf-tools-20230611.239"
    :commands pdf-tools-install
    :mode ("\\.[pP][dD][fF]\\'" . pdf-view-mode)
    :magic ("%PDF" . pdf-view-mode)
    :hook (dirvish-setup . pdf-tools-install)
    :config
    (pdf-tools-install t nil t nil))

  (defun my-pdf-scroll-local()
   (message ">>> [ my-pdf-scroll-local ] ")

   ;;
   ;; Rebind
   ;;
   (define-key evil-normal-state-local-map (kbd "k") 'pdf-view-scroll-down-or-previous-page)
   (define-key evil-normal-state-local-map (kbd "j") 'pdf-view-scroll-up-or-next-page)
   (define-key evil-normal-state-local-map (kbd "|") 'pdf-view-fit-page-to-window)
   (define-key evil-normal-state-local-map (kbd "G") 'pdf-view-goto-page)
   (define-key evil-normal-state-local-map (kbd "<") 'pdf-view-first-page)
   (define-key evil-normal-state-local-map (kbd ">") 'pdf-view-last-page)
   (message ">>> [ my-pdf-scroll-local ] rebind pdf navigation works. ")

   ;;
   ;; Rebind all SPC related bindings to local buffer scope
   ;;
   (rebind-general-leader-x-bindings-to-local-buffer-scope)
   (rebind-colemak-leader-x-bindings-to-local-buffer-scope)
   )

(defun my-pdf-custom-settings()
  (global-display-line-numbers-mode 0)
  ;; (setq display-line-numbers-type 'relative)
  ;; (setq column-number-mode t)
)

(dolist (hook '(pdf-view-mode-hook
                ))
   (add-hook hook #'my-pdf-scroll-local)
   (add-hook hook #'my-pdf-custom-settings)
)

;;  (use-package pdf-tools
;;  :load-path "~/.config/emacs/elpa/pdf-tools-20230611.239"
;;  :mode ("\\.pdf\\'" . pdf-view-mode) ; pdf 文件默认打开方式
;; :bind
;;  (:map pdf-view-mode-map
;;   ("j" . pdf-view-next-page-command)
;;   ("k" . pdf-view-previous-page-command)
;;   ("l" . pdf-view-scroll-up-or-next-page)
;;   ("h" . pdf-view-scroll-down-or-previous-page)
;;   ("G" . pdf-view-goto-page)
;;   ("|" . pdf-view-fit-page-to-window)
;;   ("<" . pdf-view-first-page)
;;   ("<" . pdf-view-last-page)
;;
;;   :map pdf-history-minor-mode-map
;;   ("B" . pdf-history-backward)
;;   :map pdf-annot-minor-mode-map
;;   ("C-a a" . pdf-annot-add-highlight-markup-annotation)
;;   ("C-a s" . pdf-annot-add-squiggly-markup-annotation)
;;   ("C-a u" . pdf-annot-add-underline-markup-annotation)
;;   ("C-a d" . pdf-annot-delete))
;;  :custom
;;  (pdf-view-midnight-colors '("#000000" . "#9bCD9b")) ; 夜间模式设置绿色底色
;;  :config
;;  (require 'pdf-annot) ; 设置 pdf-annot-mimor-mode-map 必须
;;  (require 'pdf-history) ; 设置 pdf-history-minor-mode-map 必须
;;  (add-hook 'pdf-view-mode-hook 'pdf-view-fit-width-to-window) ; 默认适应页宽
;;  (add-hook 'pdf-view-mode-hook 'pdf-view-midnight-minor-mode) ; 默认夜间模式
;;  (pdf-tools-install))

(use-package pdf-tools)

(use-package org-noter
  :config
      (setq org-noter-max-short-selected-text-length 700000)
      (setq org-noter-max-short-length 80000)
      (setq org-noter-always-create-frame nil) ;; Prevent use new frame!!!
      (if (> 999 (display-pixel-height)) 
         (setq org-noter-doc-split-fraction '(0.6 . 0.5)))
  :custom
      (org-noter-highlight-selected-text t)
      (org-noter-notes-search-path '("~/sbzi/personal/org-noter/"))
      (org-noter-auto-save-last-location t)
)



(define-key org-noter-doc-mode-map (kbd "M-i") nil)
(define-key pdf-view-mode-map (kbd "C-u") nil)
(define-key org-noter-doc-mode-map (kbd "M-i") #'dm/insert-precise)

(defun dm/insert-precise (&optional optional)
  (interactive "P")
  (org-noter-insert-precise-note 't))

;; (push "~/workspace/org-noter-plus-djvu" load-path)
;; (push "~/workspace/org-noter-plus-djvu/other" load-path)
;; (push "~/workspace/org-noter-plus-djvu/modules" load-path)

;; (require 'org-noter)
;; (require 'org-noter-nov)
;; (require 'org-noter-pdf)


(define-advice org-noter--insert-heading (:after (level title &optional newlines-number location) add-full-body-quote)
  "Advice for org-noter--insert-heading.

When inserting a precise note insert the text of the note in the body as an org mode QUOTE block.

=org-noter-max-short-length= should be set to a large value to short circuit the normal behavior:
=(setq org-noter-max-short-length 80000)="

  ;; this tells us it's a precise note that's being invoked.
  (if (consp location)
      (insert (format "#+BEGIN_QUOTE\n%s\n#+END_QUOTE" title))))

;; ;; (require 'org-noter-nov-overlay)
;; doesn't work. (require 'org-noter-integration)


;;  (use-package pdf-tools-org-noter-helpers
;;   :straight (
;;              :type git :repo "https://github.com/analyticd/pdf-tools-org-noter-helpers")
;;   :config
;; (require 'pdf-tools-org-noter-helpers))

  (defun my-org-noter-local()
      (message ">>> [ my-pdf-org-noter-local ] ")

      ;;
      ;; Rebind
      ;;
      ;;(define-key evil-normal-state-local-map (kbd "C-c n n") 'org-noter)
      (define-key evil-normal-state-local-map (kbd "C-c n n") 'org-noter)
      (define-key evil-normal-state-local-map (kbd "M-a") 'org-noter-insert-note)
      (define-key evil-normal-state-local-map (kbd "M-p") 'org-noter-insert-precise-note)
      (define-key evil-normal-state-local-map (kbd "M-o") 'org-noter-create-skeleton)
      (define-key evil-normal-state-local-map (kbd "M-q") 'org-noter-kill-session)
      ;;(define-key evil-normal-state-local-map (kbd "C-c n h") 'org-noter-set-hide-other)
      (define-key evil-normal-state-local-map (kbd "M-s") 'org-noter-set-auto-save-last-location)
      (define-key evil-normal-state-local-map (kbd "M-.") 'org-noter-sync-next-note)
      (define-key evil-normal-state-local-map (kbd "M-,") 'org-noter-sync-prev-note)
      (define-key evil-normal-state-local-map (kbd "M-/") 'org-noter-sync-current-note)
      ;;(define-key evil-normal-state-local-map (kbd "M-}") 'org-noter-sync-next-page-or-chapter)
      ;;(define-key evil-normal-state-local-map (kbd "M-{") 'org-noter-sync-prev-page-or-chapter)
      (define-key evil-normal-state-local-map (kbd "M-c") 'org-noter-sync-current-page-or-chapter)



    ;; (if my-enable-which-key-customized-description
    ;;      (progn
    ;;          ;;(which-key-add-key-based-replacements "C-c n" "Noter")
    ;;          (which-key-add-key-based-replacements "C-c n n" "Open session")
    ;;          (which-key-add-key-based-replacements "C-c n o" "Outline")
    ;;          (which-key-add-key-based-replacements "C-c n k" "Kill session")
    ;;          (which-key-add-key-based-replacements "C-c n h" "Hide other")
    ;;          (which-key-add-key-based-replacements "C-c n a" "Save last location")
    ;;          (which-key-add-key-based-replacements "C-c n c" "current")
    ;;          (which-key-add-key-based-replacements "C-c n /" "current page")
    ;;          (which-key-add-key-based-replacements "C-c n >" "next note")
    ;;          (which-key-add-key-based-replacements "C-c n <" "prev note")
    ;;          (which-key-add-key-based-replacements "C-c n ]" "next chapter note")
    ;;          (which-key-add-key-based-replacements "C-c n [" "prev chapter note")
    ;;      ))

      (message ">>> [ my-pdf-org-noter-local ] - rebind successfully. ")
  )

  (dolist (hook '(org-mode-hook
                  pdf-view-mode-hook
                  ))
     (add-hook hook #'my-org-noter-local)
  )

  ;(add-hook 'pdf-view-mode-hook #'my-rebind-spc-for-pdf-view-mode)

;;  (use-package pdf-tools)
;;
;;  (use-package org-noter
;;    :config
;;        (setq org-noter-max-short-selected-text-length 20)
;;        (setq org-noter-max-short-length 80000)
;;        (setq org-noter-always-create-frame nil) ;; Prevent use new frame!!!
;;        (setq org-noter-default-heading-title "Note from $p$ page") ;; Prevent use new frame!!!
;;        (if (> 999 (display-pixel-height)) 
;;           (setq org-noter-doc-split-fraction '(0.6 . 0.5)))
;;    :custom
;;        (org-noter-highlight-selected-text t)
;;        (org-noter-notes-search-path '("~/sbzi/personal/org-noter/"))
;;        (org-noter-auto-save-last-location t)
;;  )
;;  (define-key org-noter-doc-mode-map (kbd "M-i") nil)
;;  (define-key pdf-view-mode-map (kbd "C-u") nil)
;;  (define-key org-noter-doc-mode-map (kbd "M-i") #'dm/insert-precise)
;;
;;  (defun dm/insert-precise (&optional optional)
;;    (interactive "P")
;;    (org-noter-insert-precise-note 't))
;;
;;  ;; (push "~/workspace/org-noter-plus-djvu" load-path)
;;  ;; (push "~/workspace/org-noter-plus-djvu/other" load-path)
;;  ;; (push "~/workspace/org-noter-plus-djvu/modules" load-path)
;;
;;  ;; (require 'org-noter)
;;  ;; (require 'org-noter-nov)
;;  ;; (require 'org-noter-pdf)
;;
;;
;;  (define-advice org-noter--insert-heading (:after (level title &optional newlines-number location) add-full-body-quote)
;;    "Advice for org-noter--insert-heading.
;;
;;  When inserting a precise note insert the text of the note in the body as an org mode QUOTE block.
;;
;;  =org-noter-max-short-length= should be set to a large value to short circuit the normal behavior:
;;  =(setq org-noter-max-short-length 80000)="
;;
;;    ;; this tells us it's a precise note that's being invoked.
;;    (if (consp location)
;;        (insert (format "#+BEGIN_QUOTE\n%s\n#+END_QUOTE" title))))
;;
;;  (defun my-org-noter-local()
;;    (message ">>> [ my-pdf-org-noter-local ] ")
;;    ;;
;;    ;; Rebind
;;    ;;
;;    ;;(define-key evil-normal-state-local-map (kbd "C-c n n") 'org-noter)
;;    (define-key evil-normal-state-local-map (kbd "C-c n n") 'org-noter)
;;    (define-key evil-normal-state-local-map (kbd "M-a") 'org-noter-insert-note)
;;    (define-key evil-normal-state-local-map (kbd "M-p") 'org-noter-insert-precise-note)
;;    (define-key evil-normal-state-local-map (kbd "M-o") 'org-noter-create-skeleton)
;;    (define-key evil-normal-state-local-map (kbd "M-q") 'org-noter-kill-session)
;;    ;;(define-key evil-normal-state-local-map (kbd "C-c n h") 'org-noter-set-hide-other)
;;    (define-key evil-normal-state-local-map (kbd "M-s") 'org-noter-set-auto-save-last-location)
;;    (define-key evil-normal-state-local-map (kbd "M-/") 'org-noter-sync-next-note)
;;    (define-key evil-normal-state-local-map (kbd "M-,") 'org-noter-sync-prev-note)
;;    (define-key evil-normal-state-local-map (kbd "M-.") 'org-noter-sync-current-note)
;;    ;;(define-key evil-normal-state-local-map (kbd "M-}") 'org-noter-sync-next-page-or-chapter)
;;    ;;(define-key evil-normal-state-local-map (kbd "M-{") 'org-noter-sync-prev-page-or-chapter)
;;    (define-key evil-normal-state-local-map (kbd "M-c") 'org-noter-sync-current-page-or-chapter)
;;
;;    (message ">>> [ my-pdf-org-noter-local ] - rebind successfully. ")
;;)
;;
;;(dolist (hook '(org-mode-hook
;;                pdf-view-mode-hook
;;                ))
;;   (add-hook hook #'my-org-noter-local)
;;)

;(add-hook 'pdf-view-mode-hook #'my-rebind-spc-for-pdf-view-mode)

(use-package org-capture
:ensure nil
:bind ("C-c ;" . (lambda () (interactive) (org-capture)))
:hook ((org-capture-mode . (lambda ()
                             (setq-local org-complete-tags-always-offer-all-agenda-tags t)))
       (org-capture-mode . delete-other-windows))
:custom
(org-capture-use-agenda-date nil)
;; define common template
(org-capture-templates `(("t" "Tasks" entry (file+headline "~/sbzi/personal/org-capture/tasks.org" "Reminders")
                          "* TODO %i%?"
                          :empty-lines-after 1
                          :prepend t)
                         ("n" "Notes" entry (file+headline "~/sbzi/personal/org-capture/capture.org" "Notes")
                          "* %? %^g\n%i\n"
                          :empty-lines-after 1)
                         ;; For EWW
                         ("b" "Bookmarks" entry (file+headline "~/sbzi/personal/org-capture/capture.org" "Bookmarks")
                          "* %:description\n\n%a%?"
                          :empty-lines 1
                          :immediate-finish t)
                         ("d" "Diary")
                         ("dt" "Today's TODO list" entry (file+olp+datetree "~/sbzi/personal/org-capture/diary.org")
                          "* Today's TODO list [/]\n%T\n\n** TODO %?"
                          :empty-lines 1
                          :jump-to-captured t)
                         ("do" "Other stuff" entry (file+olp+datetree "~/sbzi/personal/org-capture/diary.org")
                          "* %?\n%T\n\n%i"
                          :empty-lines 1
                          :jump-to-captured t)
                         ))
)

(use-package denote
  :commands (denote denote-signature denote-subdirectory denote-rename-file-using-front-matter
                    denote-keywords-prompt
                    denote-rename-file
                    denote-link-or-create)
  :hook (dired-mode . denote-dired-mode-in-directories)
  :config
  (setq denote-directory (expand-file-name "~/denote"))

  (setq denote-directory (expand-file-name "~/sbzi/personal/denote/")
        denote-known-keywords '("dev" "liter" "books" "dailies" "personal")
        denote-infer-keywords t
        denote-sort-keywords t
        denote-allow-multi-word-keywords t
        denote-date-prompt-use-org-read-date t
        denote-link-fontify-backlinks t
        denote-front-matter-date-format 'org-timestamp
        denote-prompts '(title keywords)))

(define-key evil-normal-state-map (kbd "SPC n") nil)
(dolist (map (list
              evil-motion-state-map
              evil-normal-state-map
              ))
  (define-key map (kbd "SPC n") nil)
  (define-key map (kbd "SPC n l") nil)
)

(dolist (map (list
              evil-motion-state-map
              ))
  (define-key map (kbd "SPC i m") 'consult-imenu)
  (define-key map (kbd "C-c i m") 'consult-imenu)

  (define-key map (kbd "SPC n c") 'denote)
  (define-key map (kbd "SPC n o") 'denote-open-or-create)
  (define-key map (kbd "SPC n f") 'denote-type)
  (define-key map (kbd "SPC n t") 'denote-template)
  (define-key map (kbd "SPC n r") 'denote-rename-file)

  (define-key map (kbd "SPC n l a") 'denote-link)
  (define-key map (kbd "SPC n l c") 'denote-link-or-create)
  (define-key map (kbd "SPC n l r") 'denote-add-links)
  (define-key map (kbd "SPC n l f") 'denote-find-link)
  (define-key map (kbd "SPC n l b") 'denote-backlinks)
)

;;
;; 'which-key' description
;;
(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "SPC n" "Denote")
        (which-key-add-key-based-replacements "SPC n c" "Create note")
        (which-key-add-key-based-replacements "SPC n o" "Open (or create) note")
        (which-key-add-key-based-replacements "SPC n f" "Create note by file-type")
        (which-key-add-key-based-replacements "SPC n t" "Create note by template")
        (which-key-add-key-based-replacements "SPC n r" "Rename")
        (which-key-add-key-based-replacements "SPC n l" "Denote Links")
        (which-key-add-key-based-replacements "SPC n l a" "Add link")
        (which-key-add-key-based-replacements "SPC n l c" "Add (or create) link")
        (which-key-add-key-based-replacements "SPC n l r" "Regexp links")
        (which-key-add-key-based-replacements "SPC n l f" "Find links")
        (which-key-add-key-based-replacements "SPC n l b" "Back-links")
    ))

(message ">>>>>>>>>")
