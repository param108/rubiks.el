
;;
;; Code to solve a rubiks cube (hopefully)
;;



;; Does sequence order matter ?


(apply-sequence (new-cube) (list 'right 'front 'left))
(setq start-cube (apply-sequence (new-cube) (list 'right 'front 'left)))
(insert (print-cube start-cube))
       (d e a)
       (d e a)
       (d c c)
(c c c)(e a a)(e b b)(e d f)
(c c c)(e a a)(e b b)(e d f)
(d f f)(c f f)(a b b)(e d b)
       (a b b)
       (a f d)
       (f f d)

(insert (print-cube (apply-sequence start-cube (list  'front 'front 'front 'right 'right 'right 'left 'left 'left))))
       (a e e)
       (a e e)
       (e e e)
(c c d)(c a a)(b b b)(d d e)
(c c f)(a a a)(b b b)(d d d)
(c c d)(f e a)(b b a)(f d d)
       (b c f)
       (f f f)
       (f f c)

(insert (print-cube (apply-sequence start-cube (list 'left 'left 'left 'front 'front 'front 'right 'right 'right))))
       (e e e)
       (e e e)
       (e e e)
(c c c)(a a a)(b b b)(d d d)
(c c c)(a a a)(b b b)(d d d)
(c c c)(a a a)(b b b)(d d d)
       (f f f)
       (f f f)
       (f f f)

;; Yes Order matters





