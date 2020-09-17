## Text handling in Windows

The format of text data at first glance seems to be quite simple and versatile -- in the simplest case, we just have a set of bytes encoded by the standard ASCII character table. But if you look at the C language specification of the `fopen` function in UNIX-like and MS OSs, you will see an interesting difference. On MS systems, you will find the translation mode for newlines (https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/fopen-wfopen):
* `t` -- Open in text (translated) mode.
* `b` -- Open in binary (untranslated) mode; translations involving carriage-return and line feed characters are suppressed.

What does translation mean in this context? On UNIX-like systems, there is no difference between text and binary data. To understand this, we need to go back to the beginning -- the TTY interface. Moreover -- to the good old typewriter. The carriage is the real part of the typewriter that is used to return the paper to the far right so that the printing mechanism is aligned with the left side of the paper:
https://www.youtube.com/watch?v=EiyZSX0OnBM

For electrically driven TTYs, a special ASCII code does this job -- carriage return is defined as 13 decimal (or hex 0D), '\r' in C-language notation. And another one is line feed -- 10 (or hexadecimal 0A), '\n' in C-language notation. Despite the fact that we only pressed ENTER, that is -- LF both UNIX and MS OS did it differently.

On UNIX, the device driver does this job -- if we send it an LF, but needs a CR for the correct line ending, the driver will just add it to the device text stream. Only the characters we typed on keyboard will be placed in the text file -- only LF will be at the end of the line.

But on MS systems this work is done while working with text files. If we work with this file type, the operating system will automatically add CR to the text data before LF.

This may cause some subtle errors, and we have utilities such as `dos2unix` and `unix2dos` to convert between these formats. But in some cases, the problems plagued by MS design cannot be solved in an easy way.

A story from real life: a long time ago at the Physico-Technical Institute, our students, while writing their master thesis, developed an image processing system for processing images from a holographic interferometer. This system was designed according to the KISS principle -- from very simple parts. They have developed many different image filters for cleaning the picture, for extracting interferometric lines, for building a density map. All of these simple programs were combined by shell pipelines and simply sent the filtered image data from one processing program to another via standard I/O streams.

This approach allowed a fairly simple mechanism for playing with set of filters and their parameters and successfully writing master thesis. But one day Indian clients asked us for our interferometer, but they needed a program that would work on Windows.

Not a problem, us we know Microsoft OS'es inherited from Unix the mechanism for redirecting I/O streams and combining them through program pipes. We just recompiled the C source code on Windows and ran our scripts as batch files. And nothing works... Why? We are looking for a problem and we see -- the OS works with standard I/O streams and pipelines in text mode! And inserts CR before the LF -- in the binary image data. And all the data is broken. For solve the problem, we had to rewrite the entire system in the standard Windows style -- as a large monolithic application.


