(defun front (cube)
  (nth 0 cube))
(defun right (cube)
  (nth 1 cube))
(defun left (cube)
  (nth 2 cube ))
(defun back (cube)
  (nth 3 cube))
(defun top (cube)
  (nth 4 cube))
(defun bottom (cube)
  (nth 5 cube))

(defun new-cube ()
  (list  (list  (list  'a 'a 'a ) (list  'a 'a 'a ) (list  'a 'a 'a ) ) ;;front
         (list  (list  'b 'b 'b ) (list  'b 'b 'b ) (list  'b 'b 'b ) )     ;;right
         (list  (list  'c 'c 'c ) (list  'c 'c 'c ) (list  'c 'c 'c ) )     ;;left
         (list  (list  'd 'd 'd ) (list  'd 'd 'd ) (list  'd 'd 'd ) )     ;;back
         (list  (list  'e 'e 'e ) (list  'e 'e 'e ) (list  'e 'e 'e ) )     ;;top
         (list  (list  'f 'f 'f ) (list  'f 'f 'f ) (list  'f 'f 'f ) ) ))  ;;bottom


(defun print-cube (cube)
  (concat (format "\n       %s\n       %s\n       %s\n"
                  (nth 0 (top cube))
                  (nth 1 (top cube))
                  (nth 2 (top cube))
                  )
          (format "%s%s%s%s\n"
                  (nth 0 (left cube))
                  (nth 0 (front cube))
                  (nth 0 (right cube))
                  (nth 0 (back cube))
                  )
          (format "%s%s%s%s\n"
                  (nth 1 (left cube))
                  (nth 1 (front cube))
                  (nth 1 (right cube))
                  (nth 1 (back cube))
                  )
          (format "%s%s%s%s\n"
                  (nth 2 (left cube))
                  (nth 2 (front cube))
                  (nth 2 (right cube))
                  (nth 2 (back cube))
                  )
          (format "       %s\n       %s\n       %s\n"
                  (nth 0 (bottom cube))
                  (nth 1 (bottom cube))
                  (nth 2 (bottom cube))
                  )
          )
  )


(defun dim2 (side x y)
  (nth x (nth y side )))

(defun rotate-clockwise (side)
  (list (list (dim2 side 0 2) (dim2 side 0 1) (dim2 side 0 0) )
        (list (dim2 side 1 2) (dim2 side 1 1) (dim2 side 1 0) )
        (list (dim2 side 2 2) (dim2 side 2 1) (dim2 side 2 0) ) ))

(defun rotate-clockwise-front (cube)
  (list  (rotate-clockwise (front cube))                                             ;;front
         (list  (list (dim2 (top cube) 0 2) (dim2 (right cube) 1 0) (dim2 (right cube) 2 0))
                (list (dim2 (top cube) 1 2) (dim2 (right cube) 1 1) (dim2 (right cube) 2 1))
                (list (dim2 (top cube) 2 2) (dim2 (right cube) 1 2) (dim2 (right cube) 2 2)) ) ;;right
         (list  (list (dim2 (left cube) 0 0) (dim2 (left cube) 1 0) (dim2 (bottom cube) 0 0))
                (list (dim2 (left cube) 0 1) (dim2 (left cube) 1 1) (dim2 (bottom cube) 1 0))
                (list (dim2 (left cube) 0 2) (dim2 (left cube) 1 2) (dim2 (bottom cube) 2 0)) ) ;;left
         (back cube)                                                                 ;;back
         (list  (list (dim2 (top cube) 0 0) (dim2 (top cube) 1 0) (dim2 (top cube) 2 0))
                (list (dim2 (top cube) 0 1) (dim2 (top cube) 1 1) (dim2 (top cube) 2 1))
                (list (dim2 (left cube) 2 2) (dim2 (left cube) 2 1) (dim2 (left cube) 2 0)) ) ;;top
         (list  (list (dim2 (right cube) 0 2) (dim2 (right cube) 0 1) (dim2 (right cube) 0 0))
                (list (dim2 (bottom cube) 0 1) (dim2 (bottom cube) 1 1) (dim2 (bottom cube) 2 1))
                (list (dim2 (bottom cube) 0 2) (dim2 (bottom cube) 1 2) (dim2 (bottom cube) 2 2)) ) ;;bottom
         ))

(defun rotate-clockwise-back (cube)
  (list  (front cube)                                             ;;front
         (list  (list (dim2 (right cube) 0 0) (dim2 (right cube) 1 0) (dim2 (bottom cube) 2 2))
                (list (dim2 (right cube) 0 1) (dim2 (right cube) 1 1) (dim2 (bottom cube) 1 2))
                (list (dim2 (right cube) 0 2) (dim2 (right cube) 1 2) (dim2 (bottom cube) 0 2)) ) ;;right
         (list  (list (dim2 (top cube) 2 0) (dim2 (left cube) 1 0) (dim2 (left cube) 2 0))
                (list (dim2 (top cube) 1 0) (dim2 (left cube) 1 1) (dim2 (left cube) 2 1))
                (list (dim2 (top cube) 0 0) (dim2 (left cube) 1 2) (dim2 (left cube) 2 2)) ) ;;left
         (rotate-clockwise (back cube))                                                                 ;;back
         (list  (list (dim2 (right cube) 2 0) (dim2 (right cube) 2 1) (dim2 (right cube) 2 2))
                (list (dim2 (top cube) 0 1) (dim2 (top cube) 1 1) (dim2 (top cube) 2 1))
                (list (dim2 (top cube) 0 2) (dim2 (top cube) 1 2) (dim2 (top cube) 2 2)) ) ;;top
         (list  (list (dim2 (bottom cube) 0 0) (dim2 (bottom cube) 1 0) (dim2 (bottom cube) 2 0))
                (list (dim2 (bottom cube) 0 1) (dim2 (bottom cube) 1 1) (dim2 (bottom cube) 2 1))
                (list (dim2 (left cube) 0 0) (dim2 (left cube) 0 1) (dim2 (left cube) 0 2)) ) ;;bottom
         ))

(defun rotate-clockwise-top   (cube)
  (list  (list  (list (dim2 (right cube) 0 0) (dim2 (right cube) 1 0) (dim2 (right cube) 2 0))
                (list (dim2 (front cube) 0 1) (dim2 (front cube) 1 1) (dim2 (front cube) 2 1))
                (list (dim2 (front cube) 0 2) (dim2 (front cube) 1 2) (dim2 (front cube) 2 2)) ) ;;front
         (list  (list (dim2 (back cube) 0 0) (dim2 (back cube) 1 0) (dim2 (back cube) 2 0))
                (list (dim2 (right cube) 0 1) (dim2 (right cube) 1 1) (dim2 (right cube) 2 1))
                (list (dim2 (right cube) 0 2) (dim2 (right cube) 1 2) (dim2 (right cube) 2 2)) ) ;;right
         (list  (list (dim2 (front cube) 0 0) (dim2 (front cube) 1 0) (dim2 (front cube) 2 0))
                (list (dim2 (left cube) 0 1) (dim2 (left cube) 1 1) (dim2 (left cube) 2 1))
                (list (dim2 (left cube) 0 2) (dim2 (left cube) 1 2) (dim2 (left cube) 2 2)) ) ;;left
         (list  (list (dim2 (left cube) 0 0) (dim2 (left cube) 1 0) (dim2 (left cube) 2 0))
                (list (dim2 (back cube) 0 1) (dim2 (back cube) 1 1) (dim2 (back cube) 2 1))
                (list (dim2 (back cube) 0 2) (dim2 (back cube) 1 2) (dim2 (back cube) 2 2)) ) ;;back
         (rotate-clockwise (top cube)) ;;top
         (bottom cube) ;;bottom
         ))


(defun rotate-clockwise-bottom (cube)
  (list  (list  (list (dim2 (front cube) 0 0) (dim2 (front cube) 1 0) (dim2 (front cube) 2 0))
                (list (dim2 (front cube) 0 1) (dim2 (front cube) 1 1) (dim2 (front cube) 2 1))
                (list (dim2 (left cube) 0 2) (dim2 (left cube) 1 2) (dim2 (left cube) 2 2)) ) ;;front
         (list  (list (dim2 (right cube) 0 0) (dim2 (right cube) 1 0) (dim2 (right cube) 2 0))
                (list (dim2 (right cube) 0 1) (dim2 (right cube) 1 1) (dim2 (right cube) 2 1))
                (list (dim2 (front cube) 0 2) (dim2 (front cube) 1 2) (dim2 (front cube) 2 2)) ) ;;right
         (list  (list (dim2 (left cube) 0 0) (dim2 (left cube) 1 0) (dim2 (left cube) 2 0))
                (list (dim2 (left cube) 0 1) (dim2 (left cube) 1 1) (dim2 (left cube) 2 1))
                (list (dim2 (back cube) 0 2) (dim2 (back cube) 1 2) (dim2 (back cube) 2 2)) ) ;;left
         (list  (list (dim2 (back cube) 0 0) (dim2 (back cube) 1 0) (dim2 (back cube) 2 0))
                (list (dim2 (back cube) 0 1) (dim2 (back cube) 1 1) (dim2 (back cube) 2 1))
                (list (dim2 (right cube) 0 2) (dim2 (right cube) 1 2) (dim2 (right cube) 2 2)) ) ;;back
         (top cube) ;;top
         (rotate-clockwise (bottom cube)) ;; bottom
         ))



(defun rotate-clockwise-right (cube)
  (list  (list  (list (dim2 (front cube) 0 0) (dim2 (front cube) 1 0) (dim2 (bottom cube) 2 0))
                (list (dim2 (front cube) 0 1) (dim2 (front cube) 1 1) (dim2 (bottom cube) 2 1))
                (list (dim2 (front cube) 0 2) (dim2 (front cube) 1 2) (dim2 (bottom cube) 2 2)) ) ;;front
         (rotate-clockwise (right cube)) ;;right
         (left cube) ;;left
         (list  (list (dim2 (top cube) 2 2) (dim2 (back cube) 1 0) (dim2 (back cube) 2 0))
                (list (dim2 (top cube) 2 1) (dim2 (back cube) 1 1) (dim2 (back cube) 2 1))
                (list (dim2 (top cube) 2 0) (dim2 (back cube) 1 2) (dim2 (back cube) 2 2)) ) ;;back
         (list  (list (dim2 (top cube) 0 0) (dim2 (top cube) 1 0) (dim2 (front cube) 2 0))
                (list (dim2 (top cube) 0 1) (dim2 (top cube) 1 1) (dim2 (front cube) 2 1))
                (list (dim2 (top cube) 0 2) (dim2 (top cube) 1 2) (dim2 (front cube) 2 2)) ) ;;top
         (list  (list (dim2 (bottom cube) 0 0) (dim2 (bottom cube) 1 0) (dim2 (back cube) 0 2))
                (list (dim2 (bottom cube) 0 1) (dim2 (bottom cube) 1 1) (dim2 (back cube) 0 1))
                (list (dim2 (bottom cube) 0 2) (dim2 (bottom cube) 1 2) (dim2 (back cube) 0 0)) ) ;;bottom
         ))

(defun rotate-clockwise-left (cube)
  (list  (list  (list (dim2 (top cube) 0 0) (dim2 (front cube) 1 0) (dim2 (front cube) 2 0))
                (list (dim2 (top cube) 0 1) (dim2 (front cube) 1 1) (dim2 (front cube) 2 1))
                (list (dim2 (top cube) 0 2) (dim2 (front cube) 1 2) (dim2 (front cube) 2 2)) ) ;;front
         (right cube) ;;right
         (rotate-clockwise (left cube)) ;;left
         (list  (list (dim2 (back cube) 0 0) (dim2 (back cube) 1 0) (dim2 (bottom cube) 0 2))
                (list (dim2 (back cube) 0 1) (dim2 (back cube) 1 1) (dim2 (bottom cube) 0 1))
                (list (dim2 (back cube) 0 2) (dim2 (back cube) 1 2) (dim2 (bottom cube) 0 0)) ) ;;back
         (list  (list (dim2 (back cube) 2 2) (dim2 (top cube) 1 0) (dim2 (top cube) 2 0))
                (list (dim2 (back cube) 2 1) (dim2 (top cube) 1 1) (dim2 (top cube) 2 1))
                (list (dim2 (back cube) 2 0) (dim2 (top cube) 1 2) (dim2 (top cube) 2 2)) ) ;;top
         (list  (list (dim2 (front cube) 0 0) (dim2 (bottom cube) 1 0) (dim2 (bottom cube) 2 0))
                (list (dim2 (front cube) 0 1) (dim2 (bottom cube) 1 1) (dim2 (bottom cube) 2 1))
                (list (dim2 (front cube) 0 2) (dim2 (bottom cube) 1 2) (dim2 (bottom cube) 2 2)) ) ;;bottom
         ))


(defun rotate-up-center-vertical (cube)
  (list     (list  (list (dim2 (front cube) 0 0) (dim2 (bottom cube) 1 0) (dim2 (front cube) 2 0))
                   (list (dim2 (front cube) 0 1) (dim2 (bottom cube) 1 1) (dim2 (front cube) 2 1))
                   (list (dim2 (front cube) 0 2) (dim2 (bottom cube) 1 2) (dim2 (front cube) 2 2)) ) ;;front
            (right cube) ;;right
            (left cube) ;;left
            (list  (list (dim2 (back cube) 0 0) (dim2 (top cube) 1 2) (dim2 (back cube) 2 0))
                   (list (dim2 (back cube) 0 1) (dim2 (top cube) 1 1) (dim2 (back cube) 2 1))
                   (list (dim2 (back cube) 0 2) (dim2 (top cube) 1 0) (dim2 (back cube) 2 2)) ) ;;back
            (list  (list (dim2 (top cube) 0 0) (dim2 (front cube) 1 0) (dim2 (top cube) 2 0))
                   (list (dim2 (top cube) 0 1) (dim2 (front cube) 1 1) (dim2 (top cube) 2 1))
                   (list (dim2 (top cube) 0 2) (dim2 (front cube) 1 2) (dim2 (top cube) 2 2)) ) ;;top
            (list  (list (dim2 (bottom cube) 0 0) (dim2 (back cube) 1 2) (dim2 (bottom cube) 2 0))
                   (list (dim2 (bottom cube) 0 1) (dim2 (back cube) 1 1) (dim2 (bottom cube) 2 1))
                   (list (dim2 (bottom cube) 0 2) (dim2 (back cube) 1 0) (dim2 (bottom cube) 2 2)) ) ;;bottom
            ))

(defun rotate-right-center-horizontal (cube)
  (list      (list  (list (dim2 (front cube) 0 0) (dim2 (front cube) 1 0) (dim2 (front cube) 2 0))
                    (list (dim2 (left cube) 0 1) (dim2 (left cube) 1 1) (dim2 (left cube) 2 1))
                    (list (dim2 (front cube) 0 2) (dim2 (front cube) 1 2) (dim2 (front cube) 2 2)) ) ;;front
             (list  (list (dim2 (right cube) 0 0) (dim2 (right cube) 1 0) (dim2 (right cube) 2 0))
                    (list (dim2 (front cube) 0 1) (dim2 (front cube) 1 1) (dim2 (front cube) 2 1))
                    (list (dim2 (right cube) 0 2) (dim2 (right cube) 1 2) (dim2 (right cube) 2 2)) ) ;;right
             (list  (list (dim2 (left cube) 0 0) (dim2 (left cube) 1 0) (dim2 (left cube) 0 0))
                    (list (dim2 (back cube) 0 1) (dim2 (back cube) 1 1) (dim2 (back cube) 1 0))
                    (list (dim2 (left cube) 0 2) (dim2 (left cube) 1 2) (dim2 (left cube) 2 0)) ) ;;left
             (list  (list (dim2 (back cube) 0 0) (dim2 (back cube) 1 0) (dim2 (back cube) 2 0))
                    (list (dim2 (right cube) 0 1) (dim2 (right cube) 1 1) (dim2 (right cube) 2 1))
                    (list (dim2 (back cube) 0 2) (dim2 (back cube) 1 2) (dim2 (back cube) 2 2)) ) ;;back
             (top cube) ;;top
             (bottom cube) ;;bottom
             ))


(defun rotate-side-clockwise (cube side)
  (cond ((eq side 'front) (rotate-clockwise-front cube))
        ((eq side 'right) (rotate-clockwise-right cube))
        ((eq side 'left) (rotate-clockwise-left cube))
        ((eq side 'back) (rotate-clockwise-back cube))
        ((eq side 'top) (rotate-clockwise-top cube))
        ((eq side 'bottom) (rotate-clockwise-bottom cube))
        ((eq side 'vertical) (rotate-up-center-vertical cube))
        ((eq side 'horizontal) (rotate-right-center-horizontal cube))
        (t cube)
        ))

;; TEST CODE BEGINS HERE

(defun test-cube ()
  (list  (list  (list  'a1 'a2 'a3 ) (list  'a4 'a5 'a6 ) (list  'a7 'a8 'a9 ) ) ;;front
         (list  (list  'b1 'b2 'b3 ) (list  'b4 'b5 'b6 ) (list  'b7 'b8 'b9 ) )     ;;right
         (list  (list  'c1 'c2 'c3 ) (list  'c4 'c5 'c6 ) (list  'c7 'c8 'c9 ) )     ;;left
         (list  (list  'd1 'd2 'd3 ) (list  'd4 'd5 'd6 ) (list  'd7 'd8 'd9 ) )     ;;back
         (list  (list  'e1 'e2 'e3 ) (list  'e4 'e5 'e6 ) (list  'e7 'e8 'e9 ) )     ;;top
         (list  (list  'f1 'f2 'f3 ) (list  'f4 'f5 'f6 ) (list  'f7 'f8 'f9 ) ) ))  ;;bottom

(defun test-result (side)
  (cond ((eq side 'front) (front-test-result))
        ((eq side 'right) (right-test-result))
        ((eq side 'left) (left-test-result))
        ((eq side 'back) (back-test-result))
        ((eq side 'top) (top-test-result))
        ((eq side 'bottom) (bottom-test-result))
        ((eq side 'vertical) (vertical-test-result))
        ((eq side 'horizontal) (horizontal-test-result))
        (t cube)
        ))

(defun front-test-result ()
  (list (list (list 'a7 'a4 'a1) (list 'a8 'a5 'a2) (list 'a9 'a6 'a3)) (list (list 'e7 'b2 'b3) (list 'e8 'b5 'b6) (list 'e9 'b8 'b9)) (list (list 'c1 'c2 'f1) (list 'c4 'c5 'f2) (list 'c7 'c8 'f3)) (list (list 'd1 'd2 'd3) (list 'd4 'd5 'd6) (list 'd7 'd8 'd9)) (list (list 'e1 'e2 'e3) (list 'e4 'e5 'e6) (list 'c9 'c6 'c3)) (list (list 'b7 'b4 'b1) (list 'f4 'f5 'f6) (list 'f7 'f8 'f9))))

(defun back-test-result ()
  (list (list (list 'a1 'a2 'a3) (list 'a4 'a5 'a6) (list 'a7 'a8 'a9)) (list (list 'b1 'b2 'f9) (list 'b4 'b5 'f8) (list 'b7 'b8 'f7)) (list (list 'e3 'c2 'c3) (list 'e2 'c5 'c6) (list 'e1 'c8 'c9)) (list (list 'd7 'd4 'd1) (list 'd8 'd5 'd2) (list 'd9 'd6 'd3)) (list (list 'b3 'b6 'b9) (list 'e4 'e5 'e6) (list 'e7 'e8 'e9)) (list (list 'f1 'f2 'f3) (list 'f4 'f5 'f6) (list 'c1 'c4 'c7))))

(defun left-test-result ()
  (list (list (list 'e1 'a2 'a3) (list 'e4 'a5 'a6) (list 'e7 'a8 'a9)) (list (list 'b1 'b2 'b3) (list 'b4 'b5 'b6) (list 'b7 'b8 'b9)) (list (list 'c7 'c4 'c1) (list 'c8 'c5 'c2) (list 'c9 'c6 'c3)) (list (list 'd1 'd2 'f7) (list 'd4 'd5 'f4) (list 'd7 'd8 'f1)) (list (list 'd9 'e2 'e3) (list 'd6 'e5 'e6) (list 'd3 'e8 'e9)) (list (list 'a1 'f2 'f3) (list 'a4 'f5 'f6) (list 'a7 'f8 'f9))))

(defun right-test-result ()
  (list (list (list 'a1 'a2 'f3) (list 'a4 'a5 'f6) (list 'a7 'a8 'f9)) (list (list 'b7 'b4 'b1) (list 'b8 'b5 'b2) (list 'b9 'b6 'b3)) (list (list 'c1 'c2 'c3) (list 'c4 'c5 'c6) (list 'c7 'c8 'c9)) (list (list 'e9 'd2 'd3) (list 'e6 'd5 'd6) (list 'e3 'd8 'd9)) (list (list 'e1 'e2 'a3) (list 'e4 'e5 'a6) (list 'e7 'e8 'a9)) (list (list 'f1 'f2 'd7) (list 'f4 'f5 'd4) (list 'f7 'f8 'd1))))

(defun top-test-result ()
  (list (list (list 'b1 'b2 'b3) (list 'a4 'a5 'a6) (list 'a7 'a8 'a9)) (list (list 'd1 'd2 'd3) (list 'b4 'b5 'b6) (list 'b7 'b8 'b9)) (list (list 'a1 'a2 'a3) (list 'c4 'c5 'c6) (list 'c7 'c8 'c9)) (list (list 'c1 'c2 'c3) (list 'd4 'd5 'd6) (list 'd7 'd8 'd9)) (list (list 'e7 'e4 'e1) (list 'e8 'e5 'e2) (list 'e9 'e6 'e3)) (list (list 'f1 'f2 'f3) (list 'f4 'f5 'f6) (list 'f7 'f8 'f9))))

(defun bottom-test-result ()
  (list (list (list 'a1 'a2 'a3) (list 'a4 'a5 'a6) (list 'c7 'c8 'c9)) (list (list 'b1 'b2 'b3) (list 'b4 'b5 'b6) (list 'a7 'a8 'a9)) (list (list 'c1 'c2 'c3) (list 'c4 'c5 'c6) (list 'd7 'd8 'd9)) (list (list 'd1 'd2 'd3) (list 'd4 'd5 'd6) (list 'b7 'b8 'b9)) (list (list 'e1 'e2 'e3) (list 'e4 'e5 'e6) (list 'e7 'e8 'e9)) (list (list 'f7 'f4 'f1) (list 'f8 'f5 'f2) (list 'f9 'f6 'f3))))

(defun vertical-test-result ()
  (list (list (list 'a1 'f2 'a3) (list 'a4 'f5 'a6) (list 'a7 'f8 'a9)) (list (list 'b1 'b2 'b3) (list 'b4 'b5 'b6) (list 'b7 'b8 'b9)) (list (list 'c1 'c2 'c3) (list 'c4 'c5 'c6) (list 'c7 'c8 'c9)) (list (list 'd1 'e8 'd3) (list 'd4 'e5 'd6) (list 'd7 'e2 'd9)) (list (list 'e1 'a2 'e3) (list 'e4 'a5 'e6) (list 'e7 'a8 'e9)) (list (list 'f1 'd8 'f3) (list 'f4 'd5 'f6) (list 'f7 'd2 'f9))))

(defun horizontal-test-result ()
  (list (list (list 'a1 'a2 'a3) (list 'c4 'c5 'c6) (list 'a7 'a8 'a9)) (list (list 'b1 'b2 'b3) (list 'a4 'a5 'a6) (list 'b7 'b8 'b9)) (list (list 'c1 'c2 'c1) (list 'd4 'd5 'd2) (list 'c7 'c8 'c3)) (list (list 'd1 'd2 'd3) (list 'b4 'b5 'b6) (list 'd7 'd8 'd9)) (list (list 'e1 'e2 'e3) (list 'e4 'e5 'e6) (list 'e7 'e8 'e9)) (list (list 'f1 'f2 'f3) (list 'f4 'f5 'f6) (list 'f7 'f8 'f9))))

(defun test (msg expected actual)
  (if (equal expected actual)
      "\nSUCCESS\n"
    (throw 'rot-test (format "\nFAIL: %s\n" msg))))

(defun rot-test ()
  (insert (catch 'rot-test
            ( let (value)
              (dolist ( elt (list 'front 'back 'left 'right 'top 'bottom 'vertical 'horizontal) value)
                (let ((cube (test-cube)))
                  (insert (format "\n%s\n" elt))
                  (insert (print-cube (rotate-side-clockwise cube elt)))
                  (setq value (test (format "%s" elt) (test-result elt)(rotate-side-clockwise cube elt) )
                        )))))))
