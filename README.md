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

### Using the code

1. `defun new-cube ()`

    returns a new cube with each square having a colour `'a 'b 'c 'd 'e 'f`

2. `defun rotate-side-clockwise (cube side)`

    performs rotation on `cube` for `side=['front 'right 'left 'back 'top 'bottom 'vertical 'horizontal]`
    
    returns a new cube.

    The rotation is always clockwise when looking down on the side in question.

    `'vertical` implies movement on the middle column upwards leaving the sides untouched

    `'horizontal` implies movement of the middle row to the right

3. `defun print-cube (cube)` prints the cube in an origami folding pattern. Use with `insert` to print in buffer

    `(insert (print-cube (new-cube)))`

    ```
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
    
### Next Steps

I want to write lisp code to solve a rubiks cube from first principles
