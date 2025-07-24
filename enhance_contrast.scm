; Save as enhance_contrast.scm
(define (script-fu-enhance-contrast input output)
  (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE input input)))
    (gimp-context-set-interpolation INTERPOLATION-NONE)
    (gimp-brightness-contrast (car (gimp-image-get-active-layer image)) 0 127)
    (file-jpeg-save RUN-NONINTERACTIVE image (car (gimp-image-get-active-layer image)) 
                   output output 0.95 0 1 1 "KaleidoGenerator" 0 1 0 0)
    (gimp-image-delete image)))

; Register the script
(script-fu-register
  "script-fu-enhance-contrast"
  "Enhance Contrast"
  "Maximizes contrast while preserving brightness"
  "Your Name"
  "Your Copyright"
  "2024"
  ""
  SF-FILENAME "Input File" ""
  SF-FILENAME "Output File" ""
)
