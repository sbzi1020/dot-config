;;
;; Speed up booting speed by increasing the 'gc-cons-threshold'
;;
(message ">>> [ early-init ] default 'gc-cons-threshold': %d" gc-cons-threshold)
(setq gc-cons-threshold (* 100 1000 1000))
(message ">>> [ early-init ] increased 'gc-cons-threshold': %d" gc-cons-threshold)

;; --------------------------------------------------------------------------------------------
;; GUI version only, as no effects on the TUI version:
;;
;; - Remove title bar
;; - Increase the internal window gaps
;;
;; You can find all supported frame attributes from the emacs source code 'frame.el':
;;
;; For example:
;;
;; '/usr/local/Cellar/emacs-plus@30/30.1/share/emacs/30.1/lisp/frame.el'
;;
;; After opening the 'frame.el', search for the 'frame-geometry' function, then see all of them
;;
;; --------------------------------------------------------------------------------------------
(progn
	(add-to-list 'default-frame-alist '(undecorated . t))
	(add-to-list 'default-frame-alist '(internal-border-width . 20))
	(message ">>> Applied custom settings to the GUI version: Removed title bar, increase the window gaps.")
)

;; --------------------------------------------------------------------------------------------
;; Set font and transparent after creating the frame (window)
;; --------------------------------------------------------------------------------------------

;;
;; Set my font
;;
(defun my-set-font ()
	(set-face-attribute 'default nil
		:family "JetBrainsMono Nerd Font"
		:weight 'semi-bold
		:height 140
		;; :italic t
	)

	(if (display-graphic-p nil)
		(progn
			(let ((font-size-in-pixel 170))
				(if (and (eql (display-pixel-width) 2560) (eql (display-pixel-height) 1440))
					(setq font-size-in-pixel 190))
				(set-face-attribute 'default nil
					:family "JetBrainsMono Nerd Font"
					:weight 'semi-bold
					:height font-size-in-pixel
					;; :italic t
					)

				(message
					">>> [ my-set-font ] GUI mdoe, font-size-in-pixel: %d"
					font-size-in-pixel)
			))
	)
)

;;
;; Set transparent background for GUI
;;
(defun my-set-transparent-gui ()
	(message ">>> [ early-init > my-set-transparent-gui ] - called")

	(if (string-equal "darwin" system-type)
		(progn
			(set-frame-parameter nil 'alpha 95)
			(add-to-list 'initial-frame-alist '(alpha . 95))
			(add-to-list 'default-frame-alist '(alpha . 95))
		)
		(progn
			(set-frame-parameter nil 'alpha-background 95)
			(add-to-list 'initial-frame-alist '(alpha-background . 95))
			(add-to-list 'default-frame-alist '(alpha-background . 95))
		)
	)
)

;;
;; Set transparent background for terminal
;;
(defun my-set-transparent-terminal()
	(message ">>> [ early-init > my-set-transparent-terminal() ] - called")
	(set-face-background 'default "unspecified-bg" nil)
)

;;
;; Setting the transparent background is very different between GUI mode and Terminal mode, so you
;; better do that in the a hook handler (especially after the init window frame has been created
;; and the color theme has been loaded)
;;
;; For detailed steps about =Emacs= startup sequence, read this:
;;
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Startup-Summary.html
;;
(defun my-set-transparent-background ()
	(message
		">>> [ early-init > my-set-transparent-background ] - display-graphic-p result: %s"
		(display-graphic-p (selected-frame)))

	(if (display-graphic-p (selected-frame))
			(my-set-transparent-gui)
			(my-set-transparent-terminal)
	)
)

;;
;; Call set font function in both standalone mode or daemon mode
;;
(if (daemonp)
    (add-hook 'after-make-frame-functions
        (lambda (frame)
            (with-selected-frame frame
              (message ">>> [ early-init ] Run lambda funtion in 'after-make-frame-functions' hook.")
              (my-set-font)
              (message ">>> [ early-init ] lambda funtion set font in 'after-make-frame-functions' hook.")
              (message ">>> [ early-init ] Startup took %s seconds with %d garbage collections" (emacs-init-time "%.2f") gcs-done)
            )
        )
    )
    (add-hook 'emacs-startup-hook
        (lambda ()
            (message ">>> [ early-init ] Run lambda funtion in 'emacs-startup-hook' hook.")
            (my-set-font)
            (message ">>> [ early-init ] lambda funtion set font in 'emacs-startup-hook' hook.")
            (message ">>> [ early-init ] Startup took %s seconds with %d garbage collections" (emacs-init-time "%.2f") gcs-done)
        )
    )
)
