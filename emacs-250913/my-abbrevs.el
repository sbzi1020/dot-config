;;
  ;; Clear it
  ;;
  (clear-abbrev-table global-abbrev-table)

  ;;
  ;; Signature
  ;; (define-abbrev-table TABLENAME DEFINITIONS &optional DOCSTRING &rest PROPS)
  ;;
  ;; Documentation
  ;; Define TABLENAME (a symbol) as an abbrev table name.
  ;;
  ;; Define abbrevs in it according to DEFINITIONS, which is a list of elements
  ;; of the form (ABBREVNAME EXPANSION ...) that are passed to define-abbrev.
  ;;
  (define-abbrev-table 'global-abbrev-table '(
      ("afaik" "as far as I know" not-insert-space)
      ("bg" "background" not-insert-space)
      ("fg" "foreground" not-insert-space)
      (":mygithub" "https://github.com/wisonye" not-insert-space)
      (":mylinkedin" "https://www.linkedin.com/in/wison-y-51888887/" not-insert-space)
      (":now" "" my-abbr-now)
      (":nowdateonly" "" my-abbr-now-only-date)
      (":nowtimeonly" "" my-abbr-now-only-time)
  ))


;;
;; The ":mg" aabrev above needs an extra settings to make it work, as ':' is NOT
;; considered at part of the word you expected!!!
;;
;; You need to modify the properties of the abbreviation table to accept characters
;; that are not word consituents.
;;
;; You need to call `abbrev-table-put' to set the 'props' to the abbrev table:
;;
;; Signature
;; (abbrev-table-put TABLE PROP VAL)
;;
;; To know more about the ':regexp' property, you can run 'info' and goto the section:
;; 'Elisp -> Abbrevs -> Abbrev Properties'
;;
(abbrev-table-put global-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[:_].*\\|.*\\)")

;;
;; Clear it if exists
;;
(when (boundp 'emacs-lisp-mode-abbrev-table)
	(clear-abbrev-table emacs-lisp-mode-abbrev-table)
)

(define-abbrev-table 'emacs-lisp-mode-abbrev-table '(
    ("km" "(keymap-set MODE-MAP \"KEY\" ')" not-insert-space)
    ;; ("mkm" my-keymap-set)
    ("setql" "(setq-local" not-insert-space)
    ("stringempty" "(string-empty-p VAR)" not-insert-space)
    ("stringmatch" "(string-match-p STRING-TO-CHECK VAR)" not-insert-space)
    ("stringnotempty" "(not (string-empty-p VAR))" not-insert-space)
    ("stringnotmatch" "(not (string-match-p STRING-TO-CHECK VAR))" not-insert-space)
))
