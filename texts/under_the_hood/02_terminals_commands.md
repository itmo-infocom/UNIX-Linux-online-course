As we discussed, the main channel of communication between a computer and a person was the teletype. But once upon a time, CRT terminals were invented. The first CRT displays were on the mainframes. These were block-oriented complex devices with their own interfaces (often proprietary). Actually they was micro-computers that supported inline editing. And only after pressing a special button, the data buffers are exchanged between the terminal and the mainframe. Some of terminals supported the vector graphics.

But in the late 1960s, a cheaper type of terminal was developed, the character terminal, which supported serial lines such as TTY and worked with streams of characters. At first they were just "glass teletypes". But it was understandable -- in CRT there are more possibilities for redrawing the screen compared to simple printing on TTY.

But we have a very small set of commands in the ASCII character set, and it is mostly paper-oriented. How can we move the cursor to any position on the screen, change the color or font? How can we implement arrow keys? ASCII only supports the TTY keyboard simple character set.

We need some not very commonly used symbol to denote our more complex commands, consisting of a group of bytes transmitted over a serial line. And we have such a symbol on the keyboard in the upper left corner -- ESC. It has his own ASCII code 27 in decimal format or `Ctrl + [` on keystrokes. And it's possible to create own command set that encodes commands for controlling the screen or additional keys on the keyboard.

And every terminal vendor in the 70s developed their own set of commands for this. Mostly incompatible with others. And, for example, to develop a full-screen editor, we must be ready to use all such sets. And in UNIX, special mechanisms were developed for this: the termcap and terminfo databases, as well as special libraries for working with them.
```
$ zless /usr/share/doc/xterm/xterm.termcap.gz #Ubuntu
$ man termcap
```
The terminal description is a slightly cryptic configuration string with colon-separated fields. In `termcap` such configurations are still in the text file `/etc/termcap`, for `terminfo` such text descriptions are compiled into binary data base. The corresponding library reads the TERM environment variable, loads a description of the ESC commands set for that terminal, and gives us the ability to manipulate screens at a more abstract level, such as using the `curses` library.

