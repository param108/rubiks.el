
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
         (let ()
           ;;(if (eq 10 count) (throw 'fail) nil)
           (setq result (catch 'rubiks-solution-found
                            (apply-sequence-2 cube new-moves)))
           (setq solution-found (car (cdr (cdr result))))
           (if (eq t solution-found)
               (let ()
                 (push (car (cdr result)) solution)
                 (return)))
           (if (>= (score-cube (car result)) (car (cdr max-cube)))
               (setq max-cube (list (car result) (score-cube (car result)) (car (cdr result))))))
       nil)
     (setq incr-it (next-move it))
     (setq it (car incr-it))
     (if (eq t (car (cdr incr-it)))
         (progn (setq count (1+ count))
                (if (< count max-runs)
                    (progn (push (nth 2 max-cube) solution)
                           (insert (format ";; iteration %s %s %s" count max-runs (score-cube (nth 0 max-cube))))
                           (setq cube (nth 0 max-cube))
                           (setq it (make-move-iterator-list block-length))
                           (setq max-cube (list cube (score-cube cube) '()))) ;; max-cube (cube score applied-list)
                  (progn (push (nth 2 max-cube) solution)
                         (insert (format ";; final iteration %s %s" count max-runs))
                         (return))))))
    (flatten (reverse solution))))


;; test solution exception
;;(insert (format "\n;; %s\n" (iterate-n (car (apply-sequence (new-cube) (list 'front 'front))) 5 5)));;
;; (front front)

;; (front front)
;;
;; (front front)


;;(insert (format "\n;; %s\n" (iterate-n (car (apply-sequence (new-cube) (list 'front 'right))) 3 5)));;;; iteration 1 5 42
;; (right right right front front front)
;;;; iteration 1 5 42
;; (right right right front front front)
;; iteration 1 5 42
;; (right right right front front front)
;; iteration 1 5 42
;; (right right right front front front)

;; so choose the final cube with the maximum score so far.

(defun trial()
  (setq trial-cube (generate-random-cube 10))
  (insert (print-cube trial-cube))
  (setq solved (iterate-n trial-cube 6 30))
  (insert (format "\n;; %s\n" solved))
  (insert (print-cube (car (apply-sequence trial-cube solved)))))

;;(trial)
;;       (a e e)
;;       (f e e)
;;       (f e e)
;;(c b b)(a b b)(d d d)(c c e)
;;(c c c)(a a a)(b b b)(d d f)
;;(f a f)(c d d)(c a e)(b c d)
;;       (a f f)

;;       (e f f)
;;       (b d a)
;;;; iteration 1 30 34;; iteration 2 30 39;; iteration 3 30 39;; iteration 4 30 39;; iteration 5 30 39;; iteration 6 30 39;; iteration 7 30 39;; iteration 8 30 39;; iteration 9 30 39;; iteration 10 30 39;; iteration 11 30 39;; iteration 12 30 39;; iteration 13 30 39
;;       (e c c)
;;       (a e f)
;;       (e e f)
;;(b c d)(c d b)(a a f)(a f a)
;;(c c f)(d a b)(e b d)(c d e)
;;(b b e)(a a b)(e a d)(c d f)
;;       (c e d)
;;       (f f b)
;;       (d b f)
;;;; iteration 1 30 24;; iteration 2 30 25;; iteration 3 30 25;; iteration 4 30 25;; iteration 5 30 25;; iteration 6 30 25;; iteration 7 30 25;; iteration 8 30 25;; iteration 9 30 25;; iteration 10 30 25;; iteration 11 30 25;; iteration 12 30 25;; iteration 13 30 25;; iteration 14 30 25;; iteration 15 30 25;; iteration 16 30 25;; iteration 17 30 25;; iteration 18 30 25;; iteration 19 30 25;; iteration 20 30 25;; iteration 21 30 25;; iteration 22 30 25;; iteration 23 30 25;; iteration 24 30 25;; iteration 25 30 25;; iteration 26 30 25;; iteration 27 30 25;; iteration 28 30 25;; iteration 29 30 25;; final iteration 30 30
;; (bottom front top bottom right right)

;;       (f a a)
;;       (f e e)
;;       (d f a)
;;(b d c)(e a f)(b b e)(c c d)
;;(c c f)(b a c)(d b e)(d d e)
;;(e a d)(c d b)(a f a)(f a b)
;;       (f b e)
;;       (b f c)
;;       (d e c)



;; Problems: Any sufficiently complex random cube fails to converge
;; Reasons: 10 block length takes forever to complete!!
;; Local maxima reached even with stride length of 10! We could increase stride length but that would
;; take more time.
;; Solutions:
;; 1. Make it faster (super complicated)
;; 2. Improve the heuristics to reduce number of combinations
;; 3. 


;;(make-network-process )

 
;; If we hit a solved cube we should signal
;; In case of a non-solution return the sub string with maximum score
(defun apply-sequence-2 (cube steps)
  (let ((output cube) (applied '()) (max-cube (list (score-cube cube) cube '())))
    (dolist (elt steps output)
      (setq output (rotate-side-clockwise output elt))
      (push elt applied)
      (setq score (score-cube output) )
      (if (eq 54 score)
          (throw 'rubiks-solution-found (list output (reverse applied) t))
        (if (>= score (car max-cube))
            (setq max-cube (list score output (reverse applied))))
        ))
    (list (nth 1 max-cube) (reverse (nth 2 max-cube)) nil)))


;; go back to recursive solution

(defun max-cube-score (max-cube-info)
  (nth 0 max-cube-info))

(defun max-cube-actions (max-cube-info)
  (nth 1 max-cube-info))

(defun max-cube-cube (max-cube-info)
  (nth 2 max-cube-info))

(defun new-max-cube (cube)
  (list (score-cube cube) '() cube))

(defvar iteration-count 0)

(defvar cube-cache (make-hash-table :test 'equal))

(defun cube-recurse  (cube moves depth max-depth max-cube-info)
  (if (eq 999999 (% iteration-count 1000000))
      (progn (insert (format "\n;;%s\n" (garbage-collect)))
             (setq iteration-count 0))
    (setq iteration-count (1+ iteration-count)))
  (defun solution-not-found ()
    (puthash cube t cube-cache)
    (if (> (score-cube cube) (max-cube-score max-cube-info))
        (setq max-cube-info (list (score-cube cube) moves cube)))
    (if (and (<= depth max-depth) (eq nil (have-4-sequences moves)))
        (dolist (elt rubiks-moves-list)
          (setq max-cube-info
                (cube-recurse (rotate-side-clockwise cube elt)
                              (append moves (list elt)) (1+ depth) max-depth max-cube-info))
          (if (eq 54 (max-cube-score max-cube-info))
              (return))))
    max-cube-info)
  (progn
    (setq found-in-hash (gethash cube cube-cache nil))
    (if (not (eq found-in-hash nil))
        max-cube-info
      (if (eq 54 (score-cube cube))
          (list 54 moves cube)
        (solution-not-found)))))

(defun recurse-trial ( max-depth)
  (setq trial-cube (generate-random-cube 10))
  (insert (print-cube trial-cube))
  (insert (format "\n;;initial score %s" (score-cube trial-cube)))
  (setq iteration-count 0)
  (dotimes (idx 10)
    (setq cube-cache (make-hash-table :test 'equal))
    (garbage-collect)
    (setq solved (cube-recurse trial-cube '() 0 max-depth (new-max-cube trial-cube)))
    (insert (format "\n;; %s %s %s\n" iteration-count (max-cube-score solved) (max-cube-actions solved)))
    (insert (print-cube (max-cube-cube solved)))
    (setq trial-cube (max-cube-cube solved))))

;;(recurse-trial)
;;       (a f f)
;;       (f e e)
;;       (d e e)
;;(c c e)(b a a)(b b c)(d d e)
;;(c c a)(f a a)(c b c)(d d e)
;;(d d a)(f d d)(f b f)(a a c)
;;       (c b b)
;;       (e f f)
;;       (e b b)

