(require 'cl-lib)

(defvar renpy-asset-store "~/assets-renpy")

;; This is a placeholder var. It will be refactored to actually discover what resources are available
(defvar renpy-assets (make-hash-table :test 'equal))

;; This function is finished, and works.
(defun renpy-assets-import-image (image-file full-name)
  "Imports the image specificed by `image-file' into the asset store in a way consistent with `full-name', which is how this specific image would be imported into your project. So for example the line\nimage anna dress happy = \"images/anna/dress/happy.png\" would have the `full-name' of \"anna dress happy\"."
  (interactive "fImage file to import: \nsThe full name of the image: ")
  (let* ((names (split-string full-name))
	 ;; This means that if you give the name "anna dress happy" the path-list will be ("images" "anna" "dress"). Note that happy is removed.
	 (path-list `("images" . ,(butlast names)))
	 ;; The name of the image file in the above example would be something like happy.png, or happy.jpg. (Although png is better, I'm not judging)
	 (filename (format "%s.%s"
			   (car (last names))
			   (file-name-extension image-file)))
	 ;; This takes the strings in the path-list and sticks a / between them, so ("images" "anna" "dress") becomes "images/anna/dress"
	 (new-path (format "%s/%s" renpy-asset-store (mapconcat 'identity path-list "/")))
	 ;; This makes means that the image should in our example be imported to "~/assets-renpy/images/anna/dress/happy.png"
	 (import-file-to (format "%s/%s" new-path filename)))
    (make-directory new-path t)
    (copy-file image-file import-file-to nil)
    (message "Imported image file %s\nNew name: %s" image-file import-file-to)
    ;; TODO Tell the system to discover the new file
    ))

;; The list of usable file formats is taken from  http://www.renpy.org/wiki/renpy/Why_Ren'Py%3F 
(defun file-image-p (file)
       (member (file-name-extension file nil)
	       '("jpg" "jpeg" "bmp" "png" "gif")))

(defun ensure-get-character (character)
  "This will return the hashmap with all the images that can be imported for this character.\nIf it does not exist, it will be created as an empty hashmap."
  (let ((map (gethash character renpy-assets)))
    (unless map
      (setf map (make-hash-table :test 'equal))
      (puthash character map renpy-assets))
    map))

(defun make-entry-for-file (file)
  (let* ((substring-start (length (format "%s/images/" renpy-asset-store)))
	 (substring-end (- 0 (length (file-name-extension file t))))
	 (subpath (substring file substring-start substring-end))
	 (full-name (replace-regexp-in-string "/" " " subpath))
	 (character-name (first (split-string full-name))))
    (let ((character-map (ensure-get-character character-name)))
      (puthash full-name file character-map)
      (message "Created image for \"%s\" with name \"%s\" for file %s"
	       character-name full-name file))))

(defun discover-image-assets-recurse (dir)
  (let ((files (cl-remove-if (lambda (str)
			       (or (equal "."  str)
				   (equal ".." str)))
			     (directory-files dir))))
    (message "%s" files)
    (mapcar (lambda (file)
	      (cond
	       ((file-directory-p (format "%s/%s" dir file))
		(discover-image-assets-recurse (format "%s/%s" dir file)))
	       ((file-image-p (format "%s/%s" dir file))
		(make-entry-for-file (format "%s/%s" dir file)))
	       ('otherwise
		(message "Skipping file %s" file))))
	    files)))


(defun discover-image-assets ()
  "Looks in the directory specified by `renpy-asset-store' and builds a database out of the images in the folders and subfolders"
  (discover-image-assets-recurse (format "%s/%s" renpy-asset-store "images")))

(discover-image-assets)
	    
(defun renpy-assets-list-characters ()
  (interactive)
  (let ((output nil))
    (maphash (lambda (key val)
	       (push key output))
	     renpy-assets)
    output))

(defun renpy-assets-contains (character)
  (interactive "sCharacter: ")
  (gethash character renpy-assets nil))


(defun import-image-resource (name)
  (interactive "sName (only lucy works now, since we're cheating): ")
  (maphash (lambda (key value)
	     (renpy-import-image value key))
	   (gethash name renpy-assets)))

(import-image-resource "fifi")
(provide 'renpy-asset-database)
