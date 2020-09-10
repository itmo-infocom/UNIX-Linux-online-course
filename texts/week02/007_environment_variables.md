The operating system supports a special kind of resource called environment variables. These variables are a NAME/VALUE pair. The name can start with a letter and be composed of letters, numbers, and underscores. Variable values have only one type -- character strings. Names and values are case sensitive. And, as we'll see, variables can be global and local, just like in common programming languages.

To get the value of a variable on the Shell, precede the variable name with a dollar sign:
```
$ echo $USER
guest
```

If the variable is not set, an empty string is returned:
```
$ echo $TEST
$
```

The assignment operator is used to set the value of a variable (in the case of Bourne-like shells):
```
$ TEST=123
```
or the built-in 'set' operator (in the case of C-like Shells):
```
$ set TEST=123
```
You can check your settings by calling the `echo` command, which simply sends its own arguments to stdout.
```
$ echo $TEST
123
```
The `set` command with no arguments lists the values of all variables set in the environment:
```
$ set
COLUMNS=197
CVS_RSH=ssh
DIRSTACK=()
....
```
Shell commands can be combined into command files called scripts, where the first line, in a special kind of comment, specifies the shell to execute the set. For example, let's create a file called test in a text editor or just by command 'cat' with the following content:
```
$ sh > test
#!/bin/sh

echo TEST:
echo $TEST
```
This program will print the text message "TEST:" and the value of the TEST variable, if this one specified, to standard output. You can run it from the command line by passing it as a parameter to the command interpreter:
```
$ sh test
TEST:
```
We didn't see the value of the variable. But why? Because we started a new shell process to run the script. And we have not set this variable in the context of this new shell. Let's do it. Okay, let's expand our definition to the environment space of all processes started from our current shell:
```
$ export TEST=456
$ sh test
TEST:
456
```
And, as we can see, the value of the variable in our current SHELL has also changed:
```
$ echo $TEST
456
```
The export operation is the globalization of our variable. You can get the settings for such global exported variables for a session by calling the interpreter builtin command `env`, in the case of Bourne-like interpreters (sh, ksh, bash, zsh, pdksh ...), and `printenv` in the case of the C-Shell style (csh, tcsh. ..):
```
$ env
HOSTNAME=myhost
TERM=xterm
SHELL=/bin/bash
...
```
And this is our first example of using the command pipeline machinery -- we just look at only the TEST variable in the full set:
```
$ env | grep TEST
TEST=456
```
Variables can be local to a given process or global to a session. You can set local values for variables by preceding command calls:
```
$ TEST=789 sh -c 'echo $TEST'
789
```
But, as we can see, our global settings are the same:
```
$ echo $TEST
456
$ sh /tmp/test
TEST:
456
```
We can remove the setting of variables using the 'unset' command:
```
$ unset TEST
$ echo $TEST
```
As we can see, this variable has also been removed from the list of global environment variables:
```
$ sh /tmp/test
TEST:

$ env | grep TEST
$
```
And there is no "unexport" command -- just only `unset`command.

Finally, as with traditional programming languages, we can use shell scripts such as libraries that can be run from an interactive shell session or from another shell script to set variables or functions for top-level processes. Let's try to write another script in which we simply set the TEST variable.
```
$ cat > /tmp/test_set
TEST=qwe
$ source /tmp/test_set
$ echo $TEST
qwe
```
But for our first script, this variable is still invisible:
```
$ sh /tmp/test 
TEST:
$
```
Why? Just because it is not exported. Let's export:
```
$ cat > /tmp/test_exp
export TEST=asd
```
And run our test script agian:
```
$ sh /tmp/test 
TEST:
asd
```
As we can see, in our main shell session, the variable has changed too:
```
$ echo $TEST
asd
```


