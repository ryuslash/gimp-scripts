(define (split-filename filename)
  (let ((ext (memv #\. (string->list filename))))
    (cons
     (substring filename 0 (- (string-length filename) (length ext)))
     (list->string (cdr ext)))))

(define (string-minus str num)
  (substring str 0 (- (string-length str) num)))

(define (unretina-save image)
  (let* ((parts (split-filename (car (gimp-image-get-filename image))))
         (newname (string-append (string-minus (car parts) 3) "."
                                 (cdr parts))))
    (gimp-file-save RUN-NONINTERACTIVE image
                    (car (gimp-image-get-active-drawable image))
                    newname newname)))

(define (unretina image)
  (unretina-save (half image)))

(define (half image)
  (let ((newwidth (/ (car (gimp-image-width image)) 2))
        (newheight (/ (car (gimp-image-height image)) 2)))
    (gimp-image-scale image newwidth newheight))
  (gimp-displays-flush)
  image)

(script-fu-register "half"
                    "Halfsize image"
                    "Reduce the size of an image to 50%"
                    "Tom Willemse <tom@ryuslash.org>"
                    "Tom Willemse"
                    "2014-11-18"
                    "RGB*, GRAY*"
                    SF-IMAGE "Image" 0)
(script-fu-menu-register "half" "<Image>/Picturefix")

(script-fu-register "unretina"
                    "Unretina image"
                    "Reduce the size of an image and rename for non-retina displays."
                    "Tom Willemse <tom@ryuslash.org>"
                    "Tom Willemse"
                    "2014-12-01"
                    "RGB*, GRAY*"
                    SF-IMAGE "Image" 0)
(script-fu-menu-register "unretina" "<Image>/Picturefix")
