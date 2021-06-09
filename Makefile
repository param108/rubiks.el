%.elc:	%.el
	rm -f $@
	emacs --batch --eval '(byte-compile-file "$<")'

recursive: recursive_solution.elc rubiks.elc
	emacs --batch --script run.el

test: rubiks.elc
	emacs --batch --eval '(progn (load-file "./rubiks.elc") (rot-test))'
