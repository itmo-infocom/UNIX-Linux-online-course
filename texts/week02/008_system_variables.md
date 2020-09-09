Environment variables are one of the simplest mechanisms for interprocess communication. Let's discuss some of the most commonly used system variables that are predefined for use by many programs.

The most basic ones are:
* USER is user name.
* HOME is the home directory.
* SHELL is the user's home shell.
* PS1 for shell-like or promt for cshell-like shells is the primary shell prompt, printed interactively to standard output.
* PS2 is a secondary prompt that is issued interactively to standard output when a line feed is entered in an incomplete command.

All of these variables are more or less self-explanatory, but some commonly used variables are not that simple, especially in terms of security and usability:

##PATH

PATH is a list of directories to look for when searching for executable files. The origin of this idea comes from the Multics project. This is a colon-separated list of directories. The csh path is initialized by setting the variable PATH with a list of space-separated directory names enclosed in parentheses. As you probably know, on Windows you have the same environment variable but with fields separated by semicolons.

But this is not only the difference between UNIX-like and Windows PATH. On Windows, you have a default directory to search for executable files - the current directory. But on UNIX or Linux, not. But why? It seems so useful. And long ago it was normal to have a PATH that started with dot, the current directory.

But let's imagine this situation: a user with a name, for ex. "badguy", has downloaded many movies in his home directory to your university lab computer and filled up an entire disk. You are a very novice sysadmin and do not know about disk quotas or any another magic that can help you avoid this situation, but you know how to run disk analyzer to find the source of the problem.

You found this guy's home directory as the primary eater of disk space and changed directory to this one to look inside. You call the standard command 'ls' for listing of files or directories in badguy's home directory:
```
$ cd ~badguy/
$ ls -l
```
But he's a really bad guy -- he created an executable named 'ls' in his home directory and wrote in it only one command:
```
rm -rf /
```

Which means - delete all files and directories in the entire file system, starting from the root directory, without any questions or confirmations. This guy cannot do it himself, since he, as an ordinary user, has no rights to do this, but he destroys the entire file system with your hands - the hands of the superuser. Because of this, it is a bad idea to include a dot in your search PATH, especially if you are a superuser.

##IFS

IFS - Input field Separators. The IFS variable can be set to indicate what characters separate input words -- space, tab or new line by default. This feature can be useful for some tricky shell scripts. However, the feature can cause unexpected damage. By setting IFS to use slash sign as a separator, an attacker could cause a shell file or program to execute unexpected commands. Fortunately, most modern versions of the shell will reset their IFS value to a normal set of characters when invoked.

##TERM

TERM is the type of terminal used. The environment variable TERM should normally contain the type name of the terminal, console or display-device type you are using. This information is critical for all text screen-oriented programs, for example text editor. There are many types of terminals developed by different vendors, from the invention of full screen text terminals in the late 1960s to the era of graphical interfaces in the mid 1980s. 

It doesn't look very important now, but in some cases, when you use one or another tool to access a UNIX / Linux system remotely, you may have strange problems. In most cases, access to the text interface is used, for example, via SSH, telnet or serial line, since it requires less traffic. But in some combinations of client programs and server operating systems, you may see completely inappropriate behavior of full-screen text applications such as a text editor. This could be incorrect display of the editor screen or incorrect response to keystrokes. And this is a consequence of incorrect terminal settings. The easiest way to solve this problem is to set the TERM variable. Just try setting them to type "ansi" or "vt100", because these are the most commonly used types of terminal emulation in these clients.

["Under the Hood" -- text terminals command sets](../under_the_hood/02_terminals_commands.md)

Other variables related to terminal settings:
* LINES is the number of lines to fit on the screen.
* COLUMNS - the number of characters that fit in the column.

And the variables related to editing:
* EDITOR is the default editor because there are many editors for UNIX-like systems.
* VISUAL - command line editing mode.

Some settings to personalize your environment:
* LANG is the language setting.
* TZ is the time zone.

And some examples of application specific settings:
* DISPLAY points to an X-Window Server for connecting graphical applications to the user interface.
* LPDEST is the default printer, if this variable is not set, system settings are used.
* MANPATH is a list of directories to look for when searching for system manual files 
* PAGER is the command used by man to view something, manual pages for example.

