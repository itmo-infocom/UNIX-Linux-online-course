Finally, let's discuss the third pillar that holds the whole UNIX world -- files.

To facilitate the work of users who are not familiar to working with the command line, there are a number of free file management interfaces, for example, Midnight Commander (mc), reminiscent of Norton Commander, or graphical file managers, reminiscent of MS Windows Explorer. But we'll see how we can work with files and directories from the CLI or scripts.

First, let's take a look at some of the symbols that have special meaning in the file path:
```
/	– root directory and directory separator
.	– current directory
..	– parent directory
~/	– home directory
```

As we can see, UNIX uses a slash as the directory separator, and Windows uses a backslash. This is interesting because early versions of Microsoft's MSDOS operating systems did not support subdirectories just because it was just a clone of CP/M OS from Digital Research. It was a small OS for 8-bit microcomputers. It was a small OS for 8-bit microcomputers without disk storage or with a small floppy disk. Usually there were only a few dozen files on a floppy disk, and only a flat file system with one directory per file system was supported.

And at first, Microsoft MSDOS operating systems didn't support subdirectories. Only when developing its own "multiuser" OS - OS Xenix based on UNIX, Microsoft implemented a hierarchical file system and ported it to the "single user" MSDOS. But at that point the forward slash was already taken - it was used as a standard CP/M command option marker, like a 'dash' in UNIX commands. And Microsoft choose a 'backslash' as a directory marker.

OK. As we remember, we have a hierarchical file system with a single root directory and for newbies, this file system hierarchy can seem too complex. They say, "When we install some software on Windows, we have separate directories for each product, and it's too easy for us to find something, but on your system we don't know where we can find something."

But in fact, in UNIX-like systems, we have a very clear and stable standard for file system hierarchy, which is reflected, for example, in the corresponding Linux specification:
[https://refspecs.linuxfoundation.org/fhs.shtml](https://refspecs.linuxfoundation.org/fhs.shtml)

In fact, we have three main levels with a repeating directory structure. At the first level, we have directories like this: [5 pr-n slide 3](http://sdn.ifmo.ru/education/courses/free-libre-and-open-source-software/lectures/lecture-5/). In the '/usr' and '/local' directories we see again: [slide 4](http://sdn.ifmo.ru/education/courses/free-libre-and-open-source-software/lectures/lecture-5/).
And, as I said, devices in UNIX-like systems look like files, but as special files placed in a special directory '/dev': [slide 5](http://sdn.ifmo.ru/education/courses/free-libre-and-open-source-software/lectures/lecture-5/). Usually each such file is just a rabbit hole in the OS kernel. When working with a pseudo-file in this directory, we see this device as a stream of bytes and work with it as with a regular file.

We may also have many other secret paths to the kernel, such as /proc and /sys. For example, we can see:
* /proc/cpuinfo
* /proc/meminfo
* /proc/interrupts


