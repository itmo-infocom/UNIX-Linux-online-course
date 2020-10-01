# Streams and numbers

As we remember, the connection between stdout and stderr looks like this:
```
prog 2>&1
```
What do these numbers mean? To understand this, we need to know one more thing -- the [file descriptor](https://en.wikipedia.org/wiki/File_descriptor).

In Unix and related computer operating systems, a file descriptor is an abstract indicator (handle) used to access a file or other input/output resource, such as a pipe or network socket. File descriptors form part of the POSIX application programming interface. A file descriptor is a non-negative integer, generally represented in the C programming language as the type integer (negative values being reserved to indicate "no value" or an error condition).

Every started process on a UNIX-like system has an associated open files table -- a table of file descriptors. Each Unix process (except perhaps a daemon) should expect to have three standard POSIX file descriptors, corresponding to the three [standard streams](https://en.wikipedia.org/wiki/Standard_streams):
* 0 -- stdin
* 1 -- stdout
* 2 -- stderr

and the [numbers are just positions in table of file descriptors](https://en.wikipedia.org/wiki/File_descriptor#/media/File:File_table_and_inode_table.svg).

On Linux, you can see this table for each process in the `/proc` filesystem, for example for the first process -- `init`:
```
$ sudo ls -l /proc/1/fd | less
...
```
As we can see, stdin and stdout are simply redirected to `/dev/null`, and stderr does not open.
