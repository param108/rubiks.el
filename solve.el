
;;
;; Code to solve a rubiks cube (hopefully)
;;



;; Does sequence order matter ?


(apply-sequence (new-cube) (list 'right 'front 'left))
(setq start-cube (apply-sequence (new-cube) (list 'right 'front 'left)))
(insert (print-cube start-cube))
;;       (d e a)
;;       (d e a)
;;       (d c c)
;;(c c c)(e a a)(e b b)(e d f)
;;(c c c)(e a a)(e b b)(e d f)
;;(d f f)(c f f)(a b b)(e d b)
;;       (a b b)
;;       (a f d)
;;       (f f d)


(insert (print-cube (apply-sequence start-cube (list  'front 'front 'front 'right 'right 'right 'left 'left 'left))))
;;       (a e e)
;;       (a e e)
;;       (e e e)
;;(c c d)(c a a)(b b b)(d d e)
;;(c c f)(a a a)(b b b)(d d d)
;;(c c d)(f e a)(b b a)(f d d)
;;       (b c f)
;;       (f f f)
;;       (f f c)


(insert (print-cube (apply-sequence start-cube (list 'left 'left 'left 'front 'front 'front 'right 'right 'right))))
;;       (e e e)
;;       (e e e)
;;       (e e e)
;;(c c c)(a a a)(b b b)(d d d)
;;(c c c)(a a a)(b b b)(d d d)
;;(c c c)(a a a)(b b b)(d d d)
;;       (f f f)
;;       (f f f)
;;       (f f f)


(insert (print-cube (apply-sequence start-cube (list 'right 'right 'right 'left 'left 'left 'front 'front 'front))))
;;       (e e e)
;;       (e e e)
;;       (b b e)
;;(c c e)(a a c)(a b b)(d d d)
;;(c c c)(a a f)(b b b)(d d d)
;;(c c c)(a a f)(b e a)(b d d)
;;       (f f d)
;;       (f f a)
;;       (f f f)



;; Yes Order matters

;; A simple cost function. Number of entries that are the same as the center one. Sum over sides

(defun center-of-side(side)
  (dim2 side 1 1))

(defun score-cube (cube)
  (let ((total 0))
    (dolist (side cube total)
      (dolist (row side)
      (dolist (color row)
        (if (eq color (center-of-side side))(setq total (+ total 1)))))
    total
  )))

(if (eq 54 (score-cube (new-cube))) (insert "\n;;Success") (throw 'score-cube "Score cube should be 54 for new-cube"))
;;Success



;; Brute Force
;; Do 10 steps and measure the score
;; choose only the best
;; repeat ?
(require 'iter2)
(setq lexical-binding t)

(iter2-defun read-list (l)
  (let ((left l))
    (loop
     (if (eq 0 (length left))
         (return)
       (iter-yield (car left)))
     (setq left (cdr left)))))

;;test code for read-list 
;;(setq l (read-list (list 'a 'b 'c 'd)))
;;(loop
;; (condition-case nil
;;     (insert (format "\n%s\n" (iter-next l)))
;;   (iter-end-of-sequence (return))))

;; list (current-value iterator) 
(defun make-move-iterator-list (n)
  (let ((result '()))
    (dotimes (idx n result)
      (push (list nil (read-list rubiks-moves-list)) result))
    result))

;; increment-move-iterator (iter)
;; returns t if its completed one cycle
;; returns f otherwise
;; input: (value (read-list input-list))
;; returns: ((value  (read-list input-list)) increment)
;; increment - should we increment the next iterator
(defun increment-move-iterator (move-iterator)
  (let (value iterator (increment nil))
    (condition-case nil
        (let ()
          (setq value (iter-next (car (cdr move-iterator))))
          (setq iterator (car (cdr move-iterator))))
      (iter-end-of-sequence
       (let ()
          (setq increment t)
          (setq iterator (read-list rubiks-moves-list))
          (setq value (iter-next iterator)))))
    (list (list value iterator) increment)))

(defun next-move(move-iterator-list)
  (let (result (increment t) (output-list '()))
    (dolist (iter move-iterator-list result)
      (if (eq increment t)
          (let ()
            (setq result (increment-move-iterator iter))
            (setq increment (car (cdr result)))
            (push (car result) output-list))
        (push iter output-list)))
    (list (reverse output-list) increment)))

;; returns the value of the iterator
(defun move-iterator-value (move-iterator-list)
  (let ((result '()))
    (dolist (iter move-iterator-list result)
      (push (car iter) result))
  (reverse result)))

;;sample code for iterator increment
;;(move-iterator-value it)

(let (it)
  (setq it (make-move-iterator-list 10))
  (dotimes (itr 10)
    (setq incr-it (next-move it))
    (setq it (car incr-it))
    (insert (format "\n;;%s\n"(move-iterator-value it)))))
;;(front nil nil nil nil nil nil nil nil nil)

;;(right nil nil nil nil nil nil nil nil nil)

;;(left nil nil nil nil nil nil nil nil nil)

;;(back nil nil nil nil nil nil nil nil nil)

;;(top nil nil nil nil nil nil nil nil nil)

;;(bottom nil nil nil nil nil nil nil nil nil)

;;(vertical nil nil nil nil nil nil nil nil nil)

;;(horizontal nil nil nil nil nil nil nil nil nil)

;;(front front nil nil nil nil nil nil nil nil)

;;(right front nil nil nil nil nil nil nil nil)




