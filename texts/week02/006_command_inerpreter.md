# Command inerpreter

The first characters that you can see at the beginning of a line when you log in and access the command line interface is the so-called Shell prompt. This prompt asks you to enter the commands. In the simplest case, in the Bourne shell, it's just a dollar sign for a regular user and a hash sign for a superuser. In modern shells, this can be a complex construct with host and user names, current directory, and so on. But the meaning of the dollar and hash signs is still the same.

The Shell as a command interpreter that provides a compact and powerful means of interacting with the kernel and utilities. Despite the many powerful graphical interfaces provided on UNIX-like systems, the command line is still the most important communication channel for interacting with them.

All commands typed on a line can be used in command files executed by the shell, and vice versa. Actions performed in the command interpreter can then be surrounded by a graphical UI, and the details of their execution, thus, will be hidden from the end user.

Each time a user logs into the system, he finds himself in the environment of the so-called home interpreter of the user, which performs configuration actions for the user session and subsequently carries out interactive communication with the user. Leaving the user session ends the work of the interpreter and processes spawned from it. Any user can be assigned any of the interpreters existing in the system, or an interpreter of his own design. At the moment, there is a lot of command interpreters that can be a user shell and a command files executor:
* sh is the Bourne-Shell, the historical and conceptual ancestor of all other shells, developed by Stephen Bourne at AT&T Bell Labs and included as the default shell for Version 7 of Unix.
* csh -- C-Shell, an interpreter developed at the University of Berkeley by Bill Joy for the 3BSD system with a C-like control statement syntax. It has advanced interactive tools, task management tools, but the command file syntax was different from Bourne-Shell.
* ksh -- Korn-Shell, an interpreter developed by David Korn and comes standard with SYSV. Compatible with Bourne-Shell, includes command line editing tools. The toolkit provided by Korn-Shell has been fixed as a command language standard in POSIX.

In addition to the above shells that were standardly supplied with commercial systems, a number of interpreters were developed, which are freely distributed in source codes:

* bash - Bourne-Again-Shell, quite compatible with Bourne-Shell, including both interactive tools offered in C-Shell and command line editing.
* tcsh - Tenex-C-Shell, a further development of the C-Shell with an extended interactive interface and slightly improved scripting machinery.
* zsh - Z-Shell, includes all the developments of Bourne-Again-Shell and Tenex-C-Shell, as well as some of their significant extensions (however, not as popular as bash and tcsh).
* pdksh - Public-Domain-Korn-Shell, freely redistributable analogue of Korn-Shell with some additions.

There are many "small" shells often used in embedded or mobile systems such as ash, dash, busybox.
