(define (apply-texture-contrast filename width height)
  (let* (
    (image (car (gimp-image-new width height RGB)))
    (layer (car (gimp-layer-new image width height RGB "Base" 100 NORMAL-MODE)))
  )
    (gimp-image-insert-layer image layer 0 -1)
    (gimp-drawable-fill layer FILL-WHITE)
    (plug-in-solid-noise RUN-NONINTERACTIVE image layer TRUE TRUE (rand) (rand))
    (plug-in-diffuse-hurl RUN-NONINTERACTIVE image layer 20 FALSE)
    (gimp-brightness-contrast layer 0 127)
    (file-png-save RUN-NONINTERACTIVE
                   image layer
                   filename filename
                   0 9 1 1 1 1 1)
    (gimp-image-delete image)
  ))
