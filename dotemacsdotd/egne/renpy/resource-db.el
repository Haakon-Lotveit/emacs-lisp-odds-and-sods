(defvar renpy-asset-store "~/assets-renpy")

(defvar renpy-assets (make-hash-table :test 'equal))

(defun renpy-asset-set-store (directory)
  (interactive "fWhere should renpy-asset-store look for images? ")
  (setf renpy-asset-store directory)
  (renpy-asset-discover-image-assets))


(defun renpy-asset-add-image (image-file full-name)
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
    (messange "Imported image file %s\nNew name: %s" image-file import-file-to)
    (discover-image-assets)))

;; The list of usable file formats is taken from  http://www.renpy.org/wiki/renpy/Why_Ren'Py%3F 
(defun file-image-p (file)
  "Returns true if the file is one of the formats supported by Ren'Py"
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

(defun renpy-asset-discover-image-assets-recurse (dir)
  (let ((files (cl-remove-if (lambda (str)
			       (or (equal "."  str)
				   (equal ".." str)))
			     (directory-files dir))))
    (mapcar (lambda (file)
	      (cond
	       ((file-directory-p (format "%s/%s" dir file))
		(renpy-asset-discover-image-assets-recurse (format "%s/%s" dir file)))
	       ((file-image-p (format "%s/%s" dir file))
		(make-entry-for-file (format "%s/%s" dir file)))
	       ('otherwise
		(message "Skipping file %s" file))))
	    files)))


(defun renpy-asset-discover-image-assets () 
  "Looks in the directory specified by `renpy-asset-store' and builds a database out of the images in the folders and subfolders"
  (interactive)
  (clrhash renpy-assets)
  (renpy-asset-discover-image-assets-recurse (format "%s/%s" renpy-asset-store "images")))

(defun renpy-asset-print-characters ()
  "print all characters that the asset database knows about in a user friendly manner"
  (interactive)
  (message "Characters: %s" (mapconcat 'identity (renpy-asset-list-characters) ", ")))

(defun renpy-asset-list-characters ()
  "Returns a list of all the characters that the asset database knows about"
  (let ((output nil))
    (maphash (lambda (key val)
	       (push key output))
	     renpy-assets)
    output))

(defun renpy-asset-import-image-resource (name)
  "Inserts all the images for the character that the database knows about.\nNotice that bg or background is often used for backgrounds, and thus you can import those images too."
  (interactive "sCharacter: ")
  (move-end-of-line nil)
  (insert (format "\n\n# Character: %s" name))
  (maphash (lambda (key value)
	     (renpy-import-image value key))
	   (gethash name renpy-assets)))

(defun renpy-import-image (image name)
  "Imports an image into your project at the next line"
  (interactive "fImage file you wish to import: \nsName of this image: ")
  (let* ((names (split-string name))
	 (paths `("images" . ,(butlast names)))
	 (filename (format "%s.%s"
			   (car (last names))
			   (file-name-extension image)))
	 (new-path (mapconcat 'identity paths "/"))
	 (import-name (format "%s/%s" new-path filename))
	 (current-path (file-name-directory (buffer-file-name)))
	 (destination (format "%s%s" current-path import-name)))
    (make-directory (file-name-directory destination) t)
    (copy-file image destination nil)
    (insert (format "\nimage %s = \"%s\"" name import-name))))

(defun renpy-asset-generate-character (character colour)
  "generates a character, for example 'define fifi = Character(\"Fifi\" 363636)'"
  (interactive "sCharacter name: \nsColour: ")
  (move-end-of-line nil)
  (insert (format "\ndefine %s = Character('%s', color=\"%s\")" character (capitalize character) colour)))

(defun renpy-asset-import-every-image ()
  "Inserts all the sprites that the database knows about."
  (interactive)
  (move-end-of-line nil)
  (insert "\n\n#########################################")
  (insert   "\n# All character sprites and backgrounds #")
  (insert   "\n#########################################")
  (mapcar 'renpy-asset-import-image-resource
	  (renpy-asset-list-characters))
  (insert "\n# END OF SPRITES\n")
  (insert "\n\n# Characters used by the game")
  (mapcar (lambda (char)
	    (renpy-asset-generate-character char "#333333"))
	  (renpy-asset-list-characters))
  (insert "\n"))

(renpy-asset-discover-image-assets)

(provide 'renpy-asset-store)
