The standard design pattern for UNIX commands is to read information from the standard input stream (by default -- the keyboard of the current terminal), write to standard output (by default -- terminal screen), and redirect errors to standard error stream (also the terminal screen), unless specified in the command parameters anything else. These defaults settings can be changed by the shell.

The command ends with a sign "greater than" and the file name, means redirecting standard output to that file. The application code does not change, but the data it sends to the screen will be placed in this file.

And the command ends with a "less than" sign and a file name, which means redirecting standard input to that file. All data that the application expects from the keyboard is read from the file.

Double "greater than" means appended to the output file.

Number two with "greater than" means redirecting standard error to a file. By default, stderr also prints to the screen and in this way we can separate this stream from stdin.

And finally, such a magic formula:
```
prog 2>&1
```
This means stdout and stderr are combined into one stream. You can know more about the meaning of this combination of symbols from our
[Under the hood -- about streams numbers](../under_the_hood/03_streams_numbers.md) lecture.

You may use it with other redirection, for example:
```
prog > file 2>&1
```
This means to redirect standard output to one "file", both standard output and standard error streams. But keep in mind -- such combinations are not equivalent:
```
prog > file 2>&1 != prog 2>&1 > file
```
In the second case, you first concatenate the streams and then split again by redirecting stdout to the selected file. In this case, only the stdout file will be put into the file, stderr will be displayed on the screen. The order of the redirection operations is important!

So the question is: what are we missing in terms of symmetry? It's obvious -- double "less than" sign.

And this combination also exists! But what can this combination means? Append something to standard input? But this is nonsense. Actually this combination is used for the so-called "Here-document".
```
prog <<END_LABEL
.....
END_LABEL
```
After the double "less than" some label is placed (END_LABEL in our case) and all text from the next line to END_LABEL is sent to the program's standard input, as if from the keyboard.

Be careful, in some older shells this sequence of commands expects exactly what you wrote. And if you wrote a space before END_LABEL just for beauty, the shell will only wait for the same character string with a leading space. And if this line is not found, the redirection from "here document" continues to the end of file and may be the source of some unclear errors.

And finally, the pipelines. They are created with a pipe symbol placed between commands. This means connecting the standard output from the first command to the standard input of the second command. After that, all the data that the first command by default sending to the screen will be sent to the pipe, from which the second command will be read as from the keyboard.

Programs designed in this redirection and pipelining paradigm are very easy to implement and test, but such powerful interprocess communication tools help us create very complex combinations of interacting programs. For example as such:
```
prog1 args1... < file1 | prog2 args2... | ... | progN argsN... > file2
```
The first program receives data from the file by redirecting stdin, sends the result of the work to the pipeline through stdout and after a long way through the chain of filters in the end the last command sends the results to stdout which is redirected to the result file.

Interestingly, some I/O redirection is supported in MS OSes, but with some unexpected specifics. See details in ["Under the Hood" -- Text handling in Windows](../under_the_hood/04_text_in_Windows.md) lecture.

