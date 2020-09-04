As we remember, UNIX was originally created to automate the work of the patent office, has a rich set of tools for working with text data. But what is text? Generally it is just a collection of bytes encoded according to some encoding table, originally ASCII. In a text file, you will not see any special formatting like bold text, italics, images, etc. -- just text data. And this is the main communication format for UNIX utilities since the 1970s.

As you know, Microsoft operating systems have different modes of working with files - text and binary. In UNIX, all files are the same, and we have no difference between text and binary data..
["Under the Hood" -- Text handling in Windows](under_the_hood/text_in_Windows.md)

## Concatenating and spliting

The first creature that helps us work with text files is the "cat". Not a real "cat", but an abbreviation for concatenation. With no arguments, cat simply copies standard input to standard output. And as we understand it, we can just redirect the output to a file, and this will be the easiest way to create a new file:
```
cat > file
```
When we add filenames as arguments to our command, this will be a real concatenation - they will all be sent to the output. And if we redirect them to a file, we get all these files concatenated into an output file.
```
cat f1 f2... > all
```
If we can combine something, we must be able to split it. And we have two utilities for different types of breakdowns:
```
tee - read from standard input and write to standard output and files
split – split a file into fixed-size pieces
```

## Text viewers and editors

What is it viewer? In the TTY interface, the man command seems like a good one - when you run it, you get paper manuals that you can combine into a book, put on a shelf, and reread as needed. On a full-screen terminal - before, Ctrl-S (stop)/ Ctrl-Q(repeat) was enough for viewing, because at first the terminals were connected at low speed (9600 bits per second for ex.), and now special programs were used -- viewers. Unlike text editors, viewers does not need to read the entire file before starting, resulting in faster load times with large files.

Historically, the first viewer was the "more" pager developed for the BSD project in 1978 by Daniel Halbert, a graduate student at the University of California, Berkeley. The command-syntax is:
```
more [options] [file_name]
```
If no file name is provided, `more` looks for input from standard input.

Once `more` has obtained input (file or stdin), it displays as much as can fit on the current screen and waits for user input. The most common methods of navigating through a file are Enter, which advances the output by one line, and Space, which advances the output by one screen.  When `more` reaches the end of a file (100%) it exits. You can exit from "more" by pressing the "q" key and the "h" key will display help. In the 'more' utility you can search with regular expressions using the 'slash' or the '+/' option. And you can search again by typing just a slash without regexp. Regexp is a very important part of UNIX culture and is used in many other programs and programming environments: [Pr-n 6 slide 4](http://sdn.ifmo.ru/education/courses/free-libre-and-open-source-software/lectures/lecture-6)

The `main` limitation of the more utility is only forward movement in the text. To solve this problem, an improved 'more' called 'less' was developed. The "less" utility buffers standard input, and we can navigate forward and backward through the buffer, for example. using the cursor keys or the PgUp/PgDown keys. A reverse search with a question mark is possible.

