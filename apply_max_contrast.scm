(define (script-fu-apply-contrast in out)
  (let* ((img (car (gimp-file-load RUN-NONINTERACTIVE in in)))
         (layer (car (gimp-image-get-active-layer img))))
    (gimp-levels-stretch layer)
    (gimp-file-save RUN-NONINTERACTIVE img layer out out)
    (gimp-image-delete img)))

(script-fu-register
  "script-fu-apply-contrast"
  "Apply Max Contrast"
  "Simple contrast script"
  "Your Name"
  "2023"
  ""
  SF-FILENAME "Input" ""
  SF-FILENAME "Output" "")
