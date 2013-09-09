(module turtle racket ;; racket/gui racket/draw
  (require racket/gui)  
  (require racket/draw)

  (provide turtle%)

  (define turtle%
    (class object%
      (init in-dc
            [in-pen (new pen% [color "black"] [width 2])]
            [in-x 150]
            [in-y 150]
            [in-pen-down? #t])
      (field (dc in-dc))
      (field (pen in-pen))
      
      (send dc set-pen pen)

      (field (pos-x in-x))
      (field (pos-y in-y))

      ;; turtle is looking "up" on default
      (field (angle (/ pi 2))) 
      (field (pen-down? in-pen-down?))

      (define/public (pen-up)
        (set! pen-down? #f))

      (define/public (pen-down)
        (set! pen-down? #t))

      (define/public (forward val)
        (let ([xd (* val (cos angle))]
              [yd (* val (sin angle))])
          (when pen-down?
            (send dc draw-line pos-x pos-y 
                  (+ pos-x xd) (- pos-y yd)))
          (set! pos-x (+ pos-x xd))
          (set! pos-y (- pos-y yd))))

      (define/public (back val)
        (let ([xd (* val (cos angle))]
              [yd (* val (sin angle))])
          (when pen-down?
            (send dc draw-line pos-x pos-y 
                  (- pos-x xd) (+ pos-y yd)))
          (set! pos-x (- pos-x xd))
          (set! pos-y (+ pos-x yd))))

      (define/public (left degr)
        (set! angle (+ angle (degrees->radians degr))))

      (define/public (right degr)
        (set! angle (- angle (degrees->radians degr))))

      (super-new)))
)

