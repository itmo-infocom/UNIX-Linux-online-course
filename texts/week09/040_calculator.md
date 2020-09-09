OK, let's take a step forward:
```
$ git checkout Example_2
Previous HEAD position was 8a16efc... Added simple Makefile
HEAD is now at 757a731... Added "calc" shell-script.
```
We see some changes in the README:
```
$ cat README.md 
...
```
and in our repository -- we can see the `calc` script:
```
$ ls
calc  Makefile  README.md
```
This means - we can mark some stages of our development with tags. And then, using the "checkout" operation, we can switch between them at any time. OK - let's look at our calculator:
```
$ cat calc 
#!/bin/sh

expr $*
```
Wow - looks pretty simple! We simply call the expr program with the arguments passed to our script. And as we can see, `expr` is just an expression evaluator:
```
man expr
```
And this is the usual way of UNIX development - not reinvent the wheel, but just take parts of them and glue them with a Shell. OK -- let's try to test:
```
$ ./calc 1 + 2
3
```
We understand that the expression is just the arguments of the `expr` command and we must separate them with spaces.
```
$ ./calc 5 - 7
-2
$ ./calc 6 / 3
2
```
Looks good - let's try divide:
```
$ ./calc 6 / 3
2
$ ./calc 6 / 0
expr: division by zero
$ ./calc 7 / 3
2
```
OK, got it - `expr` performs integer operations and we have to use another operation for the remainder of the division:
```
$ ./calc 7 % 3
1
```
But:
```
$ ./calc 2 * 2
expr: syntax error
```
What's wrong? Let's try to debug:
```
$ sh -x ./calc 2 * 2
+ expr 2 Makefile README.md calc 2
expr: syntax error
```
Oh yeah - the asterisk are just special Shell matching characters, in this case meaning - all files in the current directory! And it is replaced by all files from the current directory. We need to fix it.
