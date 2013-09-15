(module turtle racket
  (require racket/gui)  
  (require racket/draw)
  (require racket/stxparam)

  (provide turtle%)
  (provide with-turtle forward back left right pen-down pen-up)

  (define-syntax-parameter forward 
    (lambda (stx) (raise-syntax-error #f "Not used inside `with-turtle'!" stx)))

  (define-syntax-parameter back 
    (lambda (stx) (raise-syntax-error #f "Not used inside `with-turtle'!" stx)))

  (define-syntax-parameter right 
    (lambda (stx) (raise-syntax-error #f "Not used inside `with-turtle'!" stx)))

  (define-syntax-parameter left 
    (lambda (stx) (raise-syntax-error #f "Not used inside `with-turtle'!" stx)))

  (define-syntax-parameter pen-down 
    (lambda (stx) (raise-syntax-error #f "Not used inside `with-turtle'!" stx)))

  (define-syntax-parameter pen-up 
    (lambda (stx) (raise-syntax-error #f "Not used inside `with-turtle'!" stx)))

;; TODO. make turtle accessible via dynamic binding

  (define-syntax (with-turtle stx)
    (syntax-case stx () 
      [(with-turtle t forms ...)
       #'(local [(define (t-forward v) (send t forward v))
                 (define (t-back v)    (send t back v))
                 (define (t-right a)   (send t right a))
                 (define (t-left a)    (send t left a))
                 (define (t-pendown)   (send t pen-down))
                 (define (t-penup)   (send t pen-up))]

           (syntax-parameterize ([forward (make-rename-transformer #'t-forward)]                               
                                 [back (make-rename-transformer #'t-back)]
                                 [left (make-rename-transformer #'t-left)]
                                 [right (make-rename-transformer #'t-right)]
                                 [pen-up (make-rename-transformer #'t-penup)]
                                 [pen-down (make-rename-transformer #'t-pendown)])
                                forms ...))]))

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
      (field (angle-deg 90))
      (field (angle (/ pi 2))) 
      (field (pen-down? in-pen-down?))

      (define/public (pen-up)
        (set! pen-down? #f))

      (define/public (pen-down)
        (set! pen-down? #t))

      (define/public (forward val)
        (let* ([xd (* val (cos angle))]
               [yd (* val (sin angle))]
               [nx (+ pos-x xd)]
               [ny (+ pos-y yd)])
          (when pen-down?
            (send dc draw-line pos-x pos-y 
                  nx ny))
          (set! pos-x nx)
          (set! pos-y ny)))

      (define/public (back val)
        (let ([xd (* val (cos angle))]
              [yd (* val (sin angle))])
          (when pen-down?
            (send dc draw-line pos-x pos-y 
                  (- pos-x xd) (+ pos-y yd)))
          (set! pos-x (- pos-x xd))
          (set! pos-y (+ pos-x yd))))

      (define/public (left degr)
        (set! angle-deg (+ angle-deg degr))
        (set! angle (degrees->radians angle-deg)))

      (define/public (right degr)
        (set! angle-deg (- angle-deg degr))
        (set! angle (degrees->radians angle-deg)))

      (super-new)))
  )

