#lang racket
;Diana Barrios
;A00819792

(define (quickSort a)
  (if (empty? a)
    a
    (let ([pivot (car a)])
      (let ([tail (cdr a)])
        (let ([left (filter (lambda (x) (< x pivot)) tail)])
          (let ([right (filter (lambda (x) (>= x pivot)) tail)])
            (append (quickSort left) (list pivot) (quickSort right))
          )
        )
      )
    )
  )
)

;(define (matrixMultiplication matrixA matrixB))

(define (getAvg gender table)
  (let ([x (filter (lambda (l) (equal? (car l) gender)) table)])
    (/ (apply + (map cadr x)) 
       (exact->inexact (length x))
    )
  )
 )

(define (tableSummarization table)
  (if (empty? table)
   '()
    (list (list "Male" (getAvg "Male" table)) (list "Female" (getAvg "Female" table)))
   )
)



(define (insert element tree)
  (cond
    ((null? tree) (list element '() '()))
    ((< element (car tree)) (list
                             (car tree)
                             (insert element (cadr tree))
                             (caddr tree)
                             )
                            )
    (else
     (list
      (car tree)
      (cadr tree)
     (insert element (caddr tree))
          ))
   )
)

