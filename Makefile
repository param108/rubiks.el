%.elc:	%.el
	rm -f $@
	emacs --batch --eval '(byte-compile-file "$<")'

recursive: recursive_solution.elc rubiks.elc
	emacs --batch --script run.el

test: rubiks.elc
	emacs --batch --eval '(progn (load-file "./rubiks.elc") (rot-test))'

distributed: recursive_solution.elc rubiks.elc network.elc network-worker.elc network-distributor.elc
	emacs --batch --eval '(progn (load-file "./network-distributor.elc") (distributor-start 9001 (list 9002 9003 9004 9005)))'

worker1: recursive_solution.elc rubiks.elc network.elc network-worker.elc network-distributor.elc
	emacs --batch --eval '(progn (load-file "./network-worker.elc") (worker-start 9002 9001))'

worker2: recursive_solution.elc rubiks.elc network.elc network-worker.elc network-distributor.elc
	emacs --batch --eval '(progn (load-file "./network-worker.elc") (worker-start 9003 9001))'

worker3: recursive_solution.elc rubiks.elc network.elc network-worker.elc network-distributor.elc
	emacs --batch --eval '(progn (load-file "./network-worker.elc") (worker-start 9004 9001))'

worker4: recursive_solution.elc rubiks.elc network.elc network-worker.elc network-distributor.elc
	emacs --batch --eval '(progn (load-file "./network-worker.elc") (worker-start 9005 9001))'
