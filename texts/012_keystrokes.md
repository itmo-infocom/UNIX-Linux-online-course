A few words about keyboard shortcuts. They are actually very useful for command line work. Let's take a look at them:

* erase – erase single character: [Backspace] or [Ctrl]-[H], [Delete] or [Ctrl]-[?]
* werase – erase word: [Ctrl]-[W]
* kill – erase complete line: [Ctrl]-[U]. This can be very useful when you enter something wrong on an invisible line, such as when entering a password.
* rprnt – renew the output: [Ctrl]-[R]
* intr – [Ctrl]-[C] or [Delete]. Kill current process. In fact, these strange settings for the [Delete] key were used by some older UNIX. And many were very confused when, when trying to delete incorrectly entered characters, they killed the executable application. 
* quit – [Ctrl]-[\]. Kill the current process, but with a memory dump. Such a dump can be used to analyze the internal state of programs by the debugger. It can be created in the system automatically during a program crash, if you have configured your system accordingly, or like this -- by [Ctrl]-[\] keystroke to analyze state, for example, a frozen program.
* stop – [Ctrl]-[S]. Stop a current process.
* start – [Ctrl]-[Q]. Continue a previously paused process. And if the program seems to be frozen, first try pressing [Ctrl]-[Q] to resume the process. Perhaps you accidentally pressed [Ctrl]-[S].
* eof – [Ctrl]-[D]. End of file mark. Can be used to complete input of something.
* susp – [Ctrl]-[Z]. As you probably know, this is the EOF mark on Windows systems. But on UNIX-like systems, it stops the current process and disconnects it from the current terminal line. After that, the execution of this process can be continued in the foreground or in the background.

KSH/Bash keyboard shortcuts.
* [ЕЅС]-[ЕЅС] or [Tab] – Auto-complete files and folder names. This is very useful for dealing with UNIX-like file systems with very deep hierarchical nesting. As we will see later, three levels of nesting is a common place for such systems. Of course, we can use file management interfaces like graphical file managers or text file managers like Midnight Commander (mc), reminiscent of Norton Commander. But as we can see, in most cases, the autocompletion mechanism makes navigating the file system faster and can be easier if you know what you are looking for.

To use this machinery, you just need to start typing what you want (command name, file path or environment variable name), press [Tab] and the shell will try to help you complete the word. If it finds an unambiguous match, the shell will simply complete what it started. And if we have many variants, Shell will print them and wait for new characters to appear from us to unambiguously start the line. For example:
```
$ ec[tab]ho $TE[Tab]RM
xterm-256color
$ ls /u[tab]sr/l[Tab]
lib/     lib32/   lib64/   libexec/ libx32/  local/ 
o[Tab]cal/
bin  etc  games  include  lib  man  sbin  share  src
$
```
* [Ctrl]-[P] – Go to the previous command on "history"
* [Ctrl]-[N] – Go to the next command on "history"
* [Ctrl]-[F] – Move cursor forward one symbol
* [Ctrl]-[B] – Move cursor backward one symbol
* [Meta]-[F] – Move cursor forward one word
* [Meta]-[B] – Move cursor backward one word
* [Ctrl]-[A] – Go to the beginning of the line
* [Ctrl]-[E] – Go to the end of the line
* [Ctrl]-[L] – Clears the Screen, similar to the "clear" command
* [Ctrl]-[R] – Let’s you search through previously used commands
* [Ctrl]-[K] – Clear the line after the cursor

Looks more or less clear except for the Meta key. The Meta key was a modifier key on certain keyboards, for example Sun Microsystems keyboards. And this key used in other programs -- Emacs text editor for ex. On keyboards that lack a physical Meta key (common PC keyboard for ex.), its functionality may be invoked by other keys such as the Alt key or Escape. But keep in mind the main difference between such keys - the Alt key is also a key modifier and must be pressed at the same time as the modified key, but ESC generally is a real ASCII character (27 / hex 0x1B / oct 033) and is sent sequentially before the next key of the combination.

Another key point is that the origins of these key combinations are different. The second is just the defaults for those specific shell and can be changed using the shell settings. But the first one is the TTY driver settings. And if we want to change such keyboard shortcuts, for example, so that the Delete key does not interrupt the process, we can do this by asking the OS kernel to change the parameter of the corresponding driver. As we will see later, this can be done with the 'stty' utility.
