# Calculator's fix

Let's move on to the next tag:
```
$ git checkout Example_3
HEAD is now at d7f58c6... Shell spec. symbols escaping and input formatting for 'expr'.
$ git diff Example_2 Example_3
...
```
As you can see, the files have changed: README and our script `calc`. Let's take a look at `calc`:
```
$ cat calc 
#!/bin/sh

FILE=/tmp/calc-$$

read EXPR
echo $EXPR | sed 's/\([^0-9]\)\([^0-9]\)/\1 \2/g; s/\([0-9]\+\)\([^0-9]\)/\1 \2/g; s/\([^0-9]\)\([0-9]\+\)/\1 \2/g; s/\([*()]\)/\\\1/g; s/^/expr /' > $FILE
sh $FILE
EXIT_STATUS=$?
rm -f $FILE
exit $EXIT_STATUS
```
It looks more complicated -- let's analyze the changes. So the main idea behind the fixes is to read the expression from stdin, not from the script parameters, and modify it to avoid the Shell matching mechanism.

OK. On the third line, we define a FILE variable with a unique name to store temporary data for evaluating `expr`. The uniqueness is guaranteed by a special double dollar environment variable that indicates the PID of the current process.

On the fifth line, we read the expression from stdin into the EXPR variable. We then edit it on the fly with the `sed` stream editor. By the `sed` command, we insert spaces between numbers and signs of arithmetic operations, we do the escaping with the slash character before the asterisk and brackets. Finally, before the expression, insert the `expr` command and redirect the output from `sed` to a temporary file defined at the beginning of the script.

We then run our temporary script with `sh`, getting the exit status from the special variable "dollar question" into "EXIT_STATUS" variable, deleting the temporary file, and exiting with the parameters stored in "EXIT_STATUS". We need such a complex construction because `rm -rf` will return a success status regardless of the result of evaluating the expression.

OK -- let's check our fixes:
```
$ ./calc      
2*2
4
```
It works! And we don't even need to insert spaces between parts of our expression. Let's check -- maybe something else was broken by our corrections?
```
$ ./calc
1+2
3
$ ./calc
5-7
-2
$ ./calc
6/3
2
$ ./calc
7/3
2
$ ./calc
7%3
1
```
Looks good. What about expected errors?
```
$ ./calc
6/0
expr: division by zero
$ echo $?
2
```
Great, we got it -- division by zero!

Of course, we can implement a simpler solution and in the sixth line just write:
```
echo $(($EXPR)) > $FILE

```
But we wrote a script that still works with older shells that may not support such constructs, and we also looked at how to use non-interactive editing in scripts.

