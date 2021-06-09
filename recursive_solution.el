
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
(load-file "rubiks.elc")

 
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
  (if (eq depth 0)
      (print (format "\n;; Start\n %s" (print-cube cube))))
  (if (eq 999999 (% iteration-count 1000000))
      (progn (print (format "\n;;%s\n" (garbage-collect)))
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
  (print (print-cube trial-cube))
  (print (format "\n;;initial score %s" (score-cube trial-cube)))
  (setq iteration-count 0)
  (setq cube-cache (make-hash-table :test 'equal))
  (dotimes (idx 10)
    (garbage-collect)
    (setq solved (cube-recurse trial-cube '() 0 max-depth (new-max-cube trial-cube)))
    (print (format "\n;;END TIME %s\n" (current-time-string)))
    (print (format "\n;; %s %s %s\n" iteration-count (max-cube-score solved) (max-cube-actions solved)))
    (print (print-cube (max-cube-cube solved)))
    (if (eq 54 (max-cube-score solved))
        (return))
    ;;(if (eq nil (max-cube-actions solved))
    ;;    (setq max-depth (+ 1 max-depth))
    ;;    )
    (clrhash cube-cache)
    (setq trial-cube (max-cube-cube solved))))




