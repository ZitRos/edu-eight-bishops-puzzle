; check if there is any figures in x y
(defun elementIn (x y lst)
 (cond
   ((NULL lst) 0)
   ((and (eql (car (car lst)) x) (eql (car (cdr (car lst))) y)) 1)
   (1 (elementIn x y (cdr lst)))
 )
)

; check if there is any figures in x y
(defun getByCoord (x y lst)
 (cond
   ((NULL lst) nil)
   ((and (eql (car (car lst)) x) (eql (car (cdr (car lst))) y)) (car lst))
   (1 (getByCoord x y (cdr lst)))
 )
)

; check if position is under attack
(defun elementAttack (x y lst)
 (cond
   ((NULL lst) 0)
   ; ((or (eql (car (car lst)) x) (eql y (car (cdr (car lst))))) 1) ; UNCOMMENT THIS LINE TO GET "EIGHT QUEENS PUZZLE" solution
   ((eql (- (abs (- (car (car lst)) x) ) (abs (- y (car (cdr (car lst)))))) 0) 1)
   (1 (elementAttack x y (cdr lst)))
 )
)

(defun printField (figures sizet)
  (setq counter1 0)
  (defun priprint (xxx yyy)
    (cond
      ((eql (elementIn xxx yyy figures) 1) (setq counter1 (+ counter1 1)) (elt (getByCoord xxx yyy figures) 2))
      (T '_)
    ))
  (setq nnx 1)
  (setq nny sizet)
  (loop
    (setq mylist '())
    (setq nnx (+ nnx 1))
    (loop 
      (setq nny (- nny 1))
      (push (priprint (+ nny 1) (- nnx 1)) mylist)
      (cond ((< nny 1) (setq nny sizet) (return nil))))
    (print mylist)
    (cond ((> nnx sizet) (return nil))))
  (print "-------")
  1
)

(defun setval(db index value) (
  cond ((< index 1) (cons value (cdr db)))
       (T (cons (car db) (setval (cdr db) (- index 1) value)))
))

(defun listWithout (x y lst)
  (cond ((NULL lst) nil)
        ((and (eql (elt (car lst) 0) x) (eql (elt (car lst) 1) y)) (listWithout x y (cdr lst)))
        (T (cons (car lst) (listWithout x y (cdr lst)))))
)

(defun listExclude (pos lst)
  (listWithout (elt pos 0) (elt pos 1) lst)
)

(defun genFigure (boardSize index) (list (+ (random boardSize) 1) (+ (random boardSize) 1) index))

(defun lenB (pos1 pos2)
  (+ (abs (- (elt pos1 0) (elt pos2 0)))
     (abs (- (elt pos1 1) (elt pos2 1))))
)

;          4    (..) 0      0  0  (..) 0      (..)
(defun fp (size figs figInd nx ny vars length stck)
  (cond ((eql figInd 0) (setq MINLEN (* size size size)) (setq STACK '())))
  (setq nx 0) (setq ny 0) (setq vars '())
  (setq tempFigs (listExclude (elt figs figInd) figs))
  ;(print tempFigs)
  (loop
    (setq nx (+ nx 1))
    (loop
      (setq ny (+ ny 1))
      (cond ((eql (elementAttack nx ny tempFigs) 0)
               (push (list nx ny (elt (elt figs figInd) 2)) vars)))
      (cond ((>= ny size) (setq ny 0) (return nil))))
    (cond ((>= nx size) (return nil))))
  (setq nx -1)
  (cond ((>= figInd (- size 1))
           (loop
             (setq nx (+ nx 1))
               (setq tempLen (+ (lenb (elt vars nx) (elt figs figInd)) length))
               (cond ((<= tempLen MINLEN)
                      (setq MINLEN tempLen)
                      (setq stck (setval stck (length stck) figs))
                      (setq STACK (setval stck (length stck) (setval figs figInd (elt vars nx))))
                      ; uncomment to get detailed log
                      ;(print tempLen)
                      ;(printField (setval figs figInd (elt vars nx)) size)
               ))
             (cond ((>= nx (- (length vars) 1)) (return nil)))))
        (T (loop ; dive
             (setq nx (+ nx 1))
             (fp
                 size
                 (setval figs figInd (elt vars nx))
                 (+ figInd 1)
                 0
                 0
                 '()
                 (+ (lenB (elt vars nx) (elt figs figInd)) length)
                 (setval stck (length stck) figs))
             (cond ((>= nx (- (length vars) 1)) (return nil))))))
  
  
  (cond ((eql figInd 0)
    (format t "~%~%ONE OF BEST VARIANT BY STEPS (~D SWAPS):" MINLEN)
    (setq nx -1)
    (loop
      (setq nx (+ nx 1))
      (format t "~%~%STEP ~D:" nx)
      (printField (elt STACK nx) size)
      (cond ((>= nx (- (length STACK) 1)) (return nil))))))
  MINLEN
)

(defun solve (boardSize)
(setq figures '())
; test cases
;(setq figures '((1 1 1) (2 2 2) (3 3 3) (4 4 4)))
;(setq figures '((4 1 1) (3 2 2) (2 3 3) (1 4 4)))
;(setq figures '((2 2 1) (2 3 2) (3 1 3) (1 2 4)))
;(setq figures '((1 1 1) (2 3 2) (3 3 3) (4 3 4)))
;(setq figures '((2 1 1) (3 2 2) (1 2 3) (2 3 4)))
(setq indx 1)
(cond ((< (length figures) boardSize) (loop ; random
  (setq temp (genFigure boardSize indx))
  ; (print figures (elementIn (elt temp 0) (elt temp 1) figures))
  (cond ((eql (elementIn (elt temp 0) (elt temp 1) figures) 0)
         (setq figures (setval figures (length figures) temp))
         (setq indx (+ indx 1))))
  (cond ((>= (length figures) boardSize) (return figures))))))
(printField figures boardSize)
(fp boardSize figures 0 0 0 '() 0 '())
)