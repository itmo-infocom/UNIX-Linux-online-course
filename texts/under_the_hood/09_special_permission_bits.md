As we recall, we have the passwd utility that any user can call to change the password. But on the other hand, we did not have permissions not only to write to the file in which the password hashes are `/etc/shadow`, but also to read. How can a simple user change his password?

And on UNIX-like systems, there is a special trick for this. Let's take a look at the permissions of the `passwd` utility:
```
$ ls -l /bin/passwd 
-rwsr-xr-x 1 root root 68208 May 28 09:37 /bin/passwd
```
At the place of execution permissions for the owner, we see the letter 's' instead of 'x'. Actually it is just a special kind of executable permission that can be set for owner and group. But when we run such files, our initial UID or GID is changed to the UID or GID of the file. The process will start with a new effective UID or GID equal to the file parameter.

And if we run the `passwd` command, we become the` root` user while this program is running. In this state, we can read and write to `/etc/shadow`. We can set or disable suid and sgid in symbolic mode using the 's' character. In the [binary mode](under_the_hood/octal_mode.md) of the file, it looks like this:
```
$ stat -c "%a %A %n" /bin/passwd 
4755 -rwsr-xr-x /bin/passwd
$ stat -c "%a %A %n" /bin/crontab 
2755 -rwxr-sr-x /bin/crontab
```

Another question -- do you have any ideas about the implementation of the `ps` utility? Actually it seems pretty simple - we just need to open the special file '/dev/mem', read the current process table from it and print it to stdout. But for this we do not have permission to read memory:
```
$ ls -l /dev/mem
crw-r----- 1 root kmem 1, 1 Sep  1 21:39 /dev/mem
```
And in the beginning the `ps` utility had the `s` bit for such reading. But what about today?
```
$ ls -l /bin/ps
-rwxr-xr-x 1 root root 137688 Feb 27  2020 /bin/ps
```
We don't have a setuid bit right now. Why? Because on most UNIX-like systems we have a special `/proc` filesystem, which is just a rabbit hole for the kernel. It was implemented by [Tom J. Killian for UNIX 8th Edition in 1984](https://lucasvr.gobolinux.org/etc/Killian84-Procfs-USENIX.pdf). All processes can be seen as subdirectories in the `/proc` directory. All processes can be thought of as subdirectories in `/proc`, and we do not need the suid bit to read process-related data from them.

Such a complex revision of the system kernel brings us `ps` without the suid bit, which is not so little. Because every bit of 'suid' is a potential hole in our security, and it is the daily job of the sysadmin to look for new 's' bits in executable files by this way:
```
$ find /bin /sbin/ -perm /4000 # for SUID
$ find /bin /sbin/ -perm /2000 # for SGID
$ find /bin /sbin/ -perm /6000 # for both of them
```
For automatic daily monitoring of such a task, the `logwatch` utility may be useful.

Finally, the first bit of special permissions is a sticky bit. Let's take a look at the permissions for temporary files directory -- `/tmp`:
```
$ ls -l /
...
drwxrwxrwt  25 root root      20480 Sep  6 21:23 tmp
...
```
So we can see the executable permissions for the owner and group. By the way, what does "executable" mean for a directory? Strange, but this permission means - you can change to this directory, for example, with the command `cd`. And file permission 1000 or 't' in character mode means - only the owner of something can delete it in a directory with this bit. Otherwise, although in a publicly accessible `/ tmp` directory, we cannot modify files or directories owned by others if we do not have such permissions, but we can delete them, because everyone has all the permissions to changing of that directory.

