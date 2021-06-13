### Rubiks cube in elisp

The code simulates a rubiks cube using elisp on emacs

### Setup

1. Open the file `rubiks.el` in emacs
2. In the buffer do

`ALT-x eval-buffer`

### Running Tests

1. Open the `*scratch*` buffer
2. type the command

`(rot-test)`

3. evaluate the line by issuing the command

`ctrl-x ctrl-e`

OR

`ALT-x eval-last-sexp`

*NOTE*: Your cursor should be just after the closing braces of the `(rot-test)` command

You should see "SUCCESS" printed at the end of some output. In case of failure you will see "FAIL: <some message>"

OR

From command-line

`make test`

### Using the code

1. `defun new-cube ()`

    returns a new cube with each square having a colour `'a 'b 'c 'd 'e 'f`

2. `defun rotate-side-clockwise (cube side)`

    performs rotation on `cube` for `side=['front 'right 'left 'back 'top 'bottom 'vertical 'horizontal]`
    
    returns a new cube.

    The rotation is always clockwise when looking down on the side in question.

    `'vertical` implies movement on the middle column upwards leaving the sides untouched

    `'horizontal` implies movement of the middle row to the right

3. `defun print-cube (cube)`
    
    prints the cube in an origami folding pattern. Use with `insert` to print in buffer

    ```
    (insert (print-cube (new-cube)))
           (e e e)
           (e e e)
           (e e e)
    (c c c)(a a a)(b b b)(d d d)
    (c c c)(a a a)(b b b)(d d d)
    (c c c)(a a a)(b b b)(d d d)
           (f f f)
           (f f f)
           (f f f)
    ```
4. `defun generate-random-cube (number-of-moves)`

    generates a random cube by applying random moves `number-of-moves` times.

    ```
    (insert (print-cube (generate-random-cube 10)))
    
           (b b a)
           (d e c)
           (d f c)
    (d c d)(e a a)(c e e)(c f f)
    (d a a)(e b a)(c d b)(e c b)
    (e b f)(d d b)(f a b)(e f a)
           (c f a)
           (a f e)
           (b c d)
    ```
5. `defun apply-sequence (cube steps)`

   applies a sequence of commands `steps` to cube
   ```
   (insert (print-cube (apply-sequence (new-cube) (list 'left 'left 'left 'front 'front 'front 'right 'right 'right))))
           (a e d)
           (a e d)
           (b b d)
    (c c e)(a a e)(b b b)(f d e)
    (c c e)(a a e)(b b b)(f d e)
    (c c a)(f f b)(f f d)(c d e)
           (c c a)
           (d f a)
           (d f f)
       
   ```
### Running the Recursive solution

The recursive solutions is in `recursive_solution.el`. To run it on terminal just do

`make recursive`

### Running the iterative solution

The iterative solution is in `iterative_solution.el`. It doesn't run in the terminal because it needs a library `iter2` So just do `eval-buffer` in emacs.

### Distributed solution

`make distributed`

Then in separate terminals run

`make worker1`

`make worker2`

`make worker3`

`make worker4`

### Next Steps

I want to write lisp code to solve a rubiks cube from first principles

