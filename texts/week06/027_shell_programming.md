# Shell programming

Now it's time to start programming, Shell programming.  As far as we understand, the shell works like a normal program and has several options that can be useful for debugging: 
```
-v		Print shell input lines as they are read.
-x		Print commands and their arguments as they are executed.
-c STRING	Read and execute commands from STRING after processing the options, then exit.
```
If your shell is Bash, you may get some help:
```
bash -c help
bash -c 'help set'
```
Let's follow the good tradition started by the classic book of Kernighan and Ritchie "The C Programming Language" and write a standard program "Hello World":
```
$ cat > hello
echo Hello word
^D
```
We complete the input with the EOF Ctrl-D character. Let's try to run now:
```
$ sh hello
Hello word
```
Good.
And now let's turn our script into a real executable program:
```
$ chmod +x hello
$ ./hello 
Hello word
```
Excellent! Now we will talk about the arguments. Let's look at our first positional parameter:
```
$ vi hello
echo Hello $1
$ ./hello 
Hello
```
We called our script without parameters and got nothing. Let's add some parameter:
```
$ ./hello world
Hello world
```
But for several parameters it does not work:
```
$ ./hello world and universe
Hello world
```
Let's fix it:
```
$ vi hello
echo Hello $*
$ ./hello world and universe
Hello world and universe
```
Excellent! As we can see, there is some difference between different shells in the use of some special variable names associated with script parameters [Pr-n 9 slide 4](http://sdn.ifmo.ru/education/courses/free-libre-and-open-source-software/lectures/lecture-9).

The main advantage of the latest shells over the classic Bourne Shell shells is the ability to use more than 9 parameters. Because in the Bourne Shell we only have one digit for the parameter number. In newer shells, we can use longer numbers in square brackets.

A very important thing in the UNIX world is the zero-numbered positional parameter. Let's try to look at this:
```
$ vi hello
echo \$0: $0
echo Hello $*
$ ./hello 
$0: ./hello
Hello
```
It's just the name of the script. And if you are familiar with the C language, you probably know -- the same is in argv[0]. For what needs can such a parameter be used? The most obvious answer seems to be to write a nice 'Usage' error message:
```
$ vi hello
if [ $# -lt 1 ]
then
	echo Usage: $0 who...
	exit
fi
echo Hello $*
```
But on UNIX-like systems we can use a very interesting trick -- linking files. Take a look at this super-nano-notebook. It runs on OpenWRT, a Linux distribution that you can find on your home internet router, for example. We have a fully functional set of Linux utilities, but if we take a closer look, we can see that all common UNIX utilities are just symbolic links to a single "busybox" binary.
```
# ls -l /bin
```
Busybox just looks at the name it is running under and performs the appropriate functions from the busybox library. This technique can reduce the memory consumption of the embedded system. Let's try to use this feature on our script:

```
$ vi hello
if [ $# -lt 1 ]
then
	echo Usage: $0 who...
	exit
fi
echo $0 $*!
$ ln -s hello bye
$ /hello world
./hello world
$ ./bye bye
./bye bye
```





