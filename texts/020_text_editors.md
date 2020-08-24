OK. We can create a file using the `cat` utility and view the file using a viewer. But what if we need to change something, especially if we only have a TTY interface? And it is possible - we have a so-called line editor named `ed`. The only interface for such an editor is the command line: [Pr-n 6 slide 5](http://sdn.ifmo.ru/education/courses/free-libre-and-open-source-software/lectures/lecture-6).

So let's try to edit new file.
```
$ ed tst
tst: No such file or directory
```
At first -- we will add some lines:
```
i
1 2
3 4
```
and we must end our input with one 'dot' per line.
```
.
```
Let's take a look at our file, moving to the first line:
```
1
1 2

3 4

?
```
Seems good. Now we can add something to the end:
```
a
5 6
.
1
1 2

3 4

5 6

?
```
OK -- we have 3 lines in the file now. And finally -- let's try to make a magic pass:
```

1,$s/\(.\) \(.\)/\2 \1/
1
2 1

4 3

6 5

?
```
This means: from the first to the last line, replace the lines where we have two separate letters separated by a space, exchanging those letters with places. And now 'write' and 'quit':
```
w
12
q
```
Let's check the result:
```
$ cat tst
2 1
4 3
6 5
```

But for what purposes can you use a line editor now that we have full-screen editors with a user-friendly interface? Of course, you can imagine a situation where your full-screen environment is broken and only the line editor will be the salvation. And in general I had such situations. But the main use case for ed is for automatic editing in scripts. Anything you need to change in the text data can be done with this editor, including sophisticated regex search and replace.


Moreover, we have a `sed` -- stream editor, for editing text data in pipelines:
```
$ sed 's/\(.\) \(.\)/\2 \1/' < tst
1 2
3 4
5 6
```
As you can see, the original file does not change, all changes are simply sent to standard output:
```
$ cat tst
2 1
4 3
6 5
```
But UNIX-like systems also have full-screen editors, which can also be confusing for beginners. It was developed by Berkeley student Bill Joy for BSD initially as a visual mode for a line editor. It is a very fast and lightweight editor that is part of the  Single Unix Specification and the POSIX, which found on every UNIX-like system. The VI editor works on all types of terminals and generally requires only a conventional letter keyboard. You can work with it without the arrow keys, PgUp/Down or anything similar. There are actually very small keyboards out there that are optimized for vi.

But to work on it, you need to understand the basic concept of this editor: it can be in three states [Pr-n 6 slide 6](http://sdn.ifmo.ru/education/courses/free-libre-and-open-source-software/lectures/lecture-6). Immediately after launch, we find ourselves in the usual command mode and can switch to editing mode, for example, by pressing the "Insert" key. As we can see, the mode status in the lower left corner has changed to '-- INSERT --', and now we can edit our file. Pressing Insert again will change the state mode to '-- REPLACE --' and vice versa. Exit the editing mode by pressing ESC. The third mode can be accessed by pressing the colon key in command mode. This is `ed` mode. In this mode, we can use the normal 'ed' line editor commands and finish them with ENTER.

In command mode, you can find something with regex by slash and question marks, as in the 'less' viewer. In improved VI (vim), you can use very useful visual mode by pressing V. After that you can delete the selection with 'd' or just copy it with 'y' (yank). Then you can paste it anywhere with 'p' (paste). Moreover, you can use Ctrl-V to select a vertical box. To exit visual mode, simply press ESC.

Also you may look to vimtutor - a guide to Vim can be useful for beginners.

And the second most common editor is Emacs. This Richard Stallman's editor was the starting point for the GNU Project, along with GCC and UNIX utilities. EMACS means, for example, "Editing MACroS". An apocryphal hacker koan alleges that the program was named after Emack & Bolio's, a popular Cambridge ice cream store. But overall it is a really very powerful editor with macro extensions, allowing the user to override any keystrokes to launch the editor program. But unlike other editors that support macro-extensions, in Emacs they are implemented using the LISP programming language embedded on editor. At the time, LISP was very popular in artificial intelligence in the United States, and Stallman, who worked at the MIT Artificial Intelligence Lab, chose it as the editor extension language.

This implementation allows many LISP-based applications to be developed, including a user-friendly interface for developers in various programming languages. Usually Emacs is a text editor with a simple graphical interface. But it can only be run in a text environment. The most commonly used keystrokes are:
```
C-c C-x – exit
C-h t – tutorial
C-h i – info
```
If you feel overwhelmed by the difficulty of Emaccs, you can see a personal psychoanalyst:
```
M-x doctor
```
It would spoil the fun and hurt your recovery to say too much here about how the doctor works. But when you're ready, you may try to find the well-known Turing-test related AI program ELIZA on WikiPedia.

Also in the UNIX / Linux world, there are many other editors that may be more convenient for you, such as:
* joe, nano – simple text editors
or
* gedit, kate -- text editors from Gnome and KDE projects
