;; Java snarveier for økt produktivitet. 
;; Hele elispen er under opprydning, så endringer kan forekomme.
;; Mye her vil bli flyttet til YASnippet snutter.
;; funksjon        snarvei
;;
;; Move to YASNIPPET
;; print statements:
;; out.printf      C-c C-p (f)
;; out.prinln      C-c C-p (l)
;; out.print       C-c C-p (p)
;;
;; Move to YASNIPPET
;; flow statements
;; if(){}          C-c (i)
;; else{}          C-c (e)
;;
;; Move to YASNIPPET
;; loop statements
;; while           C-c C-l (w)
;; do-while        C-c C-l (d)
;; for             C-c C-l (f)
;;
;; These three are fine.
;; code structure 
;; open-codeblock C-c (j)
;; close -"-      C-c (k)
;;
;; new classes (Deprecated, should be methods for creating new files instead).
;; class          aliased to "cs"
;; private class  aliased to "prics"
;; public class   aliased to "pucs"
;; protected clas aliased to "procs"
;; main-method    aliased to "mm"
;;
;; GUI stuffs.  ;;; ALL TO DO ;;;
;; 
;; popups:        ;; TODO ;;
;;
;; Input popups:
;; String         aliased to "strpop"
;; Integer        aliased to "intpop"
;; Double         aliased to "doupop"
;;
;; Message popups:
;;
;; normal box     aliased to "mesbox"
;;

;; alt ligger i en hook, slik at en ikke kan kalle metodene utenfor java-mode
'(require yas/minor-mode-on)

