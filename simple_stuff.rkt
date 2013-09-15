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

(define (simple-triangle-60 size t)
  (with-turtle t
               (for ([x 3])
                 (forward size)
                 (right 120))))

(define (to-thing t)
  (with-turtle t
               (forward 100)
               (right 90)
               (forward 100)
               (right 90)
               (forward 50)
               (right 90)
               (forward 50)
               (right 90)
               (forward 100)
               (right 90)
               (forward 25)
               (right 90)
               (forward 25)
               (right 90)
               (forward 50)
))

(define (to-thing1 t)
  (for ([x 4])
    (to-thing t)
    ))

(define (to-thing2 t)
  (for ([x 10])
    (to-thing t)
    (with-turtle t
                 (right 10)
                 (forward 50))))

(define (to-thing3 t)
  (for ([x 10])
    (to-thing t)
    (with-turtle t
                 (left 45)
                 (forward 100))))

(require racket/gui)  
(require racket/draw)

(define (run)
  (let* ([frame (new frame% [label "turtle"])]
         [canvas (new canvas% [parent frame])]
         [dc (send canvas get-dc)]
         [width 1024]
         [height 768])

    (send frame show #t)
    (sleep/yield 1)
    
    (let ([t (new turtle% [in-pen (new pen% [color "black"] [width 2])] 
                  [in-dc dc] [in-x 320] [in-y 240])])
      (to-thing2 t))

    (let ([t (new turtle% [in-pen (new pen% [color "black"] [width 2])] 
                  [in-dc dc] [in-x 800] [in-y 300])])
      (to-thing3 t))

    frame))

(run)
