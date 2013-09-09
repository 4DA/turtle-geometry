#lang racket
(require racket/gui)  
(require racket/draw)

(require "turtle.rkt")

(define (circle t)
  (let loop ([i 0])
    (send t forward 1)
    (send t right 1)
    (when (< i 360)
      (loop (+ i 1)))))

(define (simple-fig t)
      (send t pen-down)
      (send t forward 30)
      (send t right 45)
      (send t forward 30)
      (send t left 135)
      (send t forward 30)
      (send t left 45)
      (send t forward 45)
      (send t left 45)
      (send t forward 45))

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

