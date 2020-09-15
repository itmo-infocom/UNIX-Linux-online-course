## Functions

```
[function] name () {list}
```
This defines a function named name. The reserved word `function` is optional.

And we can `return` some exit code from the function.
```
return [n]
```
Arguments in the function are treated in the standard way as dollar with positional parameter number. From the point of view of an external observer, the function looks exactly the same as a regular command. And as we remember, some Shell libraring is possible:
```
$ vi lib
usage() {
	echo Usage: $1 args...
	exit
}
```
Let's check:
```
$ set
...
usage () 
{ 
    echo Usage: $1 args...;
    exit
}
$ usage test
Usage: test args...
exit
```
It works. And now we will use it in our script:
```
$ vi hello 
source ./lib

if [ $# -lt 1 ]
then
	usage $0
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
$ ./hello
Usage: ./hello args...
```

## Useful functions
And finally -- a lot of useful functions embedded in Shell:
```
basename – strip directory and suffix from filenames
dirname – strip non-directory suffix from file name
echo – display a line of text
eval – execute expression by the shell
exec – replace the shell by command
read – read string from stdin to variable
readonly -- variables are marked readonly
shift – shift parameters
sleep – delay execution for a specified amount of time
```
And it would be helpful to be able to understand what exactly we are running when we call the command. And we have the following commands:
```
which, type – which command?
```
Let's try to run:
```
$ type usage 
usage is a function
usage () 
{ 
    echo Usage: $1 args...;
    exit
}
$ which usage 
/usr/bin/which: no usage in (/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/opt/go/bin/::/home/sadov/.local/bin:/home/sadov/bin:/home/sadov/go/bin/:/opt/go/bin/:)
```
Why are the results so different? Just because the first is a built-in function and the other is a real command:
```
$ type type  
type is a shell builtin
$ type which
which is aliased to `alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
```
For an external binary, the results are the similar:
```
$ which sh
/usr/bin/sh
$ type sh
sh is /usr/bin/sh
```



