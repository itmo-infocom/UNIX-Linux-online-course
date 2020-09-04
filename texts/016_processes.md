## Process

We've discussed the users, and then it's appropriate to talk about another of the three whales of UNIX-like systems -- processes. We can get information about the processes by running the "ps" (process status) command. In this case, we again see two worlds - two systems SYSV and BSD:
```
SYSV – ps [-efl]
BSD – ps [-][alx]
```
What about GNU? As we can see, GNU ps supports both sets of options with some long options.

By default ps without options shows only process started by me and connected to my current terminal line.

To get the status for all processes, we must use:
```
SYSV – ps -ef
BSD – ps ax
```
And we can get more information about the processes using the "long" options:
```
SYSV – ps -l
BSD – ps l
```
What information about the processes can we see? 
UID -- effective user ID. A process can have a different identifier than the user running the application because, as we will see later, there is a mechanism in UNIX-like systems to change the identifier on the run.
* PID -- a number representing the unique identifier of the process.
* PPID -- parent process ID. As we remember, We have a hierarchical system of processes, and each process has its own parent. We can see this hierarchy for example by such options set:
```
ps axjf | less
```
or just by command:
```
pstree
```
PRI -- priority of the process. Higher number means lower priority. But, as we will discuss later, we cannot change the priority, because this value is dynamically changed by the process scheduler. And we can only send recommendations to the scheduler using the 'nice' (NI) parameter:
NI -- can be set with 'nice' and 'renice' commands
["Under the Hood" -- Process scheduler](under_the_hood/scheduler..md)
TTY -- controlling tty (terminal).
CMD -- and the command.

And also a very useful (especially if the system hangs) command 'top', which dynamically displays information about processes, sorted accordingly by the use of system resources -- memory and CPU time.

nice - run a program with modified scheduling priority. 'Nice' value is just an integer.  The smallest number means the highest priority. The nice's range can be different on different systems and you should look at the "man nice" on your system. In the case of Linux nice value -- between -20 and 19. Only the superuser can increase the priority, the normal user can just decrease the default, which can be seen by invoking the "nice" command with no arguments.

For example:
```
nice -n 19 command args...
```
means execution of the command with the lowest priority. This can be useful for reducing the activity of non-interactive applications, such as the backup process, which can slow down the interactive response of the system.

renice -- alter priority of running processes by PID. In this case, you may not use the '-n' option - just a 'nice' number. For example:
```
renice 19 PID...
```

## Jobs

At the Shell level, we can use the 'jobs' mechanism.

The easiest way to start a new background job is to use the ampersand:
```
gedit &
xeyes
```

Once the command is running, we can disconnect from the terminal line and pause it by pressing '^ Z'. As we can see, the eyes do not move now.

We can see background and suspended jobs using the jobs command:
```
jobs
```
In the first position of the jobs list, we see the job number. We can use this job number with a percent sign in front of it.

A suspended task, we can switch it to the background execution mode. By default -- current job:
```
bg [%jobN] – resume suspended job jobN in the background
```
and reattach the background job to the terminal line by bringing it to the foreground:
```
fg [%jobN] – resume suspended job jobN in the foreground
```
After that we can interrupt the foreground job by pressing '^C'.

## Signals

Another way to terminate a process is with the 'kill' command:
```
kill %job
```
also you can kill the process by PID number:
```
kill [-s sigspec | -n signum | -sigspec] [pid | jobspec] ...
```
But in some cases 'kill' does not work -- for example, if the process is frozen. We can fix this problem by calling another kill, just because kill is actually sending a signal to the process, and we just have to choose a different signal. 
```
kill -l – list of signals
```
15) SIGTERM – generic signal used to cause program termination (default kill)
2) SIGINT – “program interrupt” (INTR key – usually Ctrl-C)
9) SIGKILL – immediate program termination (cannot be blocked, handled or ignored)
1) SIGHUP – terminal line is disconnected (often used for daemons config rereading)
3) SIGQUIT – core dump process (QUIT key -- usually C-\)

## Offline execution

When you execute a Unix job in the background ( using &, bg command), and logout from the session, your process will get killed. We can avoid this using nohup command:
```
nohup – run a command immune to hangups, with output to ‘nohup.out’
```
Another very useful program is 'screen' – it's screen manager with VT100/ANSI terminal emulation which supports multi-screen session support with offline execution. In fact, you can run some long running commands on multiple screen sessions and after disconnecting from this terminal line with your hands or after breaking connecting. After that, you can reconnect to this screen and you will see that all processes are still running.

## Later execution and scheduled commands

Another possibility of offline executing commands is later execution and scheduled commands.
```
at, batch, atq, atrm - queue, examine or delete jobs for later execution
```
```
crontab - maintain crontab files for individual users
```
