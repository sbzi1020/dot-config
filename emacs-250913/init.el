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

(if (fboundp 'menu-bar-mode)
  (menu-bar-mode -1)
)
(if (fboundp 'tool-bar-mode)
  (tool-bar-mode -1)
)
(if (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1)
)

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
         ("\\*Help"
             (display-buffer-reuse-window display-buffer-in-side-window)
             (side . right)
             (window-width . 0.5)
         )
         ("\\*Embark"
             (display-buffer-reuse-window display-buffer-in-side-window)
             (side . right)
             (window-width . 0.5)
         )
         ("\\*Shell"
             (display-buffer-reuse-window display-buffer-in-side-window)
             (side . right)
             (window-width . 0.5)
         )
       )
)

(setq tab-width 4)

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
;; (load-library "YOUR_LIB_FILENAME_HERE")
;; (CALL_YOUR_MODULE_FUNCTION)
;;
;; For example:
;; (load-library "libemacs-module-demo")
;; (get-module-version)
;; (get-module-version-string)
;;
(push (expand-file-name "~/zig/emacs-module-template/zig-out/lib") load-path)

(push "~/.config/emacs/lib" load-path)

(setq async-shell-command-buffer 'confirm-kill-process)

(push 'flex completion-styles)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Only use to install 'chatgpt'
;; (add-to-list 'package-archives '( "jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/") t)

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
	:disabled
	:defer t
	:hook (prog-mode . highlight-indent-guides-mode)
	:config
		(setq highlight-indent-guides-method 'character)
		;; (setq highlight-indent-guides-method 'bitmap)
		;; (setq highlight-indent-guides-method 'column)
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
           (odin-rg-search-v2 buffer) ;; This is important !!!
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

(consult-customize consult-ripgrep :group nil)

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

(defun embark-disable-line-number ()
	(display-line-numbers-mode -1)
)

(add-hook 'embark-collect-mode-hook #'embark-disable-line-number)

;;
;; Evil custom settings, you can found all settings here:
;; https://evil.readthedocs.io/en/latest/settings.html
;;

;;
;; Set the following modes to 'normal state after 'evil-mode' loaded
;;
;; Why do this?
;; 
;; If the buffer switches to 'Evil-Normal-State' by default, then the upcomming
;; keybindins "(evil-global-set-key 'normal)" which targets to 'normal' state will
;; work automatically.
;; 
;; That will save a lot of keybinding settings.
;;
;; More info, run 'info' and goto the section: evil -> evil -> settings -> The initial state
;;
(defun my-evil-default-to-normal-state-for-these-modes ()
	(dolist (mode '(
				helpful-mode
				help-mode
				messages-buffer-mode
				emacs-lisp-compilation-mode
				debugger-mode
				package-menu-mode
				term-mode
				custom-mode
				org-mode
				org-agenda-mode
				fundamental-mode
				shell-command-mode
				snippet-mode
			))

		;;
		;; I have no idea why this doesn't for the 'messages-buffer-mode' (only this mode)!!!
		;;
	    (evil-set-initial-state mode 'normal)

		(message ">>> Evil set inital state to 'normal' for '%s'" mode)

	)
)

;;
;; By default, `evil-repeat` repeats the last command when pressing `.` key. If you DO NOT
;; want some commands to be repeatable, then you should use `evil-declare-abort-repeat`
;; to disable them.
;;
;; Here is the default disabled settings:
;;
;; File: ~/.config/emacs/elpa/evil-20230828.1342/evil-integration.el
;; (mapc #'evil-declare-abort-repeat
;;       '(balance-windows
;;         eval-expression
;;         execute-extended-command
;;         exit-minibuffer
;;         compile
;;         delete-window
;;         delete-other-windows
;;         find-file-at-point
;;         ffap-other-window
;;         recompile
;;         redo
;;         save-buffer
;;         split-window
;;         split-window-horizontally
;;         split-window-vertically
;;         undo
;;         undo-tree-redo
;;         undo-tree-undo))
(defun my-evil-disable-repeatable-for-these-functions ()
	;;
	;; I don't want the following commands to be repeatable!!!
	;;
	(mapc #'evil-declare-abort-repeat
	      '(my-search-next            ; 'n' for next search
	        my-search-previous        ; 'N' for prev search
	        flymake-goto-next-error   ; '<C-n>' for next LSP error
	        flymake-goto-prev-error   ; '<C-p>' for prev LSP error
	       )
	)
)

;;
;;
;;
(use-package evil
	:init
	(setq
		evil-auto-indent t          ; Enable auto indent
		evil-echo-state t           ; State/mode in status bar
		evil-want-C-u-scroll t      ; Enable <C-u> scroll up
		evil-want-C-i-jump t        ; <C-i> inserts a tab character
		evil-want-Y-yank-to-eol t   ; Enable `Y`: Yank to end of line
		evil-vsplit-window-right t  ; Always vsplit window on the rigth
		evil-want-integration t     ; This is optional since it's already set to t by default.
		evil-want-keybinding nil
	)

	:custom
	(evil-undo-system 'undo-redo)

	:config
	(evil-mode 1)

	;; Leader key
	(evil-set-leader '(normal visual) (kbd "SPC"))
	(my-evil-disable-repeatable-for-these-functions)
)

;;
;; 'my-evil-default-to-normal-state-for-these-modes' has to be called when all 'xxx-mode'
;; are avaiable. Otherwise, it won't be called for some modes!!!
;;
;; That's why you should call this function for the 'after-init-hook', as all 'xxx-mode'
;; should be ready after the frame has been inited.
;;
(add-hook
	'after-init-hook
	(lambda ()
		(my-evil-default-to-normal-state-for-these-modes)
		(message ">>> 'my-evil-default-to-normal-state-for-these-modes' has been called by 'after-init-hook'")
	)
)

;;
;; 
;;
(use-package evil-collection
	:after evil
	:config
		(evil-collection-init)
)

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

(setq org-src-window-setup 'current-window)
;; (setq org-src-window-setup 'split-window-rIght)

(defun my/org-mode-setup ()
	(interactive)
	(org-indent-mode)           ;; Enable org indent mode
	(variable-pitch-mode -1)
	(visual-line-mode 1)

	;;
	;; Heading font size (only works in GUI mode)
	;; 
	;; But the following settings only work in 'GUI' mode, nothing will happen in 'Terminal' mode!!!
	;;
	(dolist (face '((org-level-1 . 1.5)
					(org-level-2 . 1.3)
					(org-level-3 . 1.2)
					(org-level-4 . 1.1)
					(org-level-5 . 1.0)
					(org-level-6 . 1.0)
					(org-level-7 . 1.0)))
		(set-face-attribute (car face) nil
							:height (cdr face))
	)
	(message ">>> [ my/org-mode-setup ] - called")
)

(use-package org
	:hook (org-mode . my/org-mode-setup)
	:config
	(setq org-ellipsis " ..."			; Ellipsis string when `S-TAB`
		org-hide-emphasis-markers t		; Hide the marker (bold, link etc)
		))

(use-package org-bullets
	:after org
	:init
		;; (setq org-bullets-bullet-list '("" "" ">" "●" "◆" "*"))
		;; (setq org-bullets-bullet-list '("①" "②" "③" "④" "⑤" "⑥"))
		(setq org-bullets-bullet-list '("➊" "➋" "➌" "➍" "➎" "➏"))
	:hook (org-mode . org-bullets-mode)
)

(defun disable-line-number ()
	(display-line-numbers-mode -1)
)

(add-hook 'org-mode-hook #'disable-line-number)

(use-package org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(setq org-agenda-files
	'(
		 "~/.config/emacs/todo.org"
	)
)

(use-package rg
  :config
       (setq rg-command-line-flags (list "--trim"))
       (setq rg-group-result nil) ;; "--no-heading"
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
    (hare "https://git.sr.ht/~ecs/tree-sitter-hare")
    (odin "https://github.com/amaanq/tree-sitter-odin")
    (lua "https://github.com/MunifTanjim/tree-sitter-lua")
    ;(hare "https://git.sr.ht/~rockorager/tree-sitter-hare")
    ;(hare "https://git.sr.ht/~ghishadow/tree-sitter-hare")
    ;(hare "https://github.com/amaanq/tree-sitter-hare")
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
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ha\\'" . hare-ts-mode))
(add-to-list 'auto-mode-alist '("\\.odin\\'" . odin-ts-mode))
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-ts-mode))

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
   (make-mode . make-ts-mode)
   (json-mode . json-ts-mode)
   (js-json-mode . json-ts-mode)
   (python-mode . python-ts-mode)
   (tsx-mode . tsx-ts-mode)
   (typescript-mode . typescript-ts-mode)
   (js-mode . js-ts-mode)
   (yaml-mode . yaml-ts-mode)
   (java-mode . java-ts-mode)
   (hare-mode . hare-ts-mode)
   (odin-mode . odin-ts-mode)
  )
)

(use-package denote
  :init
      ;;
      ;; Where your denotes save to
      ;;
      (setq denote-directory(expand-file-name "~/my-notes"))

      ;;
      ;; Your denote default file type, 'nil' means use 'org' file
      ;;
      ;; Value is one of these options: nil/markdown-yaml/markdown-toml/text
      ;;
      (setq denote-file-type nil)

      ;;
      ;; Default keyword list, this is the fixed value list.
      ;;
      ;; By default, the 'denote-infer-keywords' is set to 't', that said denote
      ;; tries to walk through the 'denote-directory' to extract all keywords from
      ;; the filename and add to the list. If you don't want this behavior then
      ;; set it to 'nil'.
      ;;
      (setq denote-known-keywords '("Zig" "C"  "Todo" "ProblemAndSolution" "Misc"))

      ;;
      ;; What steps do I want to in the prompt?
      ;;
      ;; 1. Ask me the 'title' of the note
      ;;
      ;; 2. Ask me the 'keywords' of the note, multiple keywords separated by ','
      ;;
      ;; 3. Ask me the 'sub directory' of the note (related to 'denote-directory')
      ;;
      ;;
      ;; 'denote-prompts's value is a list with the following options:
      ;;
      ;; title/keywords/file-type/subdirectory/date
      ;;
      (setq denote-prompts '(title keywords subdirectory))
)

(use-package zig-mode)

(use-package rust-mode)

(use-package fish-mode)

(use-package markdown-mode)

(use-package typescript-mode
  :mode "\\.ts\\'"
  :config
  (setq typescript-indent-level 4)
)

;; (use-package web-mode
;;   :config
;;       (setq web-mode-markup-indent-offset 4
;;             web-mode-css-indent-offset 4
;;             web-mode-code-indent-offset 4
;;             web-mode-style-padding 4
;;             web-mode-script-padding 4
;;             web-mode-enable-auto-closing t
;;             web-mode-enable-auto-opening t
;;             web-mode-enable-auto-pairing t
;;             web-mode-enable-auto-indentation t)
;;   :mode
;;       (".html$" "*css$" "*.tsx")
;; )

(use-package evil-commentary
    :defer t
    :hook (prog-mode . evil-commentary-mode)
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

    (add-hook 'org-mode-hook #'yas-minor-mode)
    (add-hook 'prog-mode-hook #'yas-minor-mode)
    ;; (add-hook 'c-ts-mode-hook #'yas-minor-mode)
    ;; (add-hook 'c++-ts-mode-hook #'yas-minor-mode)
    ;; (add-hook 'rust-ts-mode-hook #'yas-minor-mode)
    ;; (add-hook 'zig-mode-hook #'yas-minor-mode)
    ;; (add-hook 'zig-ts-mode-hook #'yas-minor-mode)
    ;; (add-hook 'org-mode-hook #'yas-minor-mode)
    ;; (add-hook 'cmake-ts-mode-hook #'yas-minor-mode)
    ;; (add-hook 'js-ts-mode-hook #'yas-minor-mode)
    ;; (add-hook 'typescript-ts-mode-hook #'yas-minor-mode)
    ;; (add-hook 'hare-mode-hook #'yas-minor-mode)
    ;; (add-hook 'hare-ts-mode-hook #'yas-minor-mode)
	;; (add-hook 'emacs-lisp-mode-hook #'yas-minor-mode)
	;; (add-hook 'lisp-interaction-mode #'yas-minor-mode)

    ;;
    ;; Fix 'company' can't list 'yasnippet' candidates in dropdown list
    ;;
    (add-hook 'eglot-managed-mode-hook #'my-fix-company-yasnippet)

	;;
	;; Fix 'company' can't list 'yasnippet' in the following modes,
	;; as those modes won't trigger 'eglot' (NO LSP support yet)!!!
	;;
	(add-hook 'prog-mode-hook #'my-fix-company-yasnippet)
	;; (add-hook 'hare-mode-hook #'my-fix-company-yasnippet)
	;; (add-hook 'hare-ts-mode-hook #'my-fix-company-yasnippet)
	;; (add-hook 'emacs-lisp-mode-hook #'my-fix-company-yasnippet)
	;; (add-hook 'lisp-interaction-mode #'my-fix-company-yasnippet)
)

(use-package company
  :custom
     (company-minimum-prefix-length 2)
     (company-idel-delay 0.0)
  :config
      ;;
      ;; Enable completion for all buffers
      ;;
      (global-company-mode 1)
)

;;
;; A company front-end with icons.
;;
(use-package company-box
  :hook (company-mode . company-box-mode))

;;
;; The command name as 'symbol'
;;
(push 'odin compilation-error-regexp-alist)

;;
;; The real error regex
;;
(add-to-list
	'compilation-error-regexp-alist-alist
	'(
		;;
		;; The 'symbol' that you use in 'compilation-error-regexp-alist'
		;;
		odin

		;;
		;; Regex pattern to match: '/path/file.odin(line:column) '
		;;
		;; Here are the rules:
		;;
		;; The regex has different match groups in order:
		;; 'FILE [LINE COLUMN TYPE HYPERLINK HIGHLIGHT...]'
		;;
		;; The first 'FILE' group is a must, and the other groups are optional.
		;;
		"^\\([^(\n]+\\)(\\([0-9]+\\):\\([0-9]+\\))\\ .*$"

		;;
		;; The rest parts to indicated which group is for what
		;;
		1	; FILE group
		2	; LINE group
		3	; COLUMN group
	)
)

;; (setq init_options (concat (getenv "HOME") "/odin/odin-utils"))
(with-eval-after-load 'eglot
	(add-to-list 'eglot-server-programs
		`(
			(odin-mode odin-ts-mode)
			.
			(
				"ols"
				:initializationOptions
				(:collections
					(
						:name "utils"
						:path "/home/wison/odin/odin-utils" 
					)
				)
			)
		)
	)
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
    (keymap-set evil-insert-state-local-map "TAB" 'tab-to-tab-stop)

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

    (setq lisp-indent-offset my-tab-width)  ;; Default is 2

    ;;
    ;; Back to normal TAB behavior rather than 'indent-for-tab-command'
    ;;
    (keymap-set evil-insert-state-local-map "TAB" 'tab-to-tab-stop)

    (message ">>> my-emacs-lisp-style-settings [done]")
)


;;
;; 
;;
(defun my-js-ts-style-settings()
    ;;
    ;; Very important to reset!!!
    ;;
    (setq tab-width my-tab-width)                

    ;;
    ;; Back to normal TAB behavior rather than 'indent-for-tab-command' 
    ;;
    (keymap-set evil-insert-state-local-map "TAB" 'tab-to-tab-stop)

    (message ">>> my-js-ts-style-settings [done]")
)


(add-hook 'c-mode-hook #'my-c-style-settings)
(add-hook 'c-ts-mode-hook #'my-c-style-settings)
(add-hook 'c++-ts-mode-hook #'my-c-style-settings)
(add-hook 'zig-mode-hook #'my-c-style-settings)
(add-hook 'rust-ts-mode-hook #'my-c-style-settings)
(add-hook 'emacs-lisp-mode-hook #'my-emacs-lisp-style-settings)
(add-hook 'lisp-interaction-mode-hook #'my-emacs-lisp-style-settings)
(add-hook 'snippet-mode-hook #'my-emacs-lisp-style-settings)
(add-hook 'cmake-ts-mode-hook #'my-c-style-settings)
(add-hook 'typescript-ts-mode-hook #'my-js-ts-style-settings)
(add-hook 'js-ts-mode-hook #'my-js-ts-style-settings)
(add-hook 'java-ts-mode-hook #'my-js-ts-style-settings)

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
                cmake-ts-mode-hook
                js-ts-mode-hook
                typescript-ts-mode-hook
                java-ts-mode-hook
                odin-ts-mode-hook
                ))
   (add-hook hook #'start-eglot)
)

;;
;; I hate Emacs asks me every time I if I didn't save the abbrev talbe!!!
;;
(setq save-abbrevs nil)

;;
;; As I re-create all my abbrevs on the fly after Emacs has been loaded,
;; that's why I don't need this!!!
;;
;; (setq abbrev-file-name "")

;;
;; This is a special hook function that prevents inserting the 'space'
;; when expanding your abbrev!!!
;;
;; Here the doc info about that part
;; Signature
;; (define-abbrev TABLE ABBREV EXPANSION &optional HOOK &rest PROPS)
;;
;; If HOOK is 'non-nil', it should be a function of no arguments;
;;
;; If HOOK is a 'non-nil' 'symbol' with a 'non-nil' 'no-self-insert' property,
;; it can control whether the character that triggered abbrev expansion
;; is inserted ('space' in default case).
;; If such a HOOK returns 'non-nil', the character is not inserted.
;; If such a HOOK returns 'nil', then so does abbrev-insert (and expand-abbrev),
;; as if no abbrev expansion had taken place.
;;
(defun not-insert-space () t)
(put 'not-insert-space 'no-self-insert t)

;;
;; Insert now datetime with default format: Wed Aug 27 17:56:23 2025
;;
(defun my-abbr-now ()
    "Abbr expension to now datetime"
	(insert (current-time-string))
	t
)
(put 'my-abbr-now 'no-self-insert t)

;;
;; Insert now datetime with this format: 2025-08-27 17:56:27
;;
(defun my-abbr-now-only-date ()
    "Abbr expension to now datetime"
	(insert (format-time-string "%Y-%m-%d %H:%M:%S"))
	t
)
(put 'my-abbr-now-only-date 'no-self-insert t)

;;
;; Insert now datetime with this format: 17:56:27
;;
(defun my-abbr-now-only-time ()
    "Abbr expension to now datetime"
	(insert (format-time-string "%H:%M:%S"))
	t
)
(put 'my-abbr-now-only-time 'no-self-insert t)

(defun my-load-addbrevs-from-file ()
	;;
	;; Load my file
	;;
	(load  "~/.config/emacs/my-abbrevs.el")

	;;
	;; Enable 'abbrev-mode' by hooks
	;;
	;; 'text-mode' covers a lot another modes
	;; 'prog-mode' covers all programming modes
	;;
	(add-hook 'text-mode-hook #'abbrev-mode)
	(add-hook 'prog-mode-hook #'abbrev-mode)
)

(add-hook 'after-init-hook #'my-load-addbrevs-from-file)

(use-package nerd-icons)

(use-package doom-themes
    ;; :disabled
    :config
    ;; Global settings (defaults)
    (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
          doom-themes-enable-italic t) ; if nil, italics is universally disabled

    ;; Load theme, pick the one you like
    ;; (load-theme 'doom-gruvbox t)
    ;;(load-theme 'doom-nord-aurora t)
    ;;(load-theme 'doom-one t)
    ;;(load-theme 'doom-solarized-dark t)
    ;;(load-theme 'doom-pine t)
    ;;(load-theme 'doom-zenburn t)
    ;;(load-theme 'doom-laserwave t)
    ;;(load-theme 'doom-henna t)
    ;;(load-theme 'doom-xcode t)
    ;;(load-theme 'doom-lantern t)
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

(use-package ef-themes
    ;; :disabled
    :config
)

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")

;; Gloden cursor, only effects the 'GUI' mode
(setq tron-legacy-theme-vivid-cursor t)

;; The foreground to be dimmed and comments to be brighter
;; (setq tron-legacy-theme-dark-fg-bright-comments t)

;; changes the background color to a dark gunmetal grey,
;; instead of the default pure black. It doesn't work, as I
;; set a solid background color in 'settings.org'!!!
;; (setq tron-legacy-theme-softer-bg t)

;; (load-theme 'my-tron-legacy t)

;; -------------------------------------------------------------------------------
;; All custom faces (font settings)
;; -------------------------------------------------------------------------------
;; (defface my-modeline-light-blue-font '((t :foreground "#ACE6FE" :inherit italic bold)) "Modeline light blue font")
;; (defface my-modeline-blue-green-font '((t :foreground "#4BB5BE")) "Modeline blue-green font")
;; (defface my-modeline-light-orange-font '((t :foreground "#DEB45B")) "Modeline light-orange font")
;; (defface my-modeline-orange-font '((t :foreground "#FF9F1C")) "Modeline orange font")
;; (defface my-modeline-yellow-font '((t :foreground "#FFE64D")) "Modeline yellow font")
;; (defface my-modeline-light-red-font '((t :foreground "#f44747")) "Modeline light-red font")
;; (defface my-modeline-light-green-font '((t :foreground "#BBF0EF")) "Modeline light-green font")
;; (defface my-modeline-dark-green-font '((t :foreground "#5A7387")) "Modeline dark-green font")


;; -------------------------------------------------------------------------------
;; Override the default face for change mode line background
;; -------------------------------------------------------------------------------
;; (set-face-attribute 'mode-line-active nil :background "#2F2F2F")
;; (set-face-attribute 'mode-line-inactive nil :background nil)


;; -------------------------------------------------------------------------------
;; All modeline variables
;; -------------------------------------------------------------------------------

;;
;; 'my-modeline-major-mode' variable related
;;

(defun my-get-major-mode ()
	"Return 'major-mode' as a string but discard the '-mode' part."
	(string-replace "-mode" "" (symbol-name major-mode)))

(defun my-get-major-mode-2 ()
	"Return 'major-mode' as a string."
	(symbol-name major-mode))

(defun my-get-major-mode-capitalize ()
	"Return capitalized 'major-mode' as a string."
	(capitalize (string-replace "-mode" "" (symbol-name major-mode))))

(defvar-local my-modeline-major-mode
	'(:eval
		(propertize (my-get-major-mode-2)
			'face '(
					   :weight bold
					   :slant italic
					   ;; :background (face-attribute 'eglot-mode-line :background nil 'default)
					   ;;:background "red"
					)
			;; 'face 'my-modeline-orange-font
		)
	)
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
		 (propertize (my-get-current-name))
	)
	"Mode line constructor to display buffer name"
)

(defvar-local my-modeline-buffer-file-name
	'(:eval
		(propertize (format " %s" (buffer-file-name))))
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
			(propertize (my-get-evil-state)
				'face '(:weight bold)
			)
		)
	)
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
				(propertize (my-get-git-branch-name))
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
		)
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
			(format " %s %s" (my-get-lsp-warning-indicator) count))
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
			(format " %s %s" (my-get-lsp-note-indicator) count))
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
(dolist (my-var '(
					my-modeline-major-mode
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
		;; my-modeline-git-branch
		;; "  "
		my-modeline-flymake
		"  "
		my-modeline-misc-info
	)
)

(add-hook
	'emacs-startup-hook
	;; 'after-init-hook
	(lambda ()
		(let (
				;; (theme 'ef-cyprus)
				;; (theme 'ef-melissa-light)
				;; (theme 'ef-melissa-dark)
				;; (theme 'ef-elea-dark)
				;; (theme 'ef-bio)
				;; (theme 'ef-autumn)
				;; (theme 'ef-rosa)
				;; (theme 'doom-henna)
				;; (theme 'doom-plain-dark)
				;; (theme 'doom-plain)
				;; (theme 'doom-nord)
				(theme 'doom-nord-aurora)
				;; (theme 'doom-lantern)
				;; (theme 'doom-pine)
				;; (theme 'doom-horizon)
				;; (theme 'doom-zenburn)
				;; (theme 'doom-old-hope)
				;; (theme 'doom-laserwave)
				;; (theme 'doom-monokai-pro)
				;; (theme 'doom-gruvbox)
				;; (theme 'my-tron-legacy)

				;; (gui-theme 'nano)
				(gui-theme 'nano-light)
				;; (gui-theme 'nano-dark)
			)

			;; (consult-theme my-current-theme)
			(if (display-graphic-p nil)
				;;
				;; GUI, load 'nano-light'
				;;
				(progn
					(my-consult-theme gui-theme)
					(message ">>> Loaded 'gui-theme': %s" gui-theme))

				;;
				;; TUI, load 'theme'
				;;
				(progn
					(my-consult-theme theme)
					(message ">>> Loaded 'tui-theme': %s" theme))
			)

		)
	)
)

;;
;; A company front-end with icons.
;;
(use-package rainbow-mode
  :hook (minibuffer-setup . rainbow-mode))

;;
;; Debug flag
;;
(setq project-command-debug-enable nil)
;; (setq project-command-debug-enable t)

;;
;; Logger prefix
;;
(setq project-command-logger-prefix ">>> [ Project command ] -")

(defun project-command/create-script-files-cmd-list (dir)
	"Return the script files command list from the given project directory"
	(let (return_list '())
		;; (message
		;; 	"%s 'project_command/create_script_files_cmd_list' get called with %s"
		;; 	PROJECT_COMMAND_LOGGER_PREFIX
		;; 	dir)

		;;
		;; Filter the '.sh' file in 'dir'
		;;
		(setq filenames (directory-files dir))
		(dolist (filename filenames)
			(setq ext (url-file-extension filename))
			;; (message "%s ext: %s" PROJECT_COMMAND_LOGGER_PREFIX ext)

			(if (string-equal-ignore-case ext ".sh")
				(progn
					(add-to-list 'return_list (concat "./" filename) t)
					;; (message
					;; 	"%s filename: %s, ext: %s"
					;; 	PROJECT_COMMAND_LOGGER_PREFIX
					;; 	filename
					;; 	ext)
				))
		)

		;; Return the flatten list
		(append return_list)
	)
)


(defvar
	project-command-hashmap
	(make-hash-table :test 'equal)
	" Project command hashmap:

key: A string, the project root directory

value: A 'plist' with the following properties:

	'selected-cmd - Last cmd selected by the user
	'cmd-list - Project cmd filename list
")


(defun project-command/run (&optional enable-script-files)
	"Run a prompt to choose a command inside the current project to run"
	(let
		(
			(current-project-dir (project-root (project-current t)))
			(current-project-value '()) ;; It's a 'plist'!!!
			(current-project-cmd-list '()) ;; It's a normal string 'list'
			(current-selected-cmd "")
		)

		;;
		;; Get back the value by 'current-project-dir'
		;;
		(setq current-project-value
			(gethash current-project-dir project-command-hashmap))

		(if project-command-debug-enable
			(message
				"%s current-project-value: %s"
				project-command-logger-prefix
				current-project-value))

		;;
		;; Add init value if 'current-project-value' is 'nil'
		;;
		(if (not current-project-value)
			(progn
				;;
				;; Prefill
				;;
				(if enable-script-files
					(setq current-project-cmd-list
						(project-command/create-script-files-cmd-list current-project-dir)))

				;;
				;; Add key-value pair to 'project-command-hashmap'
				;;
				(puthash
					current-project-dir (list
											'selected-cmd ""
											'cmd-list current-project-cmd-list)
					project-command-hashmap)

				;;
				;; Update 'current-project-value' after init
				;;
				(setq current-project-value
					(gethash current-project-dir project-command-hashmap))


				;;
				;; Debug stuff
				;;
				(if project-command-debug-enable
					(message
						"%s current-project-value (after init): %s"
						project-command-logger-prefix
						current-project-value))))

		;;
		;; Take out the properties from 'current-project-value' (it's a 'plist')
		;;
		(setq current-selected-cmd (plist-get current-project-value 'selected-cmd))
		(setq current-project-cmd-list (plist-get current-project-value 'cmd-list))

		;;
		;; Debug stuff
		;;
		(if project-command-debug-enable
			(message
				(concat
					"%s {"
					"\n\tproject-dir: %s"
					"\n\tproject-selected-cmd: %s"
					"\n\tproject-cmd-list: %s"
					"\n}"
					)
				project-command-logger-prefix
				current-project-dir
				current-selected-cmd
				current-project-cmd-list
				))

		;;
		;; Show a prompt and set the user 'selected_cmd'
		;;
		(setq current-selected-cmd (completing-read
			;;
			;; The prompt
			;;
			"Project commands: "								

			;;
			;; List: can be either
			;;
			;; - A 'list' instance, e.g: (list "./configure.sh" "./run.sh" "./run-test.sh")
			;; - A 'list' variable name, e.g: cmd-list
			;; - A 'function': the function is solely responsible for performing completion; 'completion-read'
			;;                 returns whatever this function returns. The function is called with three
			;;                 arguments: 'string predicate nil'
			;;
			;;				   You can read more from 'Programmed completion':
			;;				   https://www.gnu.org/software/emacs/manual/html_node/elisp/Programmed-Completion.html
			;; 
			current-project-cmd-list

			;;
			;; 'PREDICATE' function (not provided)
			;;
			nil

			;;
			;; 'REQUIRE-MATCH': input must match in the 'List'
			;;
			;; - t means that the user is not allowed to exit unless the input is (or
			;;   completes to) an element of COLLECTION or is null.
			;;
			;; - nil means that the user can exit with any input.
			;;
			;; - confirm means that the user can exit with any input, but she needs
			;;   to confirm her choice if the input is not an element of COLLECTION.
			;;
			'confirm

			;;
			;; 'INIT-INPUT': simulate you type in the input area
			;;
			nil

			;;
			;; 'HIST': History list (not provided)
			;;
			nil

			;;
			;; 'DEF': Default value, put it to the top position!!!
			;;
			current-selected-cmd
		))
		(if project-command-debug-enable
			(message
				"%s You selected the command: %s" 
				project-command-logger-prefix
				current-selected-cmd))

		;;
		;; If 'current-selected-cmd' is NOT empty, do the following steps
		;;
		(if (not (string-empty-p current-selected-cmd))
			(progn
				;;
				;; add it to 'current-project-cmd-list' if it doesn't exists yet.
				;;
				(add-to-list 'current-project-cmd-list current-selected-cmd t)

				;;
				;; After that, update the 'current-project-value'
				;;
				(plist-put current-project-value 'selected-cmd current-selected-cmd)
				(plist-put current-project-value 'cmd-list current-project-cmd-list)

				;;
				;; And put it back to the 'project-command-hashmap'!!!
				;;
				(puthash
					current-project-dir
					current-project-value
					project-command-hashmap)

				;;
				;; Finally, call the 'compile' on the 'current-selected-cmd'!!!
				;;
				(let ((default-directory current-project-dir)
						(compilation-buffer-name-function
						(or project-compilation-buffer-name-function
							compilation-buffer-name-function)))
					(compile current-selected-cmd))

				))

	)
)

;;
;;
;;
(defun project-command/run-with-enable-script-files ()
	"Run a prompt to choose a command to run. It calls 'project_command/run' internally and passes 't' to
it by default, which means pre-filling all scripts '*.sh' into the command list. You can set it to 'nil'
if you don't want to do this..

Also, inside the pop-up command list UI, you can type a new command that doesn't exist in the pre-filled
command list; it will be added to the command list after your confirmation.

After pressing 'RET' to run the selected command, a reused buffer will be shown int the right side window
(always) to present the command's output.

If there is an error inside the output buffer, you can jump to the error line and press 'RET'; it will
bring you to the source and automatically locate the error position.

By defualt, the output buffer doesn't scroll to the bottom for you. If you want this, you can set the
'compilation-scroll-output' global variable to 't'"
	(interactive)
	(project-command/run t)
)

(consult-customize consult-ripgrep :group nil)

;;
;; My version of 'consult--grep' to disable the grouping feature
;;
(defun my-consult--grep (prompt make-builder dir initial)
	"My version of 'consult--grep' to disable the group feature"
	(pcase-let* ((`(,prompt ,paths ,dir) (consult--directory-prompt prompt dir))
				(default-directory dir)
				(builder (funcall make-builder paths)))
		(consult--read
			(consult--process-collection builder
			:transform (consult--grep-format builder)
			:file-handler t)
			:prompt prompt
			:lookup #'consult--lookup-member
			:state (consult--grep-state)
			:initial initial
			:add-history (thing-at-point 'symbol)
			:require-match t
			:category 'consult-grep

			;;
			;; This is the key setting to disable the grouping feature in the ripgrep result minibuffer!!!
			;;
			:group nil

			:history '(:input consult--grep-history)
			:sort nil
		)
	)
)

;;
;; My version of 'consult-ripgrep' to call 'my-consult--grep'
;;
(defun my-consult-ripgrep (&optional dir initial)
	"My version of 'consult-ripgrep' to call 'my-consult--grep'"
	(interactive "P")
	(my-consult--grep "Ripgrep" #'consult--ripgrep-make-builder dir initial)
)

;;
;; Enable debug log flag
;;
;; (setq my-enable-ca-debug-log t)
(setq my-enable-ca-debug-log nil)

(defun my-rg-search-sync (directory search-regex)
	"Run 'rg' with 'search-regex' on 'directory' in a separate process synchronously. This function
returns a list containing two elements in the following difference cases:

- If 'rg' runs successfully, the first element is the 'success symbol and the second element is the
process stdout string.

- If 'rg' runs but fails with error, the first element is the 'fail symbol and the second element is
the process stdout string (as error).

- If 'rg' fails to run, the first element is the 'error symbol and the second element is the error
message string.
"
	(let* (
			(process-self)
			(process-name (concat "rg-search-" (format-time-string "%s")))
			(process-buffer-name (concat "*-" process-name "-*"))
			(process-exit-code)
			(stdout)
		)

		(if my-enable-ca-debug-log
			(progn
				(message (concat
							">>> [ my-rg-search-sync ] - {"
							"\n\tdirectory: %s"
							"\n\tsearch-regex: %s"
							"\n\tprocess-buffer-name: %s"
							"\n}"
					)
					directory
					search-regex
					process-buffer-name))
		)

		(condition-case err
			(progn
				(setq
					process-self
					(make-process
						;;
						;; Unique process name 'rg-search-CURRENT_TIME_IN_SECONDS'
						;;
						:name process-name

						;;
						;; 'nil' means that this process is not associated with any buffer.
						;; can be a 'Buffer' or a buffer name string
						;;
						:buffer process-buffer-name

						;;
						;; Command list: (program-file-name args)
						;;
						:command (list
									"rg"
									"--line-number"
									"--line-buffered"
									"--no-heading"
									"--with-filename"
									"--color=never"
									"--path-separator=/"
									"--smart-case"
									search-regex
									directory
								)

						;;
						;; Use this 'sentinel' setting to avoid adding the 'Process xxx yyy' final
						;; to the process's buffer!!!
						;;
						:sentinel #'ignore
					))

				;;
				;; Wait for it to finish
				;;
				(while (process-live-p process-self)
					(accept-process-output process-self 0.05))

				;;
				;; Check exit code
				;;
				(setq process-exit-code (process-exit-status process-self))
				(if my-enable-ca-debug-log
					(message ">>> [ my-rg-search-sync ] - process-exit-code: %s" process-exit-code))

				;;
				;; Return different results based on the 'exit' code
				;;
				(cond
					((equal process-exit-code 0)
						(with-current-buffer (process-buffer process-self)
							(setq stdout (buffer-string)))
						;;
						;; It's very important to kill the process' buffer, otherwise, it has a chance
						;; to overlap the previous buffer's content!!!
						;;
						(kill-buffer (process-buffer process-self))
						;; Return the list
						(list 'success stdout))
					(t
						(with-current-buffer (process-buffer process-self)
							(setq stdout (buffer-string)))
						;;
						;; It's very important to kill the process' buffer, otherwise, it has a chance
						;; to overlap the previous buffer's content!!!
						;;
						(kill-buffer (process-buffer process-self))
						;; Return the list
						(list 'fail stdout))
				)
			)

			(file-missing
				(if my-enable-ca-debug-log
					(message ">>> [ my-rg-search-sync ] - error: %s" err))
				(list 'error err)
			)
			(error
				(if my-enable-ca-debug-log
					(message ">>> [ my-rg-search-sync ] - catch everthing: %s" err))
				(list 'error err)
			)
		)
	)
)

(defun my-rg-search-on-multiple-directories (directory-list search-regex)
	"Call 'my-rg-search-sync' with each directory inside the 'directory-list' and return a list
lines, which containing the format: 'full-path-filename:line-no:source-code'"
	(interactive)
	(let (
			 (search-result nil) ;; Holds each 'my-rg-search-sync' result
			 (lines nil)
			 (result-list nil)
		)
		(dolist (dir directory-list)
			(setf search-result nil)
			(setq search-result (my-rg-search-sync dir search-regex))
			;; (message ">>> search-result: %s" search-result)

			(if (and (string= (type-of search-result) "cons") (equal (length search-result) 2))
				(let (
						(result-type (car search-result))
						(output (car (cdr search-result)))
					)
					;; (message ">>> result-type: %s" result-type)
					;; (message ">>> output type: %s, value: %s" (type-of output) output)

					(if (eq result-type 'success)
						(progn
							;; Separated by '\n' and remove the empty lines
							(setq lines (string-split output "\n" t))
							;; Flatten the 'result-list' and 'lines' into a single list
							(setq result-list (append result-list lines))))
				)
			)
		)

		;; Return value
		result-list
	)
)


(defun my-ca-go-to-definition ()
	"My code-assistant: Go to function definition that is under the cursor position"
	(interactive)
	(let* (
			;;
			;; Get function name from cursor position
			;;
			(function-name (thing-at-point 'symbol t))

			;;
			;; Get back the 'rg' search directories based on current major mode, the search order
			;; is important!!!
			;;
			(directories
				(cond
					((eq major-mode 'odin-ts-mode)
						(list
							(expand-file-name (project-root (project-current t)))
							(expand-file-name "./odin/odin-utils" (getenv "HOME"))
							(getenv "ODIN_ROOT")))
					((eq major-mode 'c-ts-mode)
						(cond
							((eq system-type 'darwin)
								(list
									(expand-file-name (project-root (project-current t)))
									(expand-file-name "./c/c-utils" (getenv "HOME"))
									"/usr/include"))
							((eq system-type 'berkeley-unix)
								(list
									(expand-file-name (project-root (project-current t)))
									(expand-file-name "./c/c-utils" (getenv "HOME"))
									"/usr/include"))
							((eq system-type 'gnu/linux)
								(list
									(expand-file-name (project-root (project-current t)))
									(expand-file-name "./c/c-utils" (getenv "HOME"))
									"/usr/include"))))
				)
			)

			;;
			;; Regex rules:
			;; - Start from the beggin of line
			;; - Before the function name, can be 0 or more 'space' or 'TAB' characters
			;; - After the function name, can be 0 or more 'space' or 'TAB' characters before '::'
			;;
			(search-regex (concat "^[ \t]*" function-name "[ \t]*:: "))

			;;
			;; The final 'rg' lines
			;;
			(result-lines nil)
		)

		(if my-enable-ca-debug-log
			(progn
				(message
					(concat
						">>> [ my-ca-go-to-definition ] - {"
						"\n\tfunction-name: %s"
						"\n\tsearch-regex: %s"
						"\n\tdirectories: %s"
						"\n}")
					function-name
					search-regex
					directories)))

		;;
		;; Get back all 'rg' result lines
		;;
		(setq result-lines
			(my-rg-search-on-multiple-directories
				directories
				search-regex))

		(if my-enable-ca-debug-log
			(progn
				(message ">>> resu lt-lines len: %s" (length result-lines))
				(dolist (line result-lines)
					(message ">>> line: %s" line))
				))

		(cond
			;;
			;; If got a single line, then open source code and go to that line no
			;;
			((= (length result-lines) 1)
				(let ((temp-list (string-split (car result-lines) ":" t)))
					(if (>= (length temp-list) 2)
						(progn
							;; Push the current position into xref history
							(xref-push-marker-stack)

							;; Jump to file and line
							(with-current-buffer (find-file (car temp-list))
								;; (message ">>> go to line: %s" (car (cdr temp-list)))
								(goto-line (string-to-number (car (cdr temp-list))))
								(evil-scroll-line-to-center nil)
							)))
				))
			;;
			;; If got more than one line, show in minibuffer and ask user to pick one
			;;
			((> (length result-lines) 1)
				(setq selected-line (completing-read
					;;
					;; The prompt
					;;
					"Go to definition: "

					;;
					;; List: can be either
					;;
					result-lines

					;;
					;; 'PREDICATE' function (not provided)
					;;
					nil

					;;
					;; 'REQUIRE-MATCH': input must match in the 'List'
					;;
					t

					;;
					;; 'INIT-INPUT': simulate you type in the input area
					;;
					nil

					;;
					;; 'HIST': History list (not provided)
					;;
					nil

					;;
					;; 'DEF': Default value, put it to the top position!!!
					;;
					nil
				))
				;; (message ">>> selected-line: %s" selected-line)

				(let ((temp-list (string-split selected-line ":" t)))
					(if (>= (length temp-list) 2)
						(progn
							;; Push the current position into xref history
							(xref-push-marker-stack)

							;; Jump to file and line
							(with-current-buffer (find-file (car temp-list))
								;; (message ">>> go to line: %s" (car (cdr temp-list)))
								(goto-line (string-to-number (car (cdr temp-list))))
								(evil-scroll-line-to-center nil)
							)))
				)
			)
		)
	)
)

;;
;; Gemini search debugging flag
;;
(setq my-enable-gemini-debug-log t)

;;
;; This is the ':sentinel' function that will be passed into 'make-process'.
;;
;; A “process sentinel” is a function that is called whenever the associated process changes status
;; for any reason, including signals (whether sent by Emacs or caused by the process's own actions)
;; that terminate, stop, or continue the process.
;;
;; The process sentinel is also called if the process exits. The sentinel receives two arguments:
;; - Process itself
;; - A string describing the type of event.
;;
;; The string describing the event looks like one of the following (but this is
;; not an exhaustive list of event strings):
;;
;; • ‘"finished\n"’.
;;
;; • ‘"deleted\n"’.
;;
;; • ‘"exited abnormally with code EXITCODE (core dumped)\n"’.  The
;;   "core dumped" part is optional, and only appears if the process
;;   dumped core.
;;
;; • ‘"failed with code FAIL-CODE\n"’.
;;
;; • ‘"SIGNAL-DESCRIPTION (core dumped)\n"’.  The SIGNAL-DESCRIPTION is
;;   a system-dependent textual description of a signal, e.g.,
;;   ‘"killed"’ for ‘SIGKILL’.  The "core dumped" part is optional, and
;;   only appears if the process dumped core.
;;
;; • ‘"open from HOST-NAME\n"’.
;;
;; • ‘"open\n"’.
;;
;; • ‘"run\n"’.
;;
;; • ‘"connection broken by remote peer\n"’.
;;
(defun my-gemini-search-sentinel (self event)
	(let (
			(output-file (process-get self 'output-file))
			(self-buffer (process-buffer self))
		)

		(if my-enable-gemini-debug-log
			(message
				">>> [ my-gemini-search-sentinel ] - process-event: %s, output-file: %s"
				event
				output-file))

		;;
		;; Succeed case: Open the output file buffer
		;;
		(when (string= event "finished\n")
			(find-file-noselect output-file)
			(pop-to-buffer
				(get-buffer (file-name-nondirectory output-file))
				'(
					(display-buffer-reuse-window display-buffer-in-side-window)
					(side . right)
					(inhibit-same-window . t)
				)
			)
		)

		;;
		;; Error case: open the output file buffer and write the stdout (error message) to that buffer
		;;
		(when (or (string-match-p "exited" event) (string-match-p "failed" event))
			(find-file-noselect output-file)

			(with-current-buffer (get-buffer (file-name-nondirectory output-file))
				(erase-buffer)
				(beginning-of-buffer)
				;; (insert "Erorr happend.")
				(insert-buffer-substring (get-buffer self-buffer))
			)

			(pop-to-buffer
				(get-buffer (file-name-nondirectory output-file))
				'(
					(display-buffer-reuse-window display-buffer-in-side-window)
					(side . right)
					(inhibit-same-window . t)
				)
			)
		)

		;;
		;; Make sure to clean up the temporary process buffer
		;;
		(when (or (string= event "finished\n") (string-match-p "exited" event))
			(if my-enable-gemini-debug-log
				(message ">>> [ my-gemini-search-sentinel ] - kill temp process buffer: %s" self-buffer))
			(kill-buffer self-buffer)
		)
	)
)

(defun my-gemini-search (prompt-text)
	"Run 'gemini' CLI with the given 'prompt-text' and save output into '~/.config/emacs/gemini-output.org'.

You need to save the following content into '~/.config/emacs/GEMINI.md' to guarantee that GEMINI always
responds in 'org' format:

```markdown
# Project: This is my emacs configuration

## Response format

- Make sure all responses text use emacs `org` format, then I can copy and paste the response text into emacs.
```
"
	(let* (
			(process-self)
			(process-name (concat "rg-search-" (format-time-string "%s")))
			(process-buffer-name (concat "*-" process-name "-*"))
			(output-file (expand-file-name ".config/emacs/gemini-output.org" (getenv "HOME")))

			;;
			;; 'cd' into the emacs configuration folder can make sure 'gemini' reads the 'GEMINI.md'!!!
			;;
			(command-list (list
							"sh"
							"-c"
							(concat
								"cd ~/.config/emacs && gemini "
								"--prompt \""
								prompt-text
								" \" > "
								output-file)))
		)

		(if my-enable-gemini-debug-log
			(message (concat
						">>> [ my-gemini-search ] - {"
						"\n\tprompt-text: %s"
						"\n\toutput-file: %s"
						"\n\tprocess-buffer-name: %s"
						"\n\tcommand-list: %s"
						"\n}"
				)
				prompt-text
				output-file
				process-buffer-name
				command-list))

		(condition-case err
			(progn
				(setq
					process-self
					(make-process
						;;
						;; Unique process name 'my-gemini-search-CURRENT_TIME_IN_SECONDS'
						;;
						:name process-name

						;;
						;; 'nil' means that this process is not associated with any buffer.
						;; can be a 'Buffer' or a buffer name string
						;;
						:buffer process-buffer-name

						;;
						;; Command list: (program-file-name args)
						;;
						:command command-list

						;;
						;;
						;;
						:sentinel #'my-gemini-search-sentinel))
				;;
				;; Put the 'output-file' into 'process-ref' properties, otherwise, you can't access
				;; 'output-file' in the ':sentinel' function, as they're runing different process
				;; instances!!!
				;;
				(process-put process-self 'output-file output-file)
			)

			(file-missing
				(if my-enable-gemini-debug-log
					(message ">>> [ my-gemini-search ] - error: %s" err))
			)
			(error
				(if my-enable-gemini-debug-log
					(message ">>> [ my-gemini-search ] - catch everthing: %s" err))
			)
		)
	)
)

(defun my-gemini-search-on-selected-text ()
	"Run 'gemini' CLI on the selected text as 'prompt-text' and save 'org' formatted output into
'~/.config/emacs/gemini-output.org'.

You need to save the following content into '~/.config/emacs/GEMINI.md' to guarantee that GEMINI always
responds in 'org' format:

```markdown
# Project: This is my emacs configuration

## Response format

- Make sure all responses text use emacs `org` format, then I can copy and paste the response text into emacs.
```
"
	(interactive)
	(let (
			 (selected-text "")
		)
		(when (use-region-p)
			(setq selected-text
				(buffer-substring-no-properties (region-beginning) (region-end))))

		(if my-enable-gemini-debug-log
				(message ">>> [ my-gemini-search-on-selected-text ] - selected-text: %s" selected-text))

		(if (not (string-empty-p selected-text))
			(progn
				(if my-enable-gemini-debug-log
					(message ">>> [ my-gemini-search-on-selected-text ] - running 'my-gemini-search' on selected-text......"))
				(my-gemini-search selected-text)
			))
	)
)

;;
;; Enable
;;
(setq my-enable-which-key-customized-description t)

;;
;; Disable
;;
;; (setq my-enable-which-key-customized-description nil)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(dolist (map (list
              evil-insert-state-map
              evil-motion-state-map
              ))
    (keymap-set map "C-z" nil)
)

(dolist (map (list
              global-map
              evil-window-map
              evil-normal-state-map
              evil-motion-state-map
              ))
    (keymap-set map "C-j" nil)
    (keymap-set map "C-k" nil)
    ;;(message "State: %s" state);
)

(keymap-set evil-motion-state-map "<SPC>" nil)

(dolist (map (list
              evil-motion-state-map
              ))
  (keymap-set map "W" 'save-buffer)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "W" "Save")
    ))

(defun my-jj-to-escape ()
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
		(call-interactively 'evil-next-line)
	)
)

(keymap-set evil-insert-state-map  "j" 'my-jj-to-escape)
(keymap-set evil-replace-state-map "j" 'my-jj-to-escape)

(dolist (map (list
              evil-motion-state-map
              ))
  (keymap-set map "H" 'evil-first-non-blank)
  (keymap-set map "L" 'evil-end-of-line)
  ;;(message "State: %s" state);
)

;;
;; Unbind 'n' and 'N'
;;
(keymap-set evil-motion-state-map "n" nil)
(keymap-set evil-motion-state-map "N" nil)

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

(keymap-set evil-motion-state-map "n" 'my-search-next)
(keymap-set evil-motion-state-map "N" 'my-search-previous)

(defun my-goto-last-marked-position()
	(interactive)
	(evil-goto-mark ?m)
)

(dolist (map (list
              evil-motion-state-map
              ))
    (keymap-set map "g b" 'my-goto-last-marked-position)
)

(if my-enable-which-key-customized-description
    (progn
        (which-key-add-key-based-replacements "gb" "Go back")
    ))

;;
;; Unbind the default <C-s> for 'isearch-forward'
;;
(keymap-set global-map "C-s" nil)

;;
;; Replace current word or selection using vim style for evil mode
;;
(defun my-replace-word-under-curor ()
	(interactive)
	(if (use-region-p)
	    (let ((selection (buffer-substring-no-properties (region-beginning) (region-end))))
	        (if (= (length selection) 0)
	            (message "empty string")
	            (evil-ex (concat "'<,'>s/" selection "/"))
	        )
	    )
	    (evil-ex (concat "%s/" (thing-at-point 'word) "/"))
	)
)

;;
;; Rebind <C-s>
;;
(keymap-set evil-motion-state-map "C-s" 'my-replace-word-under-curor)

(dolist (map (list
              evil-motion-state-map
              ))
  (keymap-set map "C-l" 'evil-window-right)
  (keymap-set map "C-h" 'evil-window-left)
  ;;(message "State: %s" state);
)

(dolist (map (list
              vertico-map
              ))
	(keymap-set map "C-j" 'vertico-next)
	(keymap-set map "C-k" 'vertico-previous)
)

;;
;; In command state, <C-j> and <C-k> to cycle command history
;;
(keymap-set evil-command-line-map "C-j" 'next-history-element)
(keymap-set evil-command-line-map "C-k" 'previous-history-element)

;; ----------------------------------------------------------------------------
;; Buffer related
;; ----------------------------------------------------------------------------
(defun my-switch-to-last-buffer ()
	(interactive)
	(switch-to-buffer nil)
)

;; ----------------------------------------------------------------------------
;; Window resizing related
;; ----------------------------------------------------------------------------
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

;; ----------------------------------------------------------------------------
;; Quick open related
;; ----------------------------------------------------------------------------
(defun my-open-emacs-configuration ()
	(interactive)
	(find-file "~/.config/emacs/configuration.org")
)

;; (defun my-open-lisp-quick-tutorial ()
;;    (interactivep)
;;    (find-file "~/.config/emacs/lisp-quick-tutorial.org")
;; )

(defun my-open-todo-list ()
	(interactive)
	(find-file "~/.config/emacs/todo.org")
)

(defun my-open-lisp-quick-manual ()
	(interactive)
	(find-file "~/.config/emacs/lisp-quick-tutorial.org")
)

(defun my-open-snippet-folder ()
	(interactive)
	(find-file "~/.config/emacs/snippets")
)

;; ----------------------------------------------------------------------------
;; Fast kill related
;; ----------------------------------------------------------------------------
(defun my-kill-all-special-window-and-buffers-by-type (kill-type)
"Kill the special window and buffers, here are the avaiable options of 'kill-type' :

- 'Info
- 'Help
- 'ElDoc - Elgot documentation
- 'Shell - Shell or Aasync command output
- 'Embark
- 'ManPage
- 'Keybindings
"
	(interactive)
	(let (
		(kill-type-string "")
		(window-to-be-killed nil)
		(logger-prefix ">>> [ kill-all-special-window-and-buffers-by-type ] -")
		)
		(setq kill-type-string
			(cond
					((eq kill-type 'Info) "^*info")
					((eq kill-type 'Help) "^*helpful")
					((eq kill-type 'ElDoc) "^*eldoc")
					((eq kill-type 'Shell) "^\\*\\(Shell\\|Async Shell\\)")
					((eq kill-type 'Embark) "^*Embark")
					((eq kill-type 'ManPage) "^*Man")
					((eq kill-type 'Keybindings) "^*Keybindings")
					(t ""))
		)
		(message "%s kill-type-string: %s" logger-prefix kill-type-string)

		(if (not (string-empty-p kill-type-string))
			(dolist (buf (buffer-list))
				(when (string-match-p kill-type-string (buffer-name buf))
					;;
					;; Try to close its window first if exists.
					;;
					(setq window-to-be-killed (get-buffer-window (buffer-name buf) nil))
					(when window-to-be-killed
						(delete-window window-to-be-killed)
						(message
							"%s Closed window associated with buffer: %s"
							logger-prefix
							(buffer-name
							buf))
					)

					;;
					;; Kill the buffer
					;;
					(message "%s Killed buffer: %s" logger-prefix (buffer-name buf))
					(kill-buffer buf)
				)
			)
		)
	)
)

(defun my-kill-info-window-and-buffers ()
	(interactive)
	(my-kill-all-special-window-and-buffers-by-type 'Info)
)

(defun my-kill-helpful-window-and-buffers ()
	(interactive)
	(my-kill-all-special-window-and-buffers-by-type 'Help)
)

(defun my-kill-eldoc-window-and-buffers ()
	(interactive)
	(my-kill-all-special-window-and-buffers-by-type 'ElDoc)
)

(defun my-kill-embark-window-and-buffers ()
	(interactive)
	(my-kill-all-special-window-and-buffers-by-type 'Embark)
)

(defun my-kill-manpage-window-and-buffers ()
	(interactive)
	(my-kill-all-special-window-and-buffers-by-type 'ManPage)
)

(defun my-kill-shell-window-and-buffers ()
	(interactive)
	(my-kill-all-special-window-and-buffers-by-type 'Shell)
)

(defun my-kill-keybindings-window-and-buffers ()
	(interactive)
	(my-kill-all-special-window-and-buffers-by-type 'Keybindings)
)

;; ----------------------------------------------------------------------------
;; Newline replacement related
;; ----------------------------------------------------------------------------
(defun my-replace-spaces-outside-strings-regex (text)
	"Replace contiguous spaces with \\n, ignoring spaces inside quoted strings."
	(let ((result "") (start 0))
			(while (string-match "\"[^\"]*\"\\|\\( +\\)" text start)
					;; Add text before the match
					(setq result (concat result (substring text start (match-beginning 0))))

					(if (match-beginning 1)
							;; Matched spaces outside quotes - replace with \n
							(setq result (concat result "\n"))
							;; Matched quoted string - add as-is
							(setq result (concat result (match-string 0 text)))
					)

					(setq start (match-end 0))
			)

			;; Add remaining text
			(concat result (substring text start))
	)
)

(defun my-function-newline-replacement ()
	"Fix function newline on selected text, handle in different ways:
- Emacs lisp: replace all ' ' (spaces) with the '\\n' in the selected text exclude the
 spaces inside a string.

- Non Emacs lisp: replace ', ' with the '\\n' in the selected text
"
	(interactive)
	(let (selected_begin selected_end selected_text replaced_text)
		(when (use-region-p)
			(setq selected_begin (region-beginning))
			(setq selected_end (region-end))
			(setq selected_text (buffer-substring selected_begin selected_end))
			;; (message ">>> selected_text: %s" selected_text)

			(if selected_text
				(progn
					;; Run the replacement on the 'selected_text'
					(if (or (eql 'emacs-lisp-mode major-mode)
							(eql 'lisp-interaction-mode major-mode))
						(setq replaced_text
							(my-replace-spaces-outside-strings-regex selected_text))
						(setq replaced_text
							(string-replace ", " ",\n" selected_text))
					)

					;; (message ">>> replaced_text: %s" replaced_text)

					;; Delete the selected region
					(delete-region selected_begin selected_end)

					;; Insert the replacement
					(insert replaced_text)
				)
			)
		)
	)
)

;; ----------------------------------------------------------------------------
;; Show keybindings related
;; ----------------------------------------------------------------------------
(setq  MY-KEYBINDINGS-LIST '(
	(all-mode . (
		("C-x 1"	. "Delete other windows")
		("C-x C-c"	. "Close/Exit emacs")
		("C-x C-f"	. "Find files")
		("C-x b"	. "Switch buffer")
		("SPC b"	. "Buffers (bookmarks)")
		("SPC g"	. "GEMINI CLI")
		("SPC g s"	. "GEMINI CLI - Run on selected text")
		("SPC k d"	. "Kill EL-Doc windows and buffers")
		("SPC k e"	. "Kill Embark windows and buffers")
		("SPC k h"	. "Kill Help windows and buffers")
		("SPC k i"	. "Kill Info windows and buffers")
		("SPC k m"	. "Kill Manpage windows and buffers")
		("SPC o a"	. "Open agenda")
		("SPC o c"	. "Open emacs config")
		("SPC o t"	. "Open todo")
		("SPC p b"	. "Project switch buffer")
		("SPC p c"	. "Project command")
		("SPC p f"	. "Project find files")
		("SPC p r"	. "Project RG")
		("SPC v s"	. "Vertical split")
		("SPC x"	. "M-x")
	))
	(dired-mode . (
		("C-c j"	. "Jump to dired")
		("% m"		. "Mark by regex")
		("C"		. "Copy")
		("D"		. "Delete")
		("R"		. "Rename/move")
		("o"		. "Open file in other window")
		("Z"		. "Compress/uncompress")
		("m"		. "Mark")
		("u"		. "Unmark")
		("U"		. "Unmark all")
		("t"		. "Toggle mark/umask all")
		("g b"		. "Go Backup")
		("g c"		. "Go C")
		("g d"		. "Go Downloads")
		("g e"		. "Go emacs config")
		("g h"		. "Go Home")
		("g o"		. "Go Odin")
		("g p"		. "Go Photos")
		("g r"		. "Go Rust")
		("g t"		. "Go Temp")
		("g z"		. "Go Zig")
		("s h"		. "(Toggle) show hidden")
		("s n"		. "Sort by name")
		("s s"		. "Sort by size")
		("s t"		. "Sort by time")
		("y p"		. "Yank path")
	))
	(org-mode . (
		("SPC i m"	. "Embark collect")
		("SPC i l"	. "Insert link")
		("SPC o l"	. "Open link")
		("SPC n i"	. "Narrow in")
		("SPC n o"	. "Narrow out")
		("C-<left>"	. "Jump up to parent heading")
		("C-<right>"	. "Cycle through TODO state")
	))
	(eww-mode . (
		("o"		. "Open URL")
		("O"		. "Open URL in new buffer")
		("r"		. "Reload")
		("R"		. "Readable mode")
		("u"		. "Scroll up")
		("d"		. "Scroll down")
		("m"		. "Bookmark")
		("SPC i m"	. "Embark collect")
	))
))

(defun my-show-keybindings ()
    "Show my custom key bindings buffer to the right side window; the buffer content
is generated dynamically based on the current mode."
	(interactive)
	(let (
			(current-mode (symbol-name major-mode))
			(buffer-name "*Keybindings*")
			(buffer-text "")
		)
		(message ">>> [ my-show-keybindings ] - current-mode: %s" current-mode )

		;;
		;; Get all 'Key . Desc' pair by current major mode and concat all
		;; together as the 'buffer-text'
		;;
		(dolist (key-entry-alist (alist-get (intern current-mode) MY-KEYBINDINGS-LIST))
			;; (message ">>> key-entry-alist: %s" key-entry-alist)
			(let (
					(key (car key-entry-alist))
					(value (cdr key-entry-alist))
				)
				(setq buffer-text (concat buffer-text key "\t - " value "\n"))
			)
		)

		(setq buffer-text (concat buffer-text "\n---------------------------------------------\n\n"))

		;;
		;; Get all 'Key . Desc' pair by 'all-mode' and concat all together as the 'buffer-text'
		;;
		(dolist (key-entry-alist (alist-get 'all-mode MY-KEYBINDINGS-LIST))
			;; (message ">>> key-entry-alist: %s" key-entry-alist)

			(let (
					(key (car key-entry-alist))
					(value (cdr key-entry-alist))
				)
				(setq buffer-text (concat buffer-text key "\t - " value "\n"))
			)
		)

		;;
		;; Get exists '*Kyes*' buffer or create new and insert the 'buffer-text'
		;;
		(with-current-buffer (get-buffer-create buffer-name)
			(erase-buffer)
			(insert buffer-text)

			;;
			;; Switch to this mode
			;;
			;; (text-mode)
		)

		;;
		;; Show the buffer on the right side
		;;
		(display-buffer
			buffer-name
			;;
			;; The 'Action alist' will be passed to 'display-buffer'
			;;
			'(
				(display-buffer-reuse-window display-buffer-in-side-window)
				(side . right)
				(inhibit-same-window . nil)
				(window-width . 0.2)
			)
		)
	)
)


;; ----------------------------------------------------------------------------
;; Custom load theme related
;; ----------------------------------------------------------------------------
(defun my-consult-theme (theme)
	"My custom 'consult-theme' without prompt, 'theme' type is 'symbol' (not string)!!!"
	(interactive)

	(let (
		(enabled-transparent-background nil)
		)

		(consult-theme theme)
		(message ">>> [ my-consult-theme ] - theme: %s" theme)

		;;
		;; Enable the transparent background for specific themes
		;;
		(setq enabled-transparent-background
			(cond ((equal 'doom-gruvbox theme) t)  ;; if
					((equal 'ef-elea-dark theme) t)  ;; else if
					((equal 'my-tron-legacy theme) t)  ;; else if
					((equal 'doom-monokai-pro theme) t)  ;; else if
					((equal 'doom-pine theme) t)  ;; else if
					((equal 'ef-autumn theme) t)  ;; else if
					((equal 'nano-light theme) t)  ;; else if
					((equal 'nano-dark theme) t)  ;; else if
					(t nil)      ;; else
		))

		(if enabled-transparent-background
			(progn
				(my-set-transparent-background)
				(message
					">>> [ my-consult-theme ] - enabled transparent background with theme: %s"
					theme
				)
			)
		)

		;;
		;; Fix 'show-paren-match' color for 'nano-xxxx' theme
		;;
		(cond
			((eql 'nano-light theme)
				(set-face-attribute
					'show-paren-match
					nil
					:background "#FF6F00"
					:foreground "black"
					:weight 'bold)
				(message
					">>> [ my-consult-theme ] - Fixed 'show-paren-match' color for theme: %s"
					theme))
			((eql 'nano-dark theme)
				(set-face-attribute
					'show-paren-match
					nil
					:background "#0a84ff"
					:foreground "black"
					:weight 'bold)
				(message
					">>> [ my-consult-theme ] - Fixed 'show-paren-match' color for theme: %s"
					theme))
		)
	)
)

(defun my-consult-theme-prompt (theme-name-list)
	"My custom verion of 'consult-theme'.

Usually, I prefer to list only a few themes that interest me, rather than listing
all available themes. That's what this function does: Accept a list of theme names
and prompt me to choose one."

	(interactive)

	(let (
		(avail-themes (cons 'default theme-name-list))
		(saved-theme (car custom-enabled-themes))
		(my-selected-theme-symbol)
		(theme-string "")
		(enabled-transparent-background nil)
		)

		(setq my-selected-theme-symbol (consult--read
			(mapcar #'symbol-name avail-themes)
			:prompt "Theme: "
			:require-match t
			:category 'theme
			:history 'consult--theme-history
			:lookup (lambda (selected &rest _)
						(setq selected (and selected (intern-soft selected)))
						(or (and selected (car (memq selected avail-themes)))
							saved-theme))
			:state (lambda (action theme)
						(pcase action
						('return (consult-theme (or theme saved-theme)))
						((and 'preview (guard theme)) (consult-theme theme))))
			:default (symbol-name (or saved-theme 'default)))
		)

		(setq theme-string (symbol-name my-selected-theme-symbol))
		(message
			">>> [ my-consult-theme-prompt ] - theme-symbol: %s, theme-string: %s"
			my-selected-theme-symbol
			theme-string)

		;;
		;; Enable the transparent background for specific themes
		;;
		(setq enabled-transparent-background
			(cond ((string= "doom-gruvbox" theme-string) t)  ;; if
					((string= "ef-elea-dark" theme-string) t)  ;; else if
					((string= "my-tron-legacy" theme-string) t)  ;; else if
					((string= "doom-monokai-pro" theme-string) t)  ;; else if
					((string= "doom-pine" theme-string) t)  ;; else if
					((string= "ef-autumn" theme-string) t)  ;; else if
					((string= "nano-light" theme-string) t)  ;; else if
					((string= "nano-dark" theme-string) t)  ;; else if
					(t nil)      ;; else
		))

		(if enabled-transparent-background
			(progn
				(my-set-transparent-background)
				(message
					">>> [ my-consult-theme-prompt ] - enabled transparent background, theme: %s"
					theme-string)))

		;;
		;; Fix 'show-paren-match' color for 'nano-xxxx' theme
		;;
		(cond
			((string= "nano-light" theme-string)
				(set-face-attribute
					'show-paren-match
					nil
					:background "#0a84ff"
					:foreground "black"
					:weight 'bold)
				(message
					">>> [ my-consult-theme-prompt ] - Fixed 'show-paren-match' color for theme: %s"
					theme-string))
			((string= "nano-dark" theme-string)
				(set-face-attribute
					'show-paren-match
					nil
					:background "#0a84ff"
					:foreground "black"
					:weight 'bold)
				(message
					">>> [ my-consult-theme-prompt ] - Fixed 'show-paren-match' color for theme: %s"
					theme-string))
		)
				  

		;;
		;; Fixed the org heading font size if you're the 'org-mode'
		;;
		(if (equal major-mode 'org-mode)
			(my/org-mode-setup))
	)
)

(defun my-load-consult-theme-wrapper ()
	(interactive)
	(my-consult-theme-prompt '(
		ef-cyprus
		ef-melissa-light
		ef-melissa-dark
		ef-elea-dark
		ef-bio
		ef-autumn
		ef-rosa
		doom-henna
		doom-plain-dark
		doom-plain
		doom-nord
		doom-nord-aurora
		doom-gruvbox
		doom-lantern
		doom-pine
		doom-horizon
		doom-zenburn
		doom-old-hope
		doom-laserwave
		doom-monokai-pro
		my-tron-legacy
		nano-light
		nano-dark
	))
)


;; ----------------------------------------------------------------------------
;; Implement  the 'g C-a' feature in Vim related
;; ----------------------------------------------------------------------------
(defun my-increase-selected-number-in-visual-block-state ()
	"Increase the selected text (number) from top to bottom:
Go into 'evil-visual-state' by pressing 'C-v', then select a number columns and
press 'C-a' to increase all number from top to bottom (starts from the first number)"
	(interactive)
	(let (
			selected-range
			selected-begin
			selected-end
			current-line
			end-line
			left-column
			right-column
			selected-text '()
			(current-number 0)
			(already-done-with-end-line nil)
		)
		(unless (evil-visual-state-p) (error "No selected number columns."))

		;;
		;; Signature
		;; (evil-visual-range)
		;; 
		;; Documentation
		;; Return the Visual selection as a range.
		;; 
		;; This is a list (BEG END TYPE PROPERTIES...), where BEG is the
		;; beginning of the selection, END is the end of the selection,
		;; TYPE is the selection's type, and PROPERTIES is a property list
		;; of miscellaneous selection attributes.
		;;
		;; Example return value: (1232 1307 block :expanded t :corner upper-left)
		;;
		(setq selected-range (evil-visual-range))

		(setq selected-begin (nth 0 selected-range))
        (setq selected-end (nth 1 selected-range))

		;; Get back the begin line and end line based on the selected range
		(setq current-line (line-number-at-pos selected-begin))
		(setq end-line (line-number-at-pos selected-end))

		;;
		;; Signature
		;; (save-excursion &rest BODY)
		;;
		;; Documentation
		;; Save point, and current buffer; execute BODY; restore those things.
		;;
		;;
		;; The following code means:
		;;
		;; First, save the point (cursor position), and then goto the 'selected-begin'
		;; position (it will change the point, that's why you need to save first) and
		;; get back the column value then save to 'left-column'.
		;; After that, restore the saved point, which means restore the cursor position.
		;;
		(setq left-column (save-excursion
							  (goto-char selected-begin)
							  (current-column)))
		(setq right-column (save-excursion
							   (goto-char selected-end)
							   (current-column)))

		;; (message
		;; 	(concat
		;; 		"\nselected-range: %s"
		;; 		"\nselected-begin: %s"
		;; 		"\nselected-end: %s"
		;; 		"\ncurrent-line: %s"
		;; 		"\nend-line: %s"
		;; 		"\nleft-column: %s"
		;; 		"\nright-column: %s"
		;; 	)
		;; 	selected-range
		;; 	selected-begin
		;; 	selected-end
		;; 	current-line
		;; 	end-line
		;; 	left-column
		;; 	right-column
		;; )

		;;
        ;; Now, let's do this:
		;;
		;; - Save the cursor point
		;; - Loop through all selected lines and extract number text from selected columns
		;; - Convert into number and increase it, then replace it
		;; - Restor the cursor point
		;;
        (save-excursion
			(goto-char selected-begin)
			(setq current-line (line-number-at-pos))

			(while (and (not already-done-with-end-line) (<= current-line end-line))
				(let* (
						(line-beg-pos (line-beginning-position))
						(line-end-pos (line-end-position))
						(line-start (min line-end-pos
										(+ line-beg-pos left-column)))
						(line-end (min line-end-pos
									(+ line-beg-pos right-column)))
						(number-text (buffer-substring line-start line-end))
						(number-value (string-to-number number-text))
					)

					;; (message
					;; 	(concat
					;; 		"\ncurrent-line: %s"
					;; 		"\nline-begin-pos: %s"
					;; 		"\nline-end-pos: %s"
					;; 		"\nline-start: %s"
					;; 		"\nline-end: %s"
					;; 		"\nnumber-text: %s"
					;; 		"\nnumber-value: %s"
					;; 		"\ncurrent-value: %s"
					;; 	)
					;; 	current-line
					;; 	line-beg-pos
					;; 	line-end-pos
					;; 	line-start
					;; 	line-end
					;; 	number-text
					;; 	number-value
					;; 	current-number
					;; )

					(if (= current-number 0)
						;; Init case: Save the first number value
						(progn
							;; If that's NOT a valid number, exit visual state and throw error!
							(if (= number-value 0)
								(progn
									(evil-exit-visual-state)
									(error "First select column doesn't contain valid nubmer!")
								)
							)

							(setq current-number number-value)
						)
						;; Non-init case: increase the saved number
						(progn
							(setq current-number (+ current-number 1))
						)
					)

					;; Delete the selected 'number-text'
					(delete-region line-start line-end)

					;; Insert the replacement
					(goto-char line-start)
					(insert (number-to-string current-number))

					;; (message ">>> Ok, done with current-line: %s" current-line)
				)

				;;
				;; Here is a trick to stop the 'while' loop after finishing the 'end-line'
				;;
				;; If the 'end-line' (last line of the block selection) is the last line of
				;; the current buffer, then the following '(forward-line 1)' does nothing, and
				;; 'current-line' will be still the same value with 'end-line'!!!!
				;;
				;; That's why you need a flag to indicate that: You've done with the 'end-line'
				;; once.
				;;
				(if (= current-line end-line)
					(progn
						(setq already-done-with-end-line t)
						;; (message ">>> already-done-with-end-line: %s" already-done-with-end-line)
					)
				)

				;; Move to the next line and maybe hit the last line of the current buffer
				(forward-line 1)

				;; Update the 'current-line' after trying to move to next line.
				(setq current-line (line-number-at-pos))
				;; (message ">>> update, updated current-line: %s" current-line)

				;; (message ">>> The while loop condition: %s" (and (not already-done-with-end-line) (<= current-line end-line)))

			)
		)

		;; Make sure to exit visual state
		(evil-exit-visual-state)
	)
)

(defun my-dired-jump ()
	(interactive)
	(dired default-directory "-lh")
)

;;
;; Group all the common bindings that are supposed to be shared between different modes.
;;
(defun my-common-bindings (map)
	;;
	;; Toggle spell check
	;;
	(keymap-set map "SPC s c" 'flyspell-mode)

	;;
	;; Kill current window by 'Q' h
	;;
	(keymap-set map "Q" 'delete-window)

	;; ;;
	;; ;; Exit Emacs by '<leader>q'
	;; ;;
	;; (keymap-set mode-map "SPC q" 'save-buffers-kill-terminal)

	;;
	;; Delete other windows by by '<leader>1'
	;;
	(keymap-set map "SPC 1" 'delete-other-windows)

	;;
	;; Call 'describe-xxxx' functions by '<leader>df/v/k/b'
	;;
	(keymap-set map "SPC d f" 'helpful-callable)
	(keymap-set map "SPC d v" 'helpful-variable)
	(keymap-set map "SPC d k" 'describe-key)
	(keymap-set map "SPC d b" 'describe-bindings)
	(keymap-set map "SPC d m" 'describe-mode)

	;;
	;; Toggle command log mode by '<leader>cl'
	;;
	(keymap-set map "SPC c l" 'clm/toggle-command-log-buffer)

	;;
	;; Load theme by '<leader>lt'
	;;
	;; (keymap-set map "SPC l t" 'consult-theme)
	(keymap-set map "SPC l t" 'my-load-consult-theme-wrapper)

	;;
	;; Evaluate lisp expression by '<leader>eb>', '<leader>es', '<leader>ee', '<leader>ep'
	;;
	(keymap-set map "SPC e b" 'eval-buffer)           ;; Evaluate buffer
	(keymap-set map "SPC e s" 'eval-region)           ;; Evaulate selected region
	(keymap-set map "SPC e e" 'eval-last-sexp)        ;; Evaulate expression
	(keymap-set map "SPC e p" 'eval-print-last-sexp)  ;; Evaulate expression and print result

	;;
	;; Search for man page  by '<leader>m'
	;;
	(keymap-set map "SPC m" 'consult-man)

	;;
	;; Run 'execute-extended-command' by '<leader>x'
	;;
	(keymap-set map "SPC x" 'execute-extended-command)

	;;
	;; Open files or buffers by '<leader>f/b'
	;;
	;; (keymap-set map "SPC f" 'find-file)
	(keymap-set map "SPC b" 'consult-buffer)

	;;
	;; Project scope fuzzy searching files and related actions by '<leader>p X'
	;;
	(keymap-set map "SPC p f" 'project-find-file)
	(keymap-set map "SPC p d" 'project-dired)
	(keymap-set map "SPC p s" 'project-switch-project)
	(keymap-set map "SPC p b" 'project-switch-to-buffer)
	(keymap-set map "SPC p c" 'project-command/run-with-enable-script-files)
	(keymap-set map "SPC p r" 'consult-ripgrep)

	;;
	;; Switch between last buffers '<leader>SPC'
	;;
	(keymap-set map "SPC SPC" 'my-switch-to-last-buffer)

	;;
	;; Toggle 'Olivetti' mode (works like 'GoYo' in 'Neovim') by '<leader>RET'
	;;
	(keymap-set map "SPC RET" 'olivetti-mode)

	;;
	;; 'imenu' (function and variable list) by '<leader>im'
	;;
	(keymap-set map "SPC i m" 'consult-imenu)

	;;
	;; Window split by '<leader>vs'
	;;
	(keymap-set map "SPC v s" 'evil-window-vsplit)

	;;
	;; Window movement by 'C-h, C-l' (Only for jumping between left and right windows)
	;;
	(keymap-set map "C-l" 'evil-window-right)
	(keymap-set map "C-h" 'evil-window-left)

	;;
	;; Change window size by '-/+/='
	;;
	(keymap-set map "|" 'balance-windows)
	(keymap-set map "=" 'my-increase-window-width)
	(keymap-set map "-" 'my-decrease-window-width)
	(keymap-set map "+" 'my-increase-window-height)
	(keymap-set map "_" 'my-decrease-window-height)

	;;
	;; Open something quickly
	;;
	(keymap-set map "SPC o a"   'org-agenda)
	(keymap-set map "SPC o c"   'my-open-emacs-configuration)
	(keymap-set map "SPC o q"   'my-open-lisp-quick-manual)
	(keymap-set map "SPC o s f" 'my-open-snippet-folder)
	(keymap-set map "SPC o t"   'my-open-todo-list)
	;; (keymap-set map "SPC o l t" 'my-open-lisp-quick-tutorial)

	;;
	;; Emoji insert by '<leader>ei'
	;;
	(keymap-set map "SPC e i" 'emoji-insert)

	;;
	;; Fast kill buffers and windows by '<leadedr>kX'
	;;
	(keymap-set map "SPC k d" 'my-kill-eldoc-window-and-buffers)
	(keymap-set map "SPC k e" 'my-kill-embark-window-and-buffers)
	(keymap-set map "SPC k h" 'my-kill-helpful-window-and-buffers)
	(keymap-set map "SPC k i" 'my-kill-info-window-and-buffers)
	(keymap-set map "SPC k k" 'my-kill-keybindings-window-and-buffers)
	(keymap-set map "SPC k m" 'my-kill-manpage-window-and-buffers)
	(keymap-set map "SPC k s" 'my-kill-shell-window-and-buffers)

	;;
	;; My function newline code util by '<leader>fn'
	;;
	(keymap-set map "SPC f n" 'my-function-newline-replacement)

	;;
	;; Jump back to 'dired buffer' corresponding to current buffer by 'C-c j'
	;;
	(keymap-set map "C-c j" 'my-dired-jump)

	;;
	;; Show keybinding of the current buffer by '<leader>sk'
	;;
	(keymap-set map "SPC s k" 'my-show-keybindings)

	;;
	;; Run 'gemini-cli' with selected text by '<leader>gs'
	;;
	(keymap-set map "SPC g s" 'my-gemini-search-on-selected-text)

	;;
	;; Update 'which-key'
	;;
	(if my-enable-which-key-customized-description
	    (progn
	        ;; (which-key-add-key-based-replacements "SPC q" "Save and exit")
			(which-key-add-key-based-replacements "SPC 1"   "Delete other windows")
			(which-key-add-key-based-replacements "SPC c l" "Command Log")
			(which-key-add-key-based-replacements "SPC l t" "Load theme")
			(which-key-add-key-based-replacements "SPC m"   "Man page search")
			(which-key-add-key-based-replacements "SPC x"   "M-x command")
			;; (which-key-add-key-based-replacements "SPC f"   "Find files")
			(which-key-add-key-based-replacements "SPC b"   "Switch buffers")
			(which-key-add-key-based-replacements "SPC SPC" "Last Buffer")
			(which-key-add-key-based-replacements "SPC RET" "Toggle Focus mode")
			(which-key-add-key-based-replacements "SPC i"   "iMenu/Insert")

			(which-key-add-key-based-replacements "SPC d"   "Describe ...")
			(which-key-add-key-based-replacements "SPC d f" "Function")
			(which-key-add-key-based-replacements "SPC d v" "Variable")
			(which-key-add-key-based-replacements "SPC d k" "Keys")
			(which-key-add-key-based-replacements "SPC d m" "Mode")
			(which-key-add-key-based-replacements "SPC d b" "Bindings")

			(which-key-add-key-based-replacements "SPC e"   "Evalute/Emoji")
			(which-key-add-key-based-replacements "SPC e i" "Insert emoji")
			(which-key-add-key-based-replacements "SPC e b" "Buffer")
			(which-key-add-key-based-replacements "SPC e s" "Selection")
			(which-key-add-key-based-replacements "SPC e e" "Expression")
			(which-key-add-key-based-replacements "SPC e p" "Expression and print")

			(which-key-add-key-based-replacements "SPC p"   "Projects")
			(which-key-add-key-based-replacements "SPC p f" "Fuzzy searching in project")
			(which-key-add-key-based-replacements "SPC p d" "Open dired in project")
			(which-key-add-key-based-replacements "SPC p b" "Switch buffer in project")
			(which-key-add-key-based-replacements "SPC p s" "Switch to another project")
			(which-key-add-key-based-replacements "SPC p c" "Project command")
			(which-key-add-key-based-replacements "SPC p r" "Project rg search")

			(which-key-add-key-based-replacements "SPC v"   "Vertical split")
			(which-key-add-key-based-replacements "SPC v s" "Vertical split")

			(which-key-add-key-based-replacements "SPC o"   "(Quick) open ....")
			(which-key-add-key-based-replacements "SPC o a" "Agenda")
			(which-key-add-key-based-replacements "SPC o c" "Configuration file")
			(which-key-add-key-based-replacements "SPC o q" "Lisp quick manual")
			(which-key-add-key-based-replacements "SPC o s f" "Snippet folder")
			(which-key-add-key-based-replacements "SPC o t" "Todo list")

			(which-key-add-key-based-replacements "SPC k" "Kill")
			(which-key-add-key-based-replacements "SPC k i" "Info window and buffer")
			(which-key-add-key-based-replacements "SPC k h" "Help window and buffer")
			(which-key-add-key-based-replacements "SPC k d" "ElDoc window and buffer")
			(which-key-add-key-based-replacements "SPC k e" "Embark window and buffer")
			(which-key-add-key-based-replacements "SPC k k" "Keybindings window and buffer")
			(which-key-add-key-based-replacements "SPC k m" "ManPage window and buffer")
			(which-key-add-key-based-replacements "SPC k s" "Shell window and buffer")

			(which-key-add-key-based-replacements "SPC s k" "Show keybindings")

			(which-key-add-key-based-replacements "SPC g" "GEMINI CLI")
			(which-key-add-key-based-replacements "SPC g s" "Run on selected text")
		)
	)

)

;;
;; Now, this is the function will be called when the 'xxx-mode' is available.
;;
;; Inside this function, you should call the 'lmy-common-bindings' with the
;; 'evil-normal-state-local-map' to make sure your bindings are on the most top priority
;; in the bindings order that you've saw in the above example!!!
;;
(defun my-xxx-mode-local-bindings ()
	;;
	;; Common bindings first
	;;
	(my-common-bindings evil-normal-state-local-map)
	;; (message ">>> 'my-xxx-mode-local-bindings' runs")
)

;;
;; Now, bind 'my-xxx-mode-local-bindings' to 'xxx-mode-hook'
;;
(defun my-bind-common-bindings-to-these-mode-hooks ()
	(dolist (hook '(
		help-mode-hook
		helpful-mode-hook
		embark-collect-mode-hook
		dired-mode-hook
		shell-command-mode-hook
		debugger-mode-hook
		compilation-mode-hook
		special-mode-hook
		fundamental-mode-hook
		edit-abbrevs-mode-hook
		org-mode-hook
		org-agenda-mode-hook
		markdown-mode-hook
		markdown-view-mode-hook
		eww-mode-hook
		eww-history-mode-hook
		eww-bookmark-mode-hook
		lisp-interaction-mode-hook
		lisp-mode-hook
		emacs-lisp-mode-hook
		emacs-lisp-compilation-mode-hook
		snippet-mode-hook
		prog-mode-hook
		;; c-mode-hook
		;; c-ts-mode-hook
		;; c++-mode-hook
		;; c++-ts-mode-hook
		;; zig-mode-hook
		;; zig-ts-mode-hook
		;; rust-mode-hook
		;; rust-ts-mode-hook
		;; typescript-ts-mode-hook
		;; js-ts-mode-hook
		;; java-ts-mode-hook
		;; hare-mode-hook
		;; hare-ts-mode-hook
		))

		(add-hook hook #'my-xxx-mode-local-bindings)
		(message ">>> Add 'my-xxx-mode-local-bindings' to '%s'" hook)
	)
)

;;
;; Bind the special bindings to 'evil-visual-state-map'
;;
(defun my-special-visual-state-bindings ()
	(keymap-set evil-visual-state-map "C-a" 'my-increase-selected-number-in-visual-block-state)
)

(defun my-visual-mode-special-bindings ()
	(dolist (hook '(
			org-mode-hook
			markdown-mode-hook
			lisp-interaction-mode-hook
			lisp-mode-hook
			emacs-lisp-mode-hook
			emacs-lisp-compilation-mode-hook
			snippet-mode-hook
			prog-mode-hook
		))
		(add-hook hook #'my-special-visual-state-bindings)
		(message ">>> Add 'my-special-visual-state-bindings' to '%s'" hook)
	)

	;; (evil-define-key 'visual lisp-interaction-mode "C-a" 'my-increase-selected-number-in-visual-block-state)

)

;;
;; The 'messages-buffer-mode' is super special:
;;
;; New 'messages-buffer-mode' in Emacs 24.4. [ 08 Jul 2014, by Artur Malabarba. ]:
;;
;; I've been using 24.4 for months now, yet only today I came to realise the *Messages* buffer
;; has been granted its own major-mode. The practical difference is that the buffer is now
;; 'read-only' and has a 'non-writing-oriented' key-map.
;;
(defun my-bind-common-bindings-to-message-buffer ()
	;; ;;
	;; ;; This doesn't work, the 'messages-buffer-mode-hook' function won't be called!!!
	;; ;;
	;; (add-hook
	;; 	'messages-buffer-mode-hook
	;; 	#'my-bind-common-bindings-to-messages-buffer
	;; )

	;;
	;; You have to get back the message buffer instance and run ;; 'my-common-bindings' 
	;; on it!!!
	;;
	(when-let ((messages-buffer (get-buffer "*Messages*")))
		(with-current-buffer messages-buffer
			;; (evil-normalize-keymaps)
			;; (message ">>> called 'evil-normalize-keymaps' on 'MessageBuffer'")
			(my-common-bindings evil-normal-state-local-map)
			(message ">>> called 'my-common-bindings' on 'MessageBuffer'")
		)
	)
)



;;
;; 'my-bind-common-bindings-to-these-mode-hooks' has to be called when all 'xxx-mode-hook'
;; are avaiable. Otherwise, 'my-xxx-mode-local-bindings' won't be called for some modes!!!
;;
;; That's why you should call this function for the 'after-init-hook', as all 'xxx-mode-hook'
;; should be ready after the frame has been inited.
;;
(add-hook
	'after-init-hook
	(lambda ()
		(my-bind-common-bindings-to-message-buffer)
		(message ">>> 'my-bind-common-bindings-to-message-buffer' has been called by 'after-init-hook'")

		(my-bind-common-bindings-to-these-mode-hooks)
		(message ">>> 'my-bind-common-bindings-to-these-mode-hooks' has been called by 'after-init-hook'")

		(my-visual-mode-special-bindings)
		(message ">>> 'my-visual-mode-special-bindings' has been called by 'after-init-hook'")
	)
)

(defun my-lsp-error-jumping-in-local-buffer()
	(keymap-set evil-normal-state-local-map "C-n" 'flymake-goto-next-error)
	(keymap-set evil-normal-state-local-map "C-p" 'flymake-goto-prev-error)
	
	(message ">>> [ my-lsp-error-jumping-in-local-buffer ] Set 'C-n' and 'C-p' to local buffer")
)

(defun my-lsp-format-buffer()
	;;(keymap-set evil-normal-state-local-map "<leader>ff" 'lsp-format-buffer)
	
	(keymap-set evil-normal-state-local-map "SPC f f" 'eglot-format-buffer)
	
	(message ">>> [ my-lsp-format-buffer ] Set '<leader>ff' to local buffer")
)

(defun my-lsp-rename-buffer()
	;; (keymap-set evil-normal-state-local-map "<leader>rn" 'lsp-rename)
	
	(keymap-set evil-normal-state-local-map "SPC r n" 'eglot-rename)
	
	(message ">>> [ my-lsp-rename-buffer ] Set '<leader>rn' to local buffer")
)

(defun my-lsp-show-error()
	(keymap-set evil-normal-state-local-map "SPC s e" 'flymake-show-buffer-diagnostics)
	
	(message ">>> [ my-lsp-show-error ] Set '<leader>se' to local buffer")
)

(defun my-lsp-code-action()
	;; (keymap-set evil-normal-state-local-map "<leader>ca" 'lsp-execute-code-action)
	;; (keymap-set evil-normal-state-local-map "C-c c a" 'lsp-execute-code-action)
	
	(keymap-set evil-normal-state-local-map "SPC c a" 'eglot-code-action-quickfix)
	
	(message ">>> [ my-lsp-code-action ] Set '<leader>ca' to local buffer")
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
    (keymap-set evil-normal-state-local-map "SPC t h" 'my-lsp-toggle-inlay-hint)

    (message ">>> [ my-setup-toggle-inlay-hint ] Set '<leader>th' to local buffer")
)

(defun my-compilation-error-jumping-in-local-buffer()
	(keymap-set evil-normal-state-local-map "C-n" 'compilation-next-error)
	(keymap-set evil-normal-state-local-map "C-p" 'compilation-previous-error)
	
	(message ">>> [ my-compilation-error-jumping-in-local-buffer ] Set 'C-n' and 'C-p' to local buffer")
)

(defun my-lsp-bindings()
	(my-lsp-error-jumping-in-local-buffer)
	(my-lsp-format-buffer)
	(my-lsp-rename-buffer)
	(my-lsp-show-error)
	(my-lsp-code-action)
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
                js-ts-mode-hook
                java-ts-mode-hook
                ))
	(add-hook hook #'my-lsp-bindings)
)

(add-hook 'compilation-mode-hook #'my-compilation-error-jumping-in-local-buffer)

(defun my-org-jump-to-next-heading ()
	(interactive)
	(org-forward-heading-same-level nil)
	(evil-scroll-line-to-center nil)
)

(defun my-org-jump-to-previous-heading ()
	(interactive)
	(org-backward-heading-same-level nil)
	(evil-scroll-line-to-center nil)
)

(defun my-org-jump-up-to-parent-heading ()
	(interactive)
	(outline-up-heading 1)
	(evil-scroll-line-to-center nil)
)

;;
;; My 'org-mode' bindings
;;
(defun my-org-mode-bindings (map)
	;;
	;; Fold or unfold when cursor is on heading by '<RET>'
	;;
	(keymap-set map "RET" 'org-cycle)

	;;
	;; Open code edit by '<leader>ce'
	;;
	(keymap-set map "SPC c e" 'org-edit-special)

	;;
	;; Open embark collect buffer by '<leader>im' 
	;; Use 'imenu' keybindings just easy for me to remember, nothing special:)
	;;
	(keymap-set map "SPC i m" 'embark-collect)

	;;
	;; Insert/edit a link by '<leader>il' and open a link by '<leader>ol' 
	;;
	(keymap-set map "SPC i l" 'org-insert-link)
	(keymap-set map "SPC o l" 'org-open-at-point)

	;;
	;; Narrowing start and end by '<leader>ns' and '<leader>ne'
	;;
	(keymap-set map "SPC n i" 'org-narrow-to-subtree)
	(keymap-set map "SPC n o" 'widen)

	;;
	;; Jump between same level headings by '<C-j>' and '<C-k>'
	;;
	(keymap-set map "C-j" 'my-org-jump-to-next-heading)
	(keymap-set map "C-k" 'my-org-jump-to-previous-heading)

	;;
	;; Jump back to up 1 level heading by '<C-left>'
	;;
	(keymap-set map "C-<left>" 'my-org-jump-up-to-parent-heading)

	;;
	;; Cycle through the TODO state by '<C-Right>'
	;;
	(keymap-set map "C-<right>" 'org-todo)

	(if my-enable-which-key-customized-description
		(progn

			(which-key-add-major-mode-key-based-replacements major-mode "SPC c e" "Code Edit")
			(which-key-add-major-mode-key-based-replacements major-mode "SPC i m" "Org Heading Catalog")
			(which-key-add-major-mode-key-based-replacements major-mode "SPC o l" "Link")
			(which-key-add-major-mode-key-based-replacements major-mode "SPC i l" "Insert link")

            (which-key-add-major-mode-key-based-replacements major-mode "SPC n" "(Org) Narrowing")
            (which-key-add-major-mode-key-based-replacements major-mode "SPC n i" "Org Narrowing In")
            (which-key-add-major-mode-key-based-replacements major-mode "SPC n o" "Org Narrowing Out")
		)
	)
)

;;
;; Call 'my-org-mode-binding' with 'evil-normal-state-local-map'
;;
(defun my-org-mode-local-bindings ()
	(my-org-mode-bindings evil-normal-state-local-map)
)


;;
;; Then, add it to the 'org-mode-hook'
;;
(add-hook 'org-mode-hook #'my-org-mode-local-bindings)

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

;;
;; My 'markdown-mode' and 'markdown-view-mode' bindings
;;
(defun my-markdown-mode-bindings (map)
	;;
	;; Fold or unfold when cursor is on heading by '<RET>'
	;;
	(keymap-set map "RET" 'markdown-cycle)

	;;
	;; Jump between same level headings by '<C-j>' and '<C-k>'
	;;
	(keymap-set map "C-j" 'my-markdown-next-heading)
	(keymap-set map "C-k" 'my-markdown-previous-heading)
)

;;
;; Call 'my-markdown-mode-binding' with 'evil-normal-state-local-map'
;;
(defun my-markdown-mode-local-bindings ()
	(my-markdown-mode-bindings evil-normal-state-local-map)
)


;;
;; Then, add it to the related mode hooks
;;
(dolist (hook '(
               markdown-mode-hook
               markdown-view-mode-hook
               ))
	(add-hook hook #'my-markdown-mode-local-bindings)
)

(defun my-dired-yank-full-path ()
	(interactive)
	(dired-copy-filename-as-kill 0)
)

(defun my-dired-sort-by-time ()			(interactive) (dired-sort-other "-lht"))
(defun my-dired-sort-by-size ()			(interactive) (dired-sort-other "-lhS"))
(defun my-dired-sort-by-name ()			(interactive) (dired-sort-other "-lh"))
;; (defun my-dired-sort-by-directory ()	(interactive) (dired-sort-other "-l --group-directories-first"))

(defun my-goto-home-directory()			(interactive) (dired "~/"))
(defun my-goto-shell-backup-directory()	(interactive) (dired "~/my-shell/backup"))
(defun my-goto-c-directory()			(interactive) (dired "~/c"))
(defun my-goto-emacs-directory()		(interactive) (dired "~/.config/emacs"))
(defun my-goto-downloads-directory()	(interactive) (dired "~/Downloads"))
(defun my-goto-rust-directory()			(interactive) (dired "~/rust"))
(defun my-goto-zig-directory()			(interactive) (dired "~/zig"))
(defun my-goto-odin-directory()			(interactive) (dired "~/odin"))
(defun my-goto-temp-directory()			(interactive) (dired "~/temp"))
(defun my-goto-photo-directory()		(interactive) (dired "~/Photos"))

(defun my-dired-add-file-or-directory ()

"In 'dired-mode', press 'A' to show a prompt.
If the filename end with '/' that means create diretory, otherwise, create an empty file.
"

	(interactive)
	(let ((filename ""))
		;;
		;; Ask for the new file or directory name
		;;
		(setq filename  (completing-read
			;;
			;; The prompt
			;;
			"Create new file or directory: "

			;;
			;; List: can be either
			;;
			;; - A 'list' instance, e.g: (list "./configure.sh" "./run.sh" "./run-test.sh")
			;; - A 'list' variable name, e.g: cmd-list
			;; - A 'function': the function is solely responsible for performing completion; 'completion-read'
			;;                 returns whatever this function returns. The function is called with three
			;;                 arguments: 'string predicate nil'
			;;
			;;				   You can read more from 'Programmed completion':
			;;				   https://www.gnu.org/software/emacs/manual/html_node/elisp/Programmed-Completion.html
			;;
			nil

			;;
			;; 'PREDICATE' function (not provided)
			;;
			nil

			;;
			;; 'REQUIRE-MATCH': input must match in the 'List'
			;;
			;; - t means that the user is not allowed to exit unless the input is (or
			;;   completes to) an element of COLLECTION or is null.
			;;
			;; - nil means that the user can exit with any input.
			;;
			;; - confirm means that the user can exit with any input, but she needs
			;;   to confirm her choice if the input is not an element of COLLECTION.
			;;
			'confirm

			;;
			;; 'INIT-INPUT': simulate you type in the input area
			;;
			nil

			;;
			;; 'HIST': History list (not provided)
			;;
			nil

			;;
			;; 'DEF': Default value, put it to the top position!!!
			;;
			""
			))
		(message ">>> Your file or directory name: %s" filename)

		(if (not (string-empty-p filename))
			(progn
				(if (string-suffix-p "/" filename)
					(dired-create-directory filename)
					(dired-create-empty-file filename)
				)
			)
		)
	)
)

;;
;; My 'dired-mode' bindings
;;
(defun my-dired-mode-bindings (map)
	;;
	;; Jump back to 'dired buffer' corresponding to current buffer by 'C-c j'
	;;
	(keymap-set map "C-c j" 'my-dired-jump)

	;;
	;; Go up dir by 'h' and into dir or open file by 'l'
	;;
	(keymap-set map "h" 'dired-up-directory)
	(keymap-set map "l" 'dired-find-file)

	;;
	;; Open file to other window by 'o'
	;;
	(keymap-set map "z" 'dired-do-compress-to)

	;;
	;; Compress file/files (marked or not) by 'z'
	;;
	(keymap-set map "o" 'dired-find-file-other-window)

	;;
	;; Toggle hidden files by 'sh'
	;;
	;; Before this can work, you have to make sure that you have the following settings
	;; to show hidden files by default:
	;;
	;; '(setq dired-listing-switches "-lhta")'
	;;
	(setq dired-omit-files "^\\...+$")
	(keymap-set map "s h" 'dired-omit-mode)

	;;
	;; Yank ful path by 'yp' 
	;;
	(keymap-set map "y p" 'my-dired-yank-full-path)

	;;
	;; Sort with different conditions by 'sX'
	;;
	(keymap-set map "s t" 'my-dired-sort-by-time)
	(keymap-set map "s s" 'my-dired-sort-by-size)
	(keymap-set map "s n" 'my-dired-sort-by-name)
	;; (keymap-set map "s d" 'my-dired-sort-by-directory)

	;;
	;; Quickly go to particular directories by 'gX'
	;;
	;; - 'gh': Go home       '~/'
	;; - 'gb': Go backup     '~/my-shell/backup'
	;; - 'gc': Go c          '~/c'
	;; - 'gd': Go downloads  '~/Downloads'
	;; - 'ge': Go Emacs      '~/.config/emacs'
	;; - 'gp': Go Photos     '~/Photos'
	;; - 'gr': Go Rust       '~/rust'
	;; - 'gt': Go temp       '~/temp'
	;; - 'gz': Go zig        '~/zig'
	;; - 'go': Go zig        '~/odin'
	;;
	(keymap-set map "g h" 'my-goto-home-directory)
	(keymap-set map "g b" 'my-goto-shell-backup-directory)
	(keymap-set map "g d" 'my-goto-downloads-directory)
	(keymap-set map "g c" 'my-goto-c-directory)
	(keymap-set map "g e" 'my-goto-emacs-directory)
	(keymap-set map "g p" 'my-goto-photo-directory)
	(keymap-set map "g r" 'my-goto-rust-directory)
	(keymap-set map "g t" 'my-goto-temp-directory)
	(keymap-set map "g z" 'my-goto-zig-directory)
	(keymap-set map "g z" 'my-goto-odin-directory)

	;;
	;; Modify the READ-ONLY buffer by '<leader>m'
	;;
	;; After going into the 'wdired-change-to-wdired-mode', here are the default keybindgins
	;; to accept or discard changes:
	;; 
	;; 'C-c C-c': Accept changes
	;; 'C-c C-k': Discard changes
	;;
	(keymap-set map "SPC m" 'dired-toggle-read-only)

	;;
	;; Add file or directory by 'A'
	;;
	(keymap-set map "A" 'my-dired-add-file-or-directory)

	(if my-enable-which-key-customized-description
		(progn
			(which-key-add-major-mode-key-based-replacements major-mode "SPC m"	"Modify mode")
			(which-key-add-major-mode-key-based-replacements major-mode "s"	"Sort")
			(which-key-add-major-mode-key-based-replacements major-mode "s t"	"Sort by time")
			(which-key-add-major-mode-key-based-replacements major-mode "s s"	"Sort by size")
			(which-key-add-major-mode-key-based-replacements major-mode "s n"	"Sort by name")
			;; (which-key-add-key-based-replacements "s d"		"Sort by directory")
			(which-key-add-major-mode-key-based-replacements major-mode "s h"	"(Toggle) show hidden")
			(which-key-add-major-mode-key-based-replacements major-mode "y p"	"Yank path")
		)
	)
)

;;
;; Call 'my-dired-mode-binding' with 'map'
;;
(defun my-dired-mode-local-bindings ()
	(my-dired-mode-bindings evil-normal-state-local-map)
)

;;
;; Then, add it to the 'dired-mode-hook'
;;
(add-hook 'dired-mode-hook #'my-dired-mode-local-bindings)

;;
;; My 'emacs-lisp-mode' bindings
;;
(defun my-emacs-lisp-mode-bindings (map)
	;;
	;; Open embark collect buffer by '<leader>im' 
	;; Use 'imenu' keybindings just easy for me to remember, nothing special:)
	;;
	(keymap-set map "SPC i m" 'embark-collect)

	(if my-enable-which-key-customized-description
		(progn
			(which-key-add-major-mode-key-based-replacements major-mode "SPC i m" "Lisp embark list")
		)
	)
)

;;
;; Call 'my-emacs-lisp-mode-binding' with 'evil-normal-state-local-map'
;;
(defun my-emacs-lisp-mode-local-bindings ()
	(my-emacs-lisp-mode-bindings evil-normal-state-local-map)
)


;;
;; Then, add it to the 'emacs-lisp-mode-hook'
;;
(add-hook 'emacs-lisp-mode-hook #'my-emacs-lisp-mode-local-bindings)

;;
;; Fit the rendered image to window by '='
;;
(evil-define-key '(normal) image-mode-map (kbd "=") 'image-transform-fit-to-window)

(keymap-set global-map "C-e" 'embark-act)

(defun my-embark-move-down-hit-enter()
	(interactive)
	(evil-next-line)
	(push-button)
)

(defun my-embark-move-up-hit-enter()
	(interactive)
	(evil-previous-line)
	(push-button)
)

;;
;; My 'embark-collect-mode' bindings
;;
(defun my-embark-collect-mode-bindings (map)
	;;
	;; '<C-j>' and '<C-k>' move up and down
	;;
  	(keymap-set evil-normal-state-local-map "C-j" 'my-embark-move-down-hit-enter)
  	(keymap-set evil-normal-state-local-map "C-k" 'my-embark-move-up-hit-enter)
)

;;
;; Call 'my-embark-collect-mode-binding' with 'evil-normal-state-local-map'
;;
(defun my-embark-collect-mode-local-bindings ()
	(my-embark-collect-mode-bindings evil-normal-state-local-map)
)


;;
;; Then, add it to the 'embark-collect-mode-hook'
;;
(add-hook 'embark-collect-mode-hook #'my-embark-collect-mode-local-bindings)

(dolist (map (list
              evil-motion-state-map
              evil-normal-state-map
              ))
    (keymap-set map "M--" 'text-scale-decrease)
    (keymap-set map "M-=" 'text-scale-increase)
)

;;
;; My 'eww-mode' bindings
;;
(defun my-eww-mode-bindings (map)
	;;
	;; Disable the default keybindings
	;;
  	;; (keymap-set map "SPC" nil)
  	(keymap-set map "w" nil)

	;;
	;; Rebind to 'Qutebrowser-liked' keybindings
	;;
	;; Here are the default bindings, for reference:
	;;
	;; (keymap-set evil-normal-state-local-map "y u" 'shr-maybe-probe-and-copy-url)
	;; &		eww-browse-with-external-browser
	;; H		eww-back-url
	;; L		eww-forward-url
	;; R
	;; U		eww-top-url
	;; ^		eww-up-url
	;; d		eww-download
	;; m		eww-add-bookmark
	;; o		eww
	;; q		quit-window
	;; r		eww-readable
	;; u		eww-up-url
	;; DEL		eww-back-url
	;; S-SPC		scroll-down-command
	;; S-<return>	eww-browse-with-external-browser
	;; <backtab>	shr-previous-link
	;; <tab>		shr-next-link
	;;
	;; Z Q		quit-window
	;; Z Z		quit-window
	;;
	;; [ [		eww-previous-url
	;;
	;; ] ]		eww-next-url
	;;
	;; z d		eww-toggle-paragraph-direction
	;; z e		eww-set-character-encoding
	;; z f		eww-toggle-fonts
	;;
	;; g b		eww-list-bookmarks
	;; g c		url-cookie-list
	;; g f		eww-view-source
	;; g h		eww-list-histories
	;; g j		eww-next-url
	;; g k		eww-previous-url
	;; g o		eww-browse-with-external-browser
	;; g r		eww-reload
	;; g t		eww-list-buffers
	;;

	; Open URL
	(keymap-set map "o" 'eww)
	(keymap-set map "O" 'eww-open-in-new-buffer)

	; Reload
	(keymap-set map "r" 'eww-reload)

	; Toggle read list (remove all navigation menus parts)
	(keymap-set map "R" 'eww-readable)

	; Page up and down
	(keymap-set map "u" 'evil-scroll-up)
	(keymap-set map "d" 'evil-scroll-down)

	; Add or update bookmark
	(keymap-set map "m" 'consult-bookmark)

	;;
	;; Open embark collect buffer (kind of navigation URL list with title) by '<SPC i m>'
	;;
	(keymap-set map "SPC i m" 'embark-collect)
)

;;
;; Call 'my-eww-mode-binding' with 'evil-normal-state-local-map'
;;
(defun my-eww-mode-local-bindings ()
	(my-eww-mode-bindings evil-normal-state-local-map)
)

;;
;; Then, add it to the 'eww-mode-hook'
;;
(add-hook 'eww-mode-hook #'my-eww-mode-local-bindings)



;;
;; My 'eww-history-mode' and 'eww-bookmark-mode' bindings
;;
(defun my-eww-history-and-bookmark-modeb-indings (map)
	;;
	;; use '<C-j>' and '<C-k>' to move up and down
	;;
	(keymap-set map "C-j" 'evil-next-line)
	(keymap-set map "C-k" 'evil-previous-line)
)

;;
;; Call 'my-eww-mode-binding' with 'evil-normal-state-local-map'
;;
(defun my-eww-history-and-bookmark-modeb-local-indings ()
	(my-eww-history-and-bookmark-modeb-indings evil-normal-state-local-map)
)


;;
;; Then, add it to the 'eww-mode-hook'
;;
(add-hook 'eww-history-mode-hook #'my-eww-history-and-bookmark-modeb-local-indings)
(add-hook 'eww-bookmark-mode-hook #'my-eww-history-and-bookmark-modeb-local-indings)

;;
;; Here are the default bindings for 'org-agenda-mode', for reference:
;;
;; o		org-agenda-goto
;; C-k		org-agenda-kill
;; RET		org-agenda-switch-to
;; C-_		org-agenda-undo
;; SPC		org-agenda-show-and-scroll-up
;; !		org-agenda-toggle-deadlines
;; #		org-agenda-dim-blocked-tasks
;; $		org-agenda-archive
;; %		org-agenda-bulk-mark-regexp
;; *		org-agenda-bulk-mark-all
;; +		org-agenda-priority-up
;; ,		org-agenda-priority
;; -		org-agenda-priority-down
;; .		org-agenda-goto-today
;; /		org-agenda-filter
;; 0 .. 9		digit-argument
;; :		org-agenda-set-tags
;; ;		org-timer-set-timer
;; <		org-agenda-filter-by-category
;; =		org-agenda-filter-by-regexp
;; >		org-agenda-date-prompt
;; ?		org-agenda-show-the-flagging-note
;; A		org-agenda-append-agenda
;; B		org-agenda-bulk-action
;; C		org-agenda-convert-date
;; D		org-agenda-toggle-diary
;; E		org-agenda-entry-text-mode
;; F		org-agenda-follow-mode
;; G		org-agenda-toggle-time-grid
;; H		org-agenda-holidays
;; I		org-agenda-clock-in
;; J		org-agenda-clock-goto
;; L		org-agenda-recenter
;; M		org-agenda-phases-of-moon
;; N		org-agenda-next-item
;; O		org-agenda-clock-out
;; P		org-agenda-previous-item
;; Q		org-agenda-Quit
;; R		org-agenda-clockreport-mode
;; S		org-agenda-sunrise-sunset
;; T		org-agenda-show-tags
;; U		org-agenda-bulk-unmark-all
;; X		org-agenda-clock-cancel
;; [		org-agenda-manipulate-query-add
;; \		org-agenda-filter-by-tag
;; ]		org-agenda-manipulate-query-subtract
;; ^		org-agenda-filter-by-top-headline
;; _		org-agenda-filter-by-effort
;; a		org-agenda-archive-default-with-confirmation
;; b		org-agenda-earlier
;; c		org-agenda-goto-calendar
;; d		org-agenda-day-view
;; e		org-agenda-set-effort
;; f		org-agenda-later
;; g		org-agenda-redo-all
;; h		org-agenda-holidays
;; i		org-agenda-diary-entry
;; j		org-agenda-goto-date
;; k		org-agenda-capture
;; l		org-agenda-log-mode
;; m		org-agenda-bulk-mark
;; n		org-agenda-next-line
;; o		delete-other-windows
;; p		org-agenda-previous-line
;; q		org-agenda-quit
;; r		org-agenda-redo
;; s		org-save-all-org-buffers
;; t		org-agenda-todo
;; u		org-agenda-bulk-unmark
;; v		org-agenda-view-mode-dispatch
;; w		org-agenda-week-view
;; x		org-agenda-exit
;; y		org-agenda-year-view
;; z		org-agenda-add-note
;; {		org-agenda-manipulate-query-add-re
;; |		org-agenda-filter-remove-all
;; }		org-agenda-manipulate-query-subtract-re
;; ~		org-agenda-limit-interactively
;; DEL		org-agenda-show-scroll-down
;; C-/		org-agenda-undo
;; C-S-<left>	org-agenda-todo-previousset
;; C-S-<right>	org-agenda-todo-nextset
;; M-<down>	org-agenda-drag-line-forward
;; M-<up>		org-agenda-drag-line-backward
;; S-<down>	org-agenda-priority-down
;; S-<left>	org-agenda-do-date-earlier
;; S-<right>	org-agenda-do-date-later
;; S-<up>		org-agenda-priority-up
;; <backspace>	org-agenda-show-scroll-down
;; <down>		org-agenda-next-line
;; <mouse-2>	org-agenda-goto-mouse
;; <mouse-3>	org-agenda-show-mouse
;; <tab>		org-agenda-goto
;; <undo>		org-agenda-undo
;; <up>		org-agenda-previous-line
;; M-*		org-agenda-bulk-toggle-all
;; M-m		org-agenda-bulk-toggle
;; C-c C-a		org-attach
;; C-c C-c		org-agenda-ctrl-c-ctrl-c
;; C-c C-d		org-agenda-deadline
;; C-c C-n		org-agenda-next-date-line
;; C-c C-o		org-agenda-open-link
;; C-c C-p		org-agenda-previous-date-line
;; C-c C-q		org-agenda-set-tags
;; C-c C-s		org-agenda-schedule
;; C-c C-t		org-agenda-todo
;; C-c C-w		org-agenda-refile
;; C-c C-z		org-agenda-add-note
;; C-c $		org-agenda-archive
;; C-c ,		org-agenda-priority
;; C-x C-s		org-save-all-org-buffers
;; C-x C-w		org-agenda-write
;; C-x u		org-agenda-undo
;; <remap> <backward-paragraph>	org-agenda-backward-block
;; <remap> <forward-paragraph>	org-agenda-forward-block
;; <remap> <move-end-of-line>	org-agenda-end-of-line
;; C-c C-x C-a	org-agenda-archive-default
;; C-c C-x C-c	org-agenda-columns
;; C-c C-x C-e	org-clock-modify-effort-estimate
;; C-c C-x TAB	org-agenda-clock-in
;; C-c C-x C-j	org-clock-goto
;; C-c C-x C-o	org-agenda-clock-out
;; C-c C-x C-s	org-agenda-archive
;; C-c C-x C-x	org-agenda-clock-cancel
;; C-c C-x !	org-reload
;; C-c C-x <	org-agenda-set-restriction-lock-from-agenda
;; C-c C-x >	org-agenda-remove-restriction-lock
;; C-c C-x A	org-agenda-archive-to-archive-sibling
;; C-c C-x I	org-info-find-node
;; C-c C-x _	org-timer-stop
;; C-c C-x a	org-agenda-toggle-archive-tag
;; C-c C-x b	org-agenda-tree-to-indirect-buffer
;; C-c C-x e	org-agenda-set-effort
;; C-c C-x p	org-agenda-set-property
;; C-c C-x <down>	org-agenda-priority-down
;; C-c C-x <left>	org-agenda-do-date-earlier
;; C-c C-x <right>	org-agenda-do-date-later
;; C-c C-x <up>	org-agenda-priority-up
;; C-c C-x RET g	org-mobile-pull
;; C-c C-x RET p	org-mobile-push

;;
;; My 'org-agenda-mode' bindings
;;
(defun my-org-agenda-mode-bindings (map)
  	;;
  	;; '<C-j>' and '<C-k>' jump between items
  	;;
  	(keymap-set map "C-j" 'org-agenda-next-line)
  	(keymap-set map "C-k" 'org-agenda-previous-line)

  	;;
  	;; 'u' to Undo
  	;;
  	(keymap-set map "u" 'org-agenda-undo)

  	;;
  	;; '/' to filter
  	;;
  	(keymap-set map "/" 'org-agenda-filter)

  	;;
  	;; 'RET' to open selected item
  	;;
  	(keymap-set map "RET" 'org-agenda-switch-to)

)

;;
;; Call 'my-org-agenda-mode-binding' with 'evil-normal-state-local-map'
;;
(defun my-org-agenda-mode-local-bindings ()
	(my-org-agenda-mode-bindings evil-normal-state-local-map)
)


;;
;; Then, add it to the 'org-agenda-mode-hook'
;;
(add-hook 'org-agenda-mode-hook #'my-org-agenda-mode-local-bindings)

(defun my-minibuffer-mode-local-bindings ()
	(keymap-set minibuffer-mode-map "C-h" 'previous-history-element)
	(keymap-set minibuffer-mode-map "C-l" 'next-history-element)
)

(add-hook 'minibuffer-setup-hook #'my-minibuffer-mode-local-bindings)
