;; --------------------------------------------------------------------------------------------
;; Remove title bar for the Mac (GUI) version
;; --------------------------------------------------------------------------------------------
;;  (if (string-equal "darwin" system-type)
;;       (progn
;;           ;;
;;           ;; By setting this, you don't need to figure out it's the terminal version or GUI version.
;;           ;;
;;           (add-to-list 'default-frame-alist '(undecorated . t))
;;           (message ">>> Remove title bar for Mac GUI version.")
;;       )
;;  )

;; --------------------------------------------------------------------------------------------
;; Set font and transparent after creating the frame (window)
;; --------------------------------------------------------------------------------------------

;;
;; Set my font
;;
(defun my-set-font()
   (set-face-attribute 'default nil
       :family "SauceCodePro Nerd Font"
       ;;:family "JetBrainsMono Nerd Font"
       :weight 'semi-bold
       :height 140
       ;; :italic t
   )
   (message ">>> [ early-init > my-set-font ] Set my custom font.")
)

;;
;; Set transparent background for GUI
;;
(defun my-set-transparent-gui()
  (message ">>> [ early-init > my-set-transarent-background ] - call 'my-set-transparent-gui'")
  ;;
  ;; Force to set a particular background color for better transparent effect.
  ;;
  ;; (set-face-attribute 'default nil :background "#23211B")

  (set-frame-parameter nil 'alpha-background 95)
  (add-to-list 'default-frame-alist '(alpha-background . 95))
)

;;
;; Set transparent background for terminal
;;
(defun my-set-transparent-terminal()
  (message ">>> [ early-init > my-set-transarent-background ] - call 'my-set-transparent-terminal'")
  (set-face-attribute 'default nil :background "nil")
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
(defun my-set-transarent-background(current_frame)
  (message ">>> [ early-init > my-set-transarent-background ] - display-graphics-p result: %s" (display-graphic-p current_frame))
  (if (display-graphic-p current_frame)
          (my-set-transparent-gui)
          (my-set-transparent-terminal)
  )
)

;;
;; Call set font function and set transparent function in standalone mode or daemon mode
;;
(if (daemonp)
    (add-hook 'after-make-frame-functions
        (lambda (frame)
            (with-selected-frame frame
              (message ">>> [ early-init ] Run lambda funtion in 'after-make-frame-functions' hook.")
              (progn
                  (message ">>> [ early-init ] lambda funtion set font and transparent background in 'after-make-frame-functions' hook.")
                  (my-set-font)
                  (my-set-transarent-background frame)
              )
              (message ">>> [ early-init ] Run lambda funtion in 'after-make-frame-functions' hook [ done ].")
                          ))
        )
    (add-hook 'emacs-startup-hook
        (lambda ()
            (message ">>> [ early-init ] Run lambda funtion in 'emacs-startup-hook' hook.")
            (progn
                (message ">>> [ early-init ] lambda funtion set font and transparent background in 'emacs-startup-hook' hook.")
                (my-set-font)
                (my-set-transarent-background nil)
            )
            (message ">>> [ early-init ] Run lambda funtion in 'emacs-startup-hook' hook [ done ].")
        )
        )
)