(add-hook 'java-mode-hook
	  '(lambda ()
             ;; Vi ønsker å ha YASnippet sin minor mode når vi bruker java.
             (yas/minor-mode-on)
             ;; Variabler: Rediger disse for å endre på enkel oppførsel
             (defvar java-author-name "Haakon Løtveit")
             
	     ;; Printing shortcuts - should all go to YASnippets
	     (defun java-printf-statement ()
	       "Inserts System.out.printf(); at the cursor position, and moves cursor inside the parens"
	       (interactive)
	       (insert "System.out.printf();")
	       (indent-according-to-mode)
	       (backward-char 2))

	     (defun java-print-statement ()
	       "inserts System.out.print(); at the cursor position, and moves cursor inside the parens"
	       (interactive)
	       (insert "System.out.print();")
	       (indent-according-to-mode)
	       (backward-char 2))

	     (defun java-println-statement ()
	       "inserts System.out.println(); at the cursor position, and puts the cursor inside the parens"
	       (interactive)
	       (insert "System.out.println();")
	       (indent-according-to-mode)
	       (backward-char 2))

	     ;; Control flow shortcuts
	     (defun java-for-loop-statement ()
	       "Inserts a basic for loop structure"
	       (interactive)
	       (indent-according-to-mode)
	       (insert "for()")
	       (java-codeblock)
	       (previous-line)
	       (move-end-of-line nil)
	       (backward-char 3))

	     (defun java-while-loop-statement (condition)
	       "Inserts a basic while loop structure"
	       (interactive)
	       (insert "while()")
	       (java-codeblock) 
	       (previous-line)
	       (move-end-of-line nil)
	       (backward-char 3))

	     (defun java-do-while-loop-statement (condition)
	       "Inserts a basic do-while loop structure"
	       (interactive "sCondition: ")
	       (insert "do{\n\n}while(" condition ");")
	       (indent-according-to-mode)
	       (previous-line)
	       (indent-according-to-mode))

	     (defun java-if-statement (condition)
	       "inserts an if statement."
	       (interactive "sCondition: ")
	       (insert "if(" condition ")")
	       (java-codeblock))

	     (defun java-codeblock ()
	       "gives you a new codeblock, at cursor, and puts you in the middle of it."
	       (interactive)
	       (just-one-space)
	       (insert "{")
	       (indent-according-to-mode)
	       (newline 2)
	       (insert "}")
	       (indent-according-to-mode)
	       (previous-line)
	       (indent-according-to-mode))

	     ;; Documentation shortcuts
	     (defun java-author-stub ()
	       "Inserts a short javadoc stub declaring copyright."
	       (interactive)
               (java-doc-comment)
	       (insert "@author Haakon Løtveit ©" (format-time-string "%Y"))
               (next-line 1)
               (newline-and-indent))

	     (defun java-multi-line-comment ()
	       "Inserts a simple multi-line comment"
	       (interactive)
	       (insert "/* \n*/")
	       (indent-according-to-mode)
	       (backward-char 4))


	     (defun java-line-comment ()
	       "Inserts a simple single-line comment"
	       (interactive)
	       (insert "/*  */")
	       (indent-according-to-mode)
	       (backward-char 3))


	     (defun java-doc-comment ()
	       "Inserts a simple java-doc comment (/**, newline, comment, newline, */)"
	       (interactive)
               (indent-according-to-mode)
	       (insert "/**\n* \n*/")
               (previous-line 1)
               (indent-according-to-mode)
               (next-line 1)
               (indent-according-to-mode)
               (previous-line 1)
               (move-end-of-line 1))

	     ;; Declaration shortcuts
	     (defun java-noninteractive-class-stub (type description name)
	       "Inserts a short class stub, called by other functions."
	       (newline 2)
               (insert "/**")
               (indent-according-to-mode)
               (c-indent-new-comment-line)
               (insert "@author " java-author-name " " (format-time-string "%Y"))
               (if description
                   (progn
                     (c-indent-new-comment-line)
                     (insert description)))
               (newline 1)
               (insert "*/")
               (indent-according-to-mode)
               (newline-and-indent)
               (insert
                ;; Hvis type ikke er tom, sett inn type og et mellomrom.
                (if type (concat type " "))
                "class "
                name
                "{")
	       (newline 2)
	       (insert "}")
	       (indent-according-to-mode)
	       (previous-line)
	       (indent-according-to-mode))
	     
	     (defun java-public-class-stub (description)
	       "Inserts a short public class stub"
               (interactive "sDescribe class in a sentence (declaratively): ")
               (let ((filename
                      (replace-regexp-in-string "\\.[^.]+$" ;; FIXME: siste punktumet er ikke escapet.
                                                ""
                                                (replace-regexp-in-string "/.+/"
                                                                          ""
                                                                          (buffer-file-name)))))
                 (message filename)
                 (if (not filename)
                     (setq filename "NONAME"))
                 (message filename)
                 (java-noninteractive-class-stub "public"
                                                 description
                                                 filename)))

	     (defun java-private-class-stub (name description)
	       "Inserts a short private class stub"
	       (interactive "sClassname: \nsDescribe class in a sentence (declaratively): ")
	       (java-noninteractive-class-stub "private" description name))

	     (defun java-protected-class-stub (name description)
	       "Inserts a short protected class stub"
	       (interactive "sClassname: \nsDescribe class in a sentence (declaratively): ")
	       (java-noninteractive-class-stub "protected" description name))

	     (defun java-class-stub (type name description)
	       (interactive "sEnter type: \nsClassname: \nsDescribe class in a sentence (declaratively): ")
	       (java-noninteractive-class-stub type description name))

	     
	     (defun java-main-stub ()
	       "Inserts a main-method stub (public static void main(String[] args){)"
	       (interactive)
	       (insert "public static void main(String[] args){")
	       (indent-according-to-mode)
	       (newline 2)
	       (insert "}")
	       (indent-according-to-mode)
	       (previous-line)
	       (indent-according-to-mode))
	     

	     ; Some GUI shortcuts. Basic stuff, really. :)
	     (defun java-basic-message-box (parent message title type)
	       "Input description:\n\t PARENT: The parent window.\n\tMESSAGE: The message you want displayed.\n\t  TITLE: The window title.\n\t   TYPE: The message type.\n\t         Note that the\"_MESSAGE\" part will be automatically added.\n\nLet's you painlessly make a messagebox that displays a message.\nRemember to add quotation marks (\") when entering string literals.\nThis little snippet will go to pains to ensure sane defaults are given.\n\nBe aware that Emacs dislikes and frowns on allcaps words in documentation." ;This is just documentation, do not worry over it!

	       (interactive "sParent: \nsMessage (string or variable of Object): \nsTitle: \nsType (PLAIN INFORMATION QUESTION WARNING ERROR): ") ; And this mess is just specifying what input I want from you.
	       (let
		   ((separator ", ") (class "javax.swing.JOptionPane"))
		 (insert 
		  class ".showMessageDialog("
		  (if (equal parent "") "null" parent) separator
		  message 
		  (if (and (equal title "") (equal type ""))
		      ");"
		    (concat separator
			    (if (equal "" title) "MESSAGE" title) separator
			    class "."
			    
			    (if (or (equal (upcase type) "INFORMATION")
				    (equal (upcase type) "QUESTION")
				    (equal (upcase type) "WARNING")
				    (equal (upcase type) "ERROR"))
				(upcase type)
			      "PLAIN")
			    "_MESSAGE);"))))
	     (newline-and-indent))
	     	     
	     (defun java-noninteractive-input-box (parent message title type)
	       "This provides some abstraction from the interactive input-box functions"
	       (let
		   ((separator ", ") (class "javax.swing.JOptionPane"))
		 (insert (concat
			  class ".showInputDialog("
			  (if (equal parent "") "null" parent) separator
			  message separator
			  (if (equal "" title) "INPUT" title) separator
			  class "."
			  (if 
			      (equal "" type)
			      "PLAIN"
			    (upcase type))
			  "_MESSAGE)"))))
	     

	     (defun java-string-input-box (parent message title type)
	       "Painless String input box. For more documentation, see the docs on java-basic-message box."
	       (interactive "sParent: \nsMessage: \nsTitle: \nsType (PLAIN INFORMATION QUESTION WARNING ERROR): ")
	       (java-noninteractive-input-box parent message title type)
	       (insert ";"))

					; This copypasting sickens me, but I couldn't find a way to avoid it. Can anyone enlighten me? PLEASE?
	     (defun java-int-input-box (parent message title type)
	       "Painless int input box. For more documentation, see the docs on java-basic-message box."
	       (interactive "sParent: \nsMessage: \nsTitle: \nsType (PLAIN INFORMATION QUESTION WARNING ERROR): ")
	       (insert "Integer.parseInt(")
	       (java-noninteractive-input-box parent message title type)
	       (insert ");")
	       (indent-according-to-mode))

	     (defun java-double-input-box (parent message title type)
	       "Painless double input box. For more documentation, see the docs on java-basic-message box."
	       (interactive "sParent: \nsMessage: \nsTitle: \nsType (PLAIN INFORMATION QUESTION WARNING ERROR): ")
	       (insert "Double.parseDouble(")
	       (java-noninteractive-input-box parent message title type)
	       (insert ");")
	       (indent-according-to-mode))
	     
	     (defun java-float-input-box (parent message title type)
	       "Painless float input box. For more documentation, see the docs on java-basic-message box."
	       (interactive "sParent: \nsMessage: \nsTitle: \nsType (PLAIN INFORMATION QUESTION WARNING ERROR): ")
	       (insert "Float.parseFloat(")
	       (java-noninteractive-input-box parent message title type)
	       (insert ");")
	       (indent-according-to-mode))

	     (defun java-boolean-input-box (parent message title type)
	       "Painless boolean input box. For more documentation, see the docs on java-basic-message box."
	       (interactive "sParent: \nsMessage: \nsTitle: \nsType (PLAIN INFORMATION QUESTION WARNING ERROR): ")
	       (insert "Boolean.parseBoolean(")
	       (java-noninteractive-input-box parent message title type)
	       (insert ");")
	       (indent-according-to-mode))



	     ;; Aliases
	     (defalias 'main
	       'java-main-stub)
	     (defalias 'cs
	       'java-class-stub)
	     (defalias 'pucs
	       'java-public-class-stub)
	     (defalias 'prics
	       'java-private-class-stub)
	     (defalias 'procs
	       'java-protected-class-stub)

	     ;; Commenting shortcuts.
	     ;; Memnonic: C-Document
	     (define-key java-mode-map (kbd "C-c C-d c")
	       'java-line-comment)
	     (define-key java-mode-map (kbd "C-c C-d C-c")
	       'java-line-comment)
	     (define-key java-mode-map (kbd "C-c C-d d")
	       'java-doc-comment)
	     (define-key java-mode-map (kbd "C-c C-d C-d")
	       'java-doc-comment)
	     (define-key java-mode-map (kbd "C-c C-d l")
	       'java-multi-line-comment)
	     (define-key java-mode-map (kbd "C-c C-d C-l")
	       'java-multi-line-comment)
	     
	     ;; Printing shortcuts
	     ;;Memnonic: C-Print
	     (define-key java-mode-map (kbd "C-c C-p f")
	       'java-printf-statement)
	     (define-key java-mode-map (kbd "C-c C-p C-f")
	       'java-printf-statement)
	     (define-key java-mode-map (kbd "C-c C-p l")
	       'java-println-statement)
	     (define-key java-mode-map (kbd "C-c C-p C-l")
	       'java-println-statement)
	     (define-key java-mode-map (kbd "C-c C-p p")
	       'java-print-statement)
	     (define-key java-mode-map (kbd "C-c C-p C-p")
	       'java-print-statement)

	     ;; Program flow shortcuts
	     (define-key java-mode-map (kbd "C-c i")
	       'java-if-statement)
	     (define-key java-mode-map (kbd "C-c C-i")
	       'java-if-statement)

	     ;; Loop shortcuts
	     (define-key java-mode-map (kbd "C-c C-l f")
	       'java-for-loop-statement)
	     (define-key java-mode-map (kbd "C-c C-l C-f")
	       'java-for-loop-statement)
	     (define-key java-mode-map (kbd "C-c C-l w")
	       'java-while-loop-statement)
	     (define-key java-mode-map (kbd "C-c C-l C-w")
	       'java-while-loop-statement)
	     (define-key java-mode-map (kbd "C-c C-l d")
	       'java-do-while-loop-statement)
	     (define-key java-mode-map (kbd "C-c C-l C-d")
	       'java-do-while-loop-statment)

	     ;; Program structure shortcuts
	     (define-key java-mode-map (kbd "C-c j")
	       'java-codeblock)
	     (define-key java-mode-map (kbd "C-c k")
	       'java-close-codeblock)
	     (define-key java-mode-map (kbd "C-c C-j")
	       'java-codeblock)
	     (define-key java-mode-map (kbd "C-c C-k")
	       'java-close-codeblock)

             ;; Compilation shortcut
             (define-key java-mode-map (kbd "C-c C-c")
               'compile)
             (define-key java-mode-map (kbd "C-c c")
               'compile)
	     )
	  )




