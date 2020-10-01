# Manuals

The easiest way to get information about the use of a command is the -h option or --help for GNU long options.

Also since its inception, UNIX has come with an large set of documentation. Some information is often found in the `/usr/doc` or `/usr/local/doc` directories as text files.

But the cornerstone of the Unix help system is the `man` command. And the "man" in this case is not about gender -- it is just an abbreviation for "manual".
```
man man
```
The `man` command has been traditional on UNIX since its inception, was created in the teletype era and still works great on all types of equipment. And in the synopsis of the `man` command, we can see two worlds, two UNIX utility systems: BSD and SYSV.

And at first we can see the different command syntaxes:
```
SYSV – man [-t] [-s section] name
GNU, BSD – man [-t] [section] name
```

Parts of the man page are more or less the same:
NAME, SYNOPSIS, DESCRIPTIONS, FILE, SEE ALSO, DIAGNOSTIC, BUGS

The '-s' option with some integer parameter of `man` command in the SYSV variant denotes a section of real paper manuals supplied in the old days with the OS by vendor. For GNU/BSD flavors, use only the section number. Section numbers are also different, as you can see here [Pres-n p.4](http://sdn.ifmo.ru/education/courses/free-libre-and-open-source-software/lectures/lecture-3).

Let's look for example to well known C-languge function `printf` manual page. But
```
man printf
```
shows us the `man` page for the shell command, not the C function. To see the manual for the C-language `printf` function, we must run:
```
man 3 printf
```
To view a list of printf-related manual pages, we must run:
* `whatis` -- search the `whatis` database (created by `makewhatis` utility) for complete words
* and `man -k` or `apropos` -- search the `whatis` database for strings.

The databases should be created by the `makewhatis` program, which is usually started at night by the `cron` service. If you have a freshly installed system and want to run any command related to the `whatis` database, you posibly need to start the `makewhatis` program manually.

OK -- let's look to real man page:
```
zless /usr/share/man/man1/man.1.gz
```
This is a `troff` format. Troff(short for "typesetter roff")/nroff(newer "roff") is an implementation of a text formatting program, in traditional for UNIX systems style -- using a plain text file with a some markup. It is ideologically based on the RUNOFF MIT program, developed in 1964, and after a series of source code losses and rewrites, a C-based implementation was re-implemented in 1975. Under the name Troff, it was accepted for use on the UNIX system and, of course, into the AT&T patent department. See the [History of UNIX Manpages])http://manpages.bsd.lv/history.html)

The main advantage of this tool was portability and the ability to generate printouts for various devices, from a common ASCII printer to high-quality typographic photosetters. Creating new technologies such as PostScript printers simply adds the appropriate output drivers for the markup renderer. Compared to the now better known WYSIWYG (What You See Is What You Get) systems, such systems have better portability between platforms and higher typing quality. Moreover, such systems are more focused on the programmatic creation of printed documents without human intervention.

Let's take a look at an example of manually rendering the man page that was hidden under the hood of the `man` command:
```
$ zcat /usr/share/man/man1/man.1.gz | tbl | eqn -Tascii | nroff -man | less
```

It's just a programs pipeline in which we unpack the compressed TROFF source, go through the TROFF preprocessor for tables and math equations, pass a `troff` variant named 'nroff' to output a text terminal, and finally pass a text pager/viewer named 'less' .

What is it viewer? In the TTY interface, the `man` command seems like a good one -- when you run it, you get paper manuals that you can combine into a book, put on a shelf, and reread as needed. On a full-screen terminal -- before, Ctrl-S (stop)/ Ctrl-Q(repeat) was enough for viewing, because at first the terminals were connected at low speed (9600 bits per second for ex.), and now, in our faster times, they use special programs -- viewers.

And actually, when you run the `man` command, you see just a viewer's interface, in most cases it is `less`. We will discuss viewers further, but in a nutshell, the most commonly used ot them the `less` handles standard UP/DOWN keys and exiting a program -- the 'q' key means 'quit'.

Well. It looks great, but the man-sytle documentation representation has certain limitations: it is only a textual representation without any useful functions invented after that time -- for example, impossibility of using hypertext links.

To improve it, the GNU Project has created an information system that also works on all types of alphanumeric terminals, but with hypertext support -- `info` system. For many GNU utilities, the corresponding help files are in `info` format, and the man pages recommend that you refer to `info`.

`Info` has its own user interface and the best way to learn it is to simply run the `info info` command. The internal source of "info" is the text markup files again in texinfo format. From such files are generated text files for viewing on terminals, and also by the TeX typesetting system generated documentation for printing. 

TeX is another typesetting system (or "formatting system") that was developed and mostly written in 1978 by Donald Knuth. TeX and its LaTex extension are very popular in the scientific world as a means of typing complex mathematical formulas.

OK. But the inability to use graphic illustrations and any kind of multimedia context remained relevant. And in the past, almost every commercial UNIX system vendor created their own help system, which includes both hypertext support and graphics for ex., and worked in the X Window graphical System.

But now with the advent of HTML (yet another text markup language), such reference information began to be provided in this format directly on the system or on WWW servers. Often these HTML pages or print-ready PDF versions are simply generated from some content oriented markup such as DocBook XML.
