Core dump consists of the recorded state of the working memory of a computer program at a specific time, generally when the program has crashed or otherwise terminated abnormally. The name comes from [magnetic core memory](https://en.wikipedia.org/wiki/Magnetic-core_memory), the principal form of random access memory from the 1950s to the 1970s. The name has remained long after magnetic core technology became obsolete.

Modern operating systems typically generate a file containing an image of the memory belonging to the crashed process, or the memory images of parts of the address space related to that process, along with other information such as the values of processor registers, program counter, system flags, and other information useful in determining the root cause of the crash. These files can be viewed as text, printed, or analysed with specialised tools such as elfdump on Unix and Unix-like systems, objdump and kdump on Linux. 

Interesting use case for core-dump is initialization of the TeX typesetting system. On old computers from the 70s it took a long time to interpret TeX package macros, and Donald Knuth, the creator of TeX, just developed a mechanism that would core dump the `initex` program after this interpretation. And then it just needs to undump the core dump by downloading directly to memory an running to execution. By this way we get the interpreted packages immediately. [Discussion about `undump`](https://news.ycombinator.com/item?id=13073566)

And the most common use of a core dump is to view the debugger failure state, or for example a frozen state, from which we core dumping the application with C-\ keystroke or the SIGQUIT signal. This analysis can be very useful for embedded systems where interactive debugging may not be available.

By default, core dump is disabled on most systems. But you can use the `ulimit` command in `bash`:
```
$ ulimit -c
0
```
This means disabling the core dump. And we may enable it:
```
$ ulimit -c unlimited
$ ulimit -c
unlimited
```
Also in Linux we have system wide config `/etc/security/limits.conf` in which we may set hard and soft limits for user and groups, including the limits for core dump size:
```
$ cat /etc/security/limits.conf
$ man limits.conf
```

