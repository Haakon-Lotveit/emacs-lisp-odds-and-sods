;;; UPDATER
;; Experimental way to update stuff that's used in different libraries that are not necessarily available through the package manager

(require 'cl)

;; TODO: Actually finish this.

(defun updater:gnu/linux-update ()
  (message "Updating a GNU/Linux system."))

(defun updater:update ()
  (cond ((eq 'gnu/linux system-type) (updater:gnu/linux-update))
	))

(updater:update)
 

