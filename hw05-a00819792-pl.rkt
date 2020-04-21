#lang racket
;Diana Barrios
;A00819792

(define (myReverse lst)
  (if (null? lst)
      lst
      (append(myReverse(cdr lst))(list (car lst)))
   )
)

(define (sum lst)
  (if (null? lst)
      0
      (if (list? (car lst))
               (sum(cdr lst))
               (+ (car lst)(sum(cdr lst)))
      )
   )
)

(define (nestedSum lst)
  (if (null? lst)
      0
      (if (list? (car lst))
               (+ (nestedSum(car lst))(nestedSum(cdr lst)))
               (+ (car lst)(nestedSum(cdr lst)))
      )
   )
)

(define (removeNestedLists lst)
  (if (null? lst)
      lst
      (if (list? (car lst))
          (removeNestedLists(append (car lst)(removeNestedLists(cdr lst))))
          (cons(car lst)(removeNestedLists(cdr lst)))
       )
   )
)

(define (myMean lst)
  (if(null? lst)
     (display "Error")
     (/ (apply + lst) (length lst))
   )
)

(define (fibonacci n)
  (cond
    ((= n 0) 0)
    ((<= n 2) 1)
    (else (+ (fibonacci(- n 1)) (fibonacci(- n 2))))
  )
)
