OK. But you can get useful information not only from the 'info' utility.

# OS variant
Ok, we just logged in. First, let's try to determine which part of the UNIX-like universe we are in.

uname -- print system information, in most simple case -- just name of kernel. With "all" flag we will get more information. And for what needs can such information be used, besides simple curiosity? The answer is simple -- it can be used to create portable applications or some kind of administrative scripts for various types of UNIX-like systems. You can use it in your installation or shell configuration scripts to select different binaries and system utilities according to your specific computer architecture and OS.

This works well for good old UNIX systems that are very vendor dependent. But on Linux systems, `uname` will only display the Linux kernel name, possibly with the kernel version. And as we know, we will have many different Linux distributions, which can be very different from each other. And how can we adapt to this diversity?

One of the possibilities is the lsb_release command:
lsb_release – provides certain LSB (Linux Standard Base) and distribution-specific information. The Linux Standard Base (LSB) is a joint project by several Linux distributions under the organizational structure of the Linux Foundation to standardize the software system structure, including the Filesystem Hierarchy Standard used in the Linux kernel. The LSB is based on the POSIX specification, the Single UNIX Specification (SUS), and several other open standards, but extends them in certain areas.

## Date
Good. We get information about "where". Let's try to figure out "when".

date - print the system date and time. What time? The current time of our time zone. We can check the time in a different time zone, for example, Greenwich Mean Time (GMT):
```
$ TZ=GMT date
```
We can also set the current computer time:
```
$ man date
...
 date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]
...
```
Also you can choose a different output format for time and date using the '+' option:
```
date [OPTION]... [+FORMAT]
```
and use this command to convert from different time representations using the '--date' option. You can find more details on the man page.

And of course we can see the calendar:
```
$ man cal
...
cal - displays a calendar
...
```
For example, the calendar for the first year of the UNIX epoch:
```
$ cal 1970
```

## Users information commands
Okay - 'what', 'when', but what about 'who'? As we discussed earlier - we know that users and groups are just some magic numbers. Let's look at the user's info:
```
id - print real and effective user and group IDs
```
But also we have yet another command:
```
logname - print user´s login name
```
For what needs can we use this command if we already have an `id` command? First of all: as far as we remember, we have different users, moreover, different types of users. Let's look... This is a regular user session. The username is "user". Let's look to 'id' command. And this is the session of the root user. He, as we remember, is the superuser. And we see absolutely another result of the id command. But "logname" will show the same result in both cases, just because we are logged in with the user named "user" in both sessions, and then switched to superuser with the "sudo" or "su" command. This can be important in some cases, and you can use this command to determine the real user ID.


##Multiuser environment

As we recall, a UNIX-like system is a multi-user environment, and we have many utilities for working with such a system.

who - show who is logged on
finger - user information lookup program -- more informative command including user downtime. At this point, it can be understood that a particular user is still sitting at his workplace or has left for coffee. Moreover, we can see the user's status on other computers. But in this case, you must understand that this is a client-server application. You must have a server part on the computer that you requested, and you need the appropriate privileges. 

If you find the required user in the list of computer users, you can send him a message manually or from the program using the "write" command:
```
write - send a message to another user
```
Just enter something and finish your message with EOF (^D as we remember). In this command, we can select the terminal line to write.

##Terminal line control

And we can get our current terminal line using the 'tty' command:
```
tty - print the file name of the terminal connected to standard input
```
We also have 'stty' command to print and change terminal line settings. With the option '-a | --all 'we can get all the current driver settings of this terminal line. And then we can change these settings with this command. For example, the previously discussed setting of the Delete key to interrupt a program on some older UNIX systems.

Another note about older UNIX systems is that stty on such systems may not have the '-F' option. But we still have the option to select the device - just by redirecting stdin:
```
stty < /dev/tty0
```
