;;
;;  Remove title bar for the Mac (GUI) version
;;
(if (string-equal "darwin" system-type)
	(progn
	    ;;
	    ;; By setting this, you don't need to figure out it's the terminal version or GUI version.
	    ;;
		;; (add-to-list 'default-frame-alist '(undecorated . t))
		;; (message ">>> Remove title bar for Mac GUI version.")
	)
)
