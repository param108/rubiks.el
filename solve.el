
;;
;; Code to solve a rubiks cube (hopefully)
;;



;; Does sequence order matter ?


;; (apply-sequence (new-cube) (list 'right 'front 'left))
;; (setq start-cube (apply-sequence (new-cube) (list 'right 'front 'left)))
;; (insert (print-cube start-cube))


;; (insert (print-cube (apply-sequence start-cube (list  'front 'front 'front 'right 'right 'right 'left 'left 'left))))


;; (insert (print-cube (apply-sequence start-cube (list 'left 'left 'left 'front 'front 'front 'right 'right 'right))))


;; (insert (print-cube (apply-sequence start-cube (list 'right 'right 'right 'left 'left 'left 'front 'front 'front))))

;; Yes Order matters


;;Success
;;Success
;;Success
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


(defun have-4-sequences (input)
  (let ((prev (car input)) (count 0) (found nil))
    (dolist (val input)
          (if (and (equal prev val) (not (equal val nil)))
              (let ()
                (if (eq 4 (setq count (1+ count)))
                    (setq found t) nil))
            (setq count 1))
          (setq prev val))
    found))

;;(have-4-sequences '('a 'a 'a 'a 'b))



(defun move-length (moves)
  (let ((count 0))
    (dolist (val moves)
      (if (not (eq val nil))
          (setq count (1+ count))
        count))
    count))

;;sample code for move-length
;;(move-length '('front 'front 'front 'front 'front))


;;sample code for iterator increment
;;(move-iterator-value it)

;; filter out values with 4 continuous identical commands or less than 10 moves
(defun iterate(cube)
  (let (it (count 0))
    (setq it (make-move-iterator-list 10))
    (dotimes (itr 10000000)
      (setq new-moves (move-iterator-value it))
      (if (eq 99999 (% itr 100000)) (garbage-collect) nil)
      (if (and (eq 10 (move-length new-moves)) (eq nil (have-4-sequences new-moves)))
          (let ()
            (setq count (1+ count))
            (if (eq 10 count) (throw 'fail) nil)
            (insert (format "\n;; %s %s %s\n" (score-cube (apply-sequence cube new-moves)) new-moves itr))) nil)
      (setq incr-it (next-move it))
      (setq it (car incr-it)))))

(iterate (generate-random-cube 10) )
;; 17 (front front right front front front right front front front) 561801

;; 16 (right front right front front front right front front front) 561802

;; 15 (left front right front front front right front front front) 561803

;; 14 (back front right front front front right front front front) 561804

;; 12 (top front right front front front right front front front) 561805

;; 18 (bottom front right front front front right front front front) 561806

;; 15 (vertical front right front front front right front front front) 561807

;; 21 (horizontal front right front front front right front front front) 561808

;; 15 (front right right front front front right front front front) 561809



