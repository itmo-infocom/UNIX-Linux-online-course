The main design principle used in UNIX-like systems is the "KISS" principle. KISS, an acronym for "keep it stupid simple" or more officially "keep it short and simple", is a design principle noted by the U.S. Navy in 1960. The KISS principle states that most systems work best if they are kept simple rather than made complicated; therefore, simplicity should be a key goal in design, and unnecessary complexity should be avoided.

And from the very beginning UNIX was a very flexible modular system. The basic set of components from which UNIX-like systems are built is:
* Kernel
* Shell
* Utilities
* Libraries

The kernel is the first bunch of OS code that is loaded onto your computer's memory and run for execution. This program launches all processes on the system, handles interactions between system resources, and still live while your system is running. The kernel runs with the highest privileges and has access to all system resources. All processes in the system operate in user space and interact with such resources and among themselves, sending requests to the kernel using special software functions named "system calls". And the kernel handles such requests according to the permissions between the processes and resources.

***Under the hood -- kernel as a set of interrupt handlers***

But if we have a kernel, it seems reasonable to have a shell around it. And we have this one. Oh, sorry, not one -- now there are many shells dating back to the first Unix shell by Ken Thompson, introduced in 1971. Actually, the shell is the first and most important communicator between human, programs, and kernel. Generally it's just a program that is launched when the user logs in. It listens for standard input (usually from the keyboard) and sends the output of commands to standard output (usually to the screen).
The best-known implementation of the UNIX shell is the Bourne shell, developed by Stephen Bourne at Bell Labs in 1979 and included as the default interpreter for the Unix version 7 release distributed to colleges and universities. Supported environment variables, redirecting input/output streams, program pipes and powerful scripting. All modern shells (and not only UNIX shells) inherit these capabilities from this implementation.

The shell is a very effective glue for utilities in multitasking operating systems. The most commonly used utilities were developed early in the life of UNIX. There are tools for working with users, groups, files, processes. Since UNIX was originally created to automate the work of the patent department, it has a rich set of tools for processing text files and streams. The most commonly used design pattern for UNIX utilities is the filter between standard input and standard output. An arbitrary number of such programs can be combined into a so-called software pipeline that uses Shell program pipes for interprocess communication.

Each such utility can be very simple, but together they can be a very powerful compound program that fits on a single command line. Doug McIlroy, head of the Bell LabsComputing Sciences Research Center, and the inventor of Unix pipes, described the Unix philosophy as follows: "Write programs that do one thing and do it well. Write programs to work together. Write programs to handle text streams, because that is a universal interface."

Currently, the most commonly used utilities are those of the GNU project, which were created after the commercialization of UNIX. In most cases, they are richer in their capabilities and more complex parameters than the classic SYSV set of utilities that you see in commercial UNIXes.

On small embedded systems, you might see a system like 'busybox' that looks like a single binary with many faces built from a configurable modular library. It may look like a fully featured set of UNIX-style utilities, including a shell and a text editor. And during the build phase, you can choose exactly the features you need to reduce the size of the application.

All utilities and shells are built on top of software libraries. They can be dynamically or statically linked. In the first case, we have more flexibility for updates and customization and we get a set of applications that take up less disk/memory space in total. In the second case, we have a solid state application that is less dependent on the overall system configuration and can be more platform independent. And as I said earlier in the first case, you can use libraries with "viral licenses" (like the GPL) to write proprietary applications, but in the second case, you cannot.

***Under the hood -- MMU and shared libraries ***
