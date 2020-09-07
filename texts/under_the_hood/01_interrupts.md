We talked about the kernel as some kind of magic program that loads at boot and keeps running while your computer is on. But what exactly does this program do? To understand this, we need to look at the evolution of software in computer systems. At the beginning, when they had just created computer programs, the question quickly arose - how to reuse what was written?

So, the well-known Pareto law works - when you need something new, most likely, it is already 80% written by someone, and you only need to complete or redo only 20%. You can of course use the good old "cut and paste" method, but this is often a source of errors and bugs, especially on large and complex systems.

To solve this problem, some of the most commonly used functions have been compiled into so-called software libraries, which are usually just archives of object files of such compiled programs. You can then link some of these object files to your executable and use functions developed and tested by others in your program.

But with the development of the computer industry and the widespread use of computer systems, the question arises about a more stable software core for working with external devices and system resources, for regulating access to them for programs and users. And the solution came in the form of interrupts.

What is it interrupt? Accordingly Dijkstra “It was a great invention, but also a Box of Pandora” (E.W. Dijkstra EWD 1303). A more formal interrupt is the processor's response to an event that requires attention from the software. Historically, interrupts were first created to solve problems detected by hardware, for example. arithmetic overflow implemented for UNIVAC I (1951).

Interrupts are widely used to handle arithmetic errors, improper memory access, and finally, to work with devices. Technically, interrupts are simply events that switch the processor from executing the current program to the execution of the so-called interrupt handler program, the address of which is placed in a special table placed in a fixed memory area - the table of interrupt vectors. For each type of interrupt, a special position in this table is used with the address of the corresponding handler program. When an interrupt request is generated, the processor saves the current state of the processor registers and switches the program counter to this handler. At the end of the handler program, a special machine instruction is executed -- the  exit from interrupt and the processor state before the interrupt was called is restored. 

But the real breakthrough came when software interrupts were invented. They were first implemented as a debugging feature called "transfer trapping" in the IBM 704 (1955). But gradually it became clear that this allows you to implement the functionality of the processor with a virtual instruction set. For example, we can only call one machine command to open a file. It must be a software interrupt command. 

There are different commands for different computer architectures: INT on Intel, SVC / SWI on ARM, TRAP on SPARC, etc. On the PDP 11, we had more than one software interrupt in the instruction set - EMT for DEC OS and SYS used by UNIX. But they all do only one thing - we jump to the vector interrupt and run the corresponding handler program.

Such a command from the programming API side looks like a function called "system call". And when we call such a function from our program, it looks like a single machine instruction in assembler, but it can run many other functions and interact with many system services. For example, when we execute the system call  "open a file" that is hosted on a network file server, we are actually searching in the file system tree by calling the VFS functions, redirecting to the corresponding network file system driver, sending network requests by the network TCP/IP stack drivers through a network device connected to the file server's network, interacting with the server side of the network file system on the server, viewing our file on the server's local file system using its own VFS, and then accessing it through the hard disk device driver that placed this file.

And in fact, all this black magic is done with a single command, which may look like a virtual command to "open a file" on your processor. In general, an OS is basically just a set of interrupt handlers that implement such a set of virtual instructions specific to this OS and interact with the hardware. For example, as we will see in the future, with a system timer to switch the processor context while a multitasking system is running.

https://people.cs.clemson.edu/~mark/interrupts.html
https://virtualirfan.com/history-of-interrupts


