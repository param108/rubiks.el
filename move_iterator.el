;; -*- lexical-binding: t -*-

(require 'iter2)

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
      (push (list (car rubiks-moves-list) (read-list rubiks-moves-list)) result))
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
