#lang racket
(require racket/gui)  
(require racket/draw)

(require "turtle.rkt")

(define (circle t)
  (let loop ([i 0])
    (with-turtle t
                 (forward 1)
                 (right 2))

    (when (< i 360)
      (loop (+ i 1)))))

(define (simple-fig t)
  (with-turtle t
               (pen-down)
               (forward 30)
               (right 45)
               (forward 30)
               (left 135)
               (forward 30)
               (left 45)
               (forward 45)
               (left 45)
               (forward 45)))

(require racket/gui)  
(require racket/draw)

(define (run)
  (let* ([frame (new frame% [label "turtle"])]
         [canvas (new canvas% [parent frame])]
         [dc (send canvas get-dc)]
         [width 640]
         [height 480])

    (send frame show #t)
    (sleep/yield 1)
    
    (let ([t (new turtle% [in-dc dc])])
      (circle t)
      (simple-fig t))
    frame))

(run)
