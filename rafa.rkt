#lang racket

;; Complete the following functions and submit your file to Canvas.

;; ========= IMPORTANT ==========
;; Change the name of the file so that it contains your student ID or name.
;; Do not change the names of the functions. The system will specifically look for the names used in this file. Changing the name of a function will automatically make you lose the points for that function.
;; Do not change the number of arguments in the functions. Changing the number of arguments of a function will automatically make you lose the points for that function.
;; Make sure that nothing additional is printed as the result of running this file. Avoid printing names, student IDs, or any other messages. If you print anything else, the system will wrongly grade your solutions.
;; If your file cannot be loaded by the Racket interpreted, your grade will be zero. Then, submit only code that works.

(define (exist? x lst)
  	(cond
          ((null? lst) #f)
          ((equal? x (car lst)) #t)
          (else (exist? x (cdr lst)))
        )
)

(define (search x pos lst)
        (cond
          ((null? lst) -1)
          ((equal? x (car lst)) pos)
          (else (search x (+ pos 1) (cdr lst)))
        )
) 

(define (index x lst)
	(search x 0 lst)
)

(define (allDifferent? lst)
	(cond
          ((<= (length lst) 1) #t)
          ((equal? (car lst) (cadr lst)) #f)
          (else (allDifferent? (cdr lst)))
        )
)

(define (set x)
	(cond
          ((null? x) '())
          ((number? (car x)) (if (exist? (car x) (cdr x))
                                 (set (cdr x))
                                 (cons (car x) (set (cdr x)))
                             )
          )
          (else (set (cdr x)))
        )
)

(define (union x y)
	(cond
          ((null? x) y)
          ((exist? (car x) y) (union (cdr x) y))
          (else (union x (cons (car x) y)))
        )
)

(define (intersect x y)
  	(cond
          ((null? x) '())
          ((exist? (car x) y) (cons (car x) (intersect (cdr x) y)))
          (else (intersect (cdr x) y))
        )
)

(define (element x y m)
        (cond
          ((and (= x 0) (= y 0)) (caar m))
          ((and (= x 0) (= y 1)) (cadar m))
          ((and (= x 0) (= y 2)) (caddar m))
          ((and (= x 1) (= y 0)) (caadr m))
          ((and (= x 1) (= y 1)) (cadadr m))
          ((and (= x 1) (= y 2)) (caddar (cdr m)))
          ((and (= x 2) (= y 0)) (caaddr m))
          ((and (= x 2) (= y 1)) (car (cdaddr m)))
          ((and (= x 2) (= y 2)) (caddr (caddr m)))
        )
)

(define (det3x3 m)
	(-
         (+
          (+ (* (* (element 2 2 m) (element 1 1 m)) (element 0 0 m))
             (* (* (element 2 0 m) (element 1 2 m)) (element 0 1 m)))
          (* (* (element 2 1 m) (element 1 0 m)) (element 0 2 m)))
         (+
          (+ (* (* (element 0 2 m) (element 1 1 m)) (element 2 0 m))
             (* (* (element 0 0 m) (element 1 2 m)) (element 2 1 m)))
          (* (* (element 0 1 m) (element 1 0 m)) (element 2 2 m)))
        )
)