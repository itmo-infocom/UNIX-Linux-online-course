## Basic logical operators

So we have scripts with arguments, but what about the logic? We have some operations that look like logical ones, but at first glance they look a little strange. In fact, the cornerstone of Shell's logic is this strange reserved variable:
```
$? – exit value of the last run command
```
For example, we have the following commands:
```
$ true; echo $?
0
$ false; echo $?
1
```
What does this mean? Only one thing -- we have a successful program with an exit code of 0 and a failure with a non-zero exit code. It seems strange, but it is understandable -- in fact, UNIX follows Leo Tolstoy's principle: “All happy families are alike; each unhappy family is unhappy in its own way.” That's right -- we were not interested in the details of when our program finished successfully, but the reason for the failure can be different and we should be able to separate one from the other.

And if we have successful and unsuccessful results, we can operate on those results using operations similar to the logical operators AND and OR:
* prog1 && prog2 -- means running prog2 if prog1 succeeds (with 0 exit code)
* prog1 || prog2 -- means start prog2 if prog1 failed (exited with code other than 0)

Our programming language also has the good old "if":
```
B: if list; then list; [ elif list; then list; ] ... [ else list; ] fi
C: if (list) then list; [ else if (list) then list; ] ... [ else list; ] endif
```
And what is this “list” in this case? These are just a command. The exit code of the command will determine the behavior of the `if`.

## Test
And the most commonly used command in `if` statements is` test`. And the most commonly used command in statements is `if` -- the `test` command or just an opening square bracket (it is often just a link to the executable `test`). Be aware that if you use a square bracket, you must close the expression with a closing square bracket. And the space before that is important, because it's just command's arguments.
```
test EXPR or [ EXPR ]

Expressions:
-n STR | STR – STR is not zero
-z STR – STR is zero
! EXPR – EXPR is false
EXPR1 -a EXPR2 – AND
EXPR1 -o EXPR2 – OR
STRING1 = STRING2 – the strings are equal
STRING1 != STRING2 – the strings are not equal
INT1 -eq|ge|gt|le|lt|ne INT2 – INT1 and INT2 cmparison. Good reason to remember Fortran.
-f FILE – FILE exists and is a regular file
-d FILE – FILE exists and is a directory
-L FILE – FILE exists and is a symbolic link
```
and many others.

## Loops
We also have loop statements - `while`, which execute commands while the statement command returns 0::
```
B: while list; do list; done
C: while (list) list; end
```
and `until`, executing until the statement command fails.
```
B: until list; do list; done
```
We also have a `for` loop construct, which may not seem very familiar to programmers from classical programming languages such as C:
```
B: for name in word ...; do list ; done
C: foreach name (word ...) list ; end
```
The source of the values that are set for the loop variable is simply a string of words, separated by spaces. To emulate the classic number cycles, we have to use special commands that will generate sequences of numbers for us. Like `seq` command:
```
$ man seq
$ for i in `seq 5`; do echo $i; done
1
2
3
4
5
$ for i in $(seq 1 2 10); do echo $i; done
1
3
5
7
9
```
You can use the classic "break" and "continue" loop operators with the ability to set the loop level:
```
break [n], continue [n]
```

## Case switch
A `case` command first expands word, and tries to match it against each pattern in turn, using the same matching rules as for pathname expansion:
```
case word in [ [(] pattern [ | pattern ] ... ) list ;; ] ... esac
```
If the "double semicolon" operator is used, no subsequent matches are attempted after the first pattern match. Let's try to play with our `hello` program again:
```
$ vim hello 
if [ $# -lt 1 ]
then
	echo Usage: $0 who...
	exit
fi

case $0 in
	*hello)
		MSG=Hello
		;;
	*bye)
		MSG=Bye
		;;
	*)
		MSG="I do not know what"
esac

echo $MSG $*!
$ ./hello world
Hello world!
$ ./bye bye
Bye bye!
$ ln -s hello nothing
$ ./nothing to say
I do not know what to say!
```

