#lang racket
(require racket/gui)  
(require racket/draw)

(require "turtle.rkt")

(define (gosper-a t side angle depth)
  (with-turtle t
               (if (eq? depth 0)
                   (forward side)
                   (begin
                     (gosper-a t side angle (sub1 depth))
                     (right angle)
                     (gosper-b t side angle (sub1 depth))
                     (right angle)
                     (right angle)
                     (gosper-b t side angle (sub1 depth))
                     (left angle)
                     (gosper-a t side angle (sub1 depth))
                     (left angle)
                     (left angle)
                     (gosper-a t side angle (sub1 depth))
                     (gosper-a t side angle (sub1 depth))
                     (left angle)
                     (gosper-b t side angle (sub1 depth))
                     (right angle)))))

(define (gosper-b t side angle depth)
  (with-turtle t
               (if (eq? depth 0)
                   (forward side)
                   (begin
                     (left angle)
                     (gosper-a t side angle (sub1 depth))
                     (right angle)
                     (gosper-b t side angle (sub1 depth))
                     (gosper-b t side angle (sub1 depth))
                     (right angle)
                     (right angle)
                     (gosper-b t side angle (sub1 depth))
                     (right angle)
                     (gosper-a t side angle (sub1 depth))
                     (left angle)
                     (left angle)
                     (gosper-a t side angle (sub1 depth))
                     (left angle)
                     (gosper-b t side angle (sub1 depth))))))

(define (gosper t side depth)
  (gosper-a t side 60 depth))


(define (run)
  (let* ([frame (new frame% [label "turtle"])]
         [canvas (new canvas% [parent frame])]
         [dc (send canvas get-dc)]
         [width 1024]
         [height 768])

    (send frame show #t)
    (sleep/yield 1)
    
    (let ([t (new turtle% [in-pen (new pen% [color "red"] [width 2])] 
                  [in-dc dc] [in-x 512] [in-y 384])])
      (with-turtle t
                   (pen-up)
                   (left 90)
                   (forward 300)
                   (left 90)
                   (forward 300)
                   (pen-down)
                   (right 90)
                   (gosper t 5 5)))
    frame))

(run)
