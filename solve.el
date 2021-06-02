
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
(load-file "rubiks.el")
(load-file "move_iterator.el")

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
;; version 1 iterate
;; brute force with a fixed block-length
;;
;; (defun iterate(cube block-length)
;;   (let (it (count 0)(solution '())  (itr 0))
;;     (setq it (make-move-iterator-list block-length))
;;     (loop
;;       (setq new-moves (move-iterator-value it))
;;       (if (eq 99999 (% (setq itr (1+ itr)) 100000)) (garbage-collect) nil)
;;       (if (and (eq block-length (move-length new-moves)) (eq nil (have-4-sequences new-moves)))
;;           (let ((solved nil))
;;             (setq count (1+ count))
;;             ;;(if (eq 10 count) (throw 'fail) nil)
;;             (setq solved (catch 'rubiks-solution-found
;;                            (apply-sequence cube new-moves) nil))
;;             (if (not (eq nil solved))
;;                 (let ()
;;                   (push (car (cdr solved)) solution)
;;                   (return))
;;               nil))
;;         nil)
;;       (setq incr-it (next-move it))
;;       (setq it (car incr-it))
;;       (if (eq t (car (cdr incr-it)))
;;           (return) nil))
;;     solution))


;; Choosing the right block length obviously works
;; What about the case where you don't know the block length
;; nil

;; nil

(defun flatten (list-of-lists)
  (apply #'append list-of-lists))

(defun iterate-n(cube block-length max-runs)
  (let (it (count 0)(solution '()) (max-cube) (itr 0))
    (setq it (make-move-iterator-list block-length))
    (insert (format ";;"))
    (setq max-cube (list cube (score-cube cube) '())) ;; max-cube (cube score applied-list)
    (loop
     (setq new-moves (move-iterator-value it))
     (if (eq 99999 (% (setq itr (1+ itr)) 100000)) (garbage-collect) nil)
     (if (and (eq block-length (move-length new-moves)) (eq nil (have-4-sequences new-moves)))
         (let ((solved nil))
           ;;(if (eq 10 count) (throw 'fail) nil)
           (setq result (catch 'rubiks-solution-found
                            (apply-sequence cube new-moves)))
           (setq solution-found (car (cdr (cdr result))))
           (if (eq t solution-found)
               (let ()
                 (push (car (cdr result)) solution)
                 (return))
             (let ()
               (if (>= (score-cube (car result)) (car (cdr max-cube)))
                   (setq max-cube (list (car result) (score-cube (car result)) (car (cdr result)))) nil))))
       nil)
     (setq incr-it (next-move it))
     (setq it (car incr-it))
     (if (eq t (car (cdr incr-it)))
         (progn (setq count (1+ count))
                (if (eq 0 (length (nth 2 max-cube)))
                    (return) nil)
                (if (< count max-runs)
                    (progn (push (nth 2 max-cube) solution)
                           (insert (format ";; iteration %s %s %s" count max-runs (score-cube (nth 0 max-cube))))
                           (setq cube (nth 0 max-cube))
                           (setq it (make-move-iterator-list block-length))
                           (setq max-cube (list cube (score-cube cube) '()))) ;; max-cube (cube score applied-list)
                  (progn (push (nth 2 max-cube) solution)
                         (insert (format ";; final iteration %s %s" count max-runs))
                         (return))))
       nil))
    (flatten (reverse solution))))


;; test solution exception
(insert (format "\n;; %s\n" (iterate-n (car (apply-sequence (new-cube) (list 'front 'front))) 5 5)))
;; (front front)

;; (front front)


(insert (format "\n;; %s\n" (iterate-n (car (apply-sequence (new-cube) (list 'front 'right))) 3 5)));; iteration 1 5 42
;; (right right right front front front)
;; iteration 1 5 42
;; (right right right front front front)

;; so choose the final cube with the maximum score so far.

(defun trial()
  (setq trial-cube (generate-random-cube 10))
  (insert (print-cube trial-cube))
  (setq solved (iterate-n trial-cube 10 10))
  (insert (format "\n;; %s\n" solved))
  (insert (print-cube (car (apply-sequence trial-cube solved)))))

;;(trial)






;;(make-network-process )

