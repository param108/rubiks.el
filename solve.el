
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
(defun iterate(cube)
  (let (it (count 0)(solution '()))
    (setq it (make-move-iterator-list 10))
    (dotimes (itr 10000000)
      (setq new-moves (move-iterator-value it))
      (if (eq 99999 (% itr 100000)) (garbage-collect) nil)
      (if (and (eq 10 (move-length new-moves)) (eq nil (have-4-sequences new-moves)))
          (let ((solved nil))
            (setq count (1+ count))
            (if (eq 10 count) (throw 'fail) nil)
            (setq solved (catch 'rubiks-solution-found
                           (insert (format "\n;; %s %s %s\n"
                                           (score-cube
                                            (apply-sequence cube new-moves)) new-moves itr))))
            (if (not (eq nil solved))
                (let ()
                  (push (car (cdr solved)) solution)
                  (return))
              nil)) nil)
      (setq incr-it (next-move it))
      (setq it (car incr-it)))
    solution))

;; test solution exception
;; (insert (format "\n;; %s\n" (car (iterate (apply-sequence (new-cube) (list 'front 'front))))))
;; (front front)

;; (front front)

;; (front front)

;; applied


;; (iterate (generate-random-cube 10) )
;; 17 (front front right front front front right front front front) 561801

;; 16 (right front right front front front right front front front) 561802

;; 15 (left front right front front front right front front front) 561803

;; 14 (back front right front front front right front front front) 561804

;; 12 (top front right front front front right front front front) 561805

;; 18 (bottom front right front front front right front front front) 561806

;; 15 (vertical front right front front front right front front front) 561807

;; 21 (horizontal front right front front front right front front front) 561808

;; 15 (front right right front front front right front front front) 561809



