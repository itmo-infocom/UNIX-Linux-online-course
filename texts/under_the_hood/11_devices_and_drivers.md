## Devices and drivers

A few words about devices and drivers. In the classic Unix driver model, devices belong to one of three categories: character devices, block devices and network devices  associated driver types. Under Unix, drivers are code units linked into the kernel that run in privileged kernel mode. Generally, driver code runs on behalf of a user-mode application. Access to Unix drivers from user-mode applications is provided via the file system. In other words, devices appear to the applications as special device files that can be opened.

In the beginning, all drivers were built into a monolithic kernel, and every change in a set of devices required a rebuild of the kernel. Then a mechanism for dynamically loading device drivers was developed, which made reconfiguration possible with support for dynamically changing a set of devices. Nowadays, almost all modern systems support this machinery -- we just need to install a package with a new device driver and this device will be supported by the system immediately.

As we remember, we can access the device via a pseudo-file in the '/dev' directory. And these files will be special files:
```
$ ls -l /dev/null 
crw-rw-rw-. 1 root root 1, 3 Aug 28 19:06 /dev/null
$ ls -l /dev/sda  
brw-rw----. 1 root disk 8, 0 Aug 28 19:06 /dev/sda
```
We see this in the first character of the permissions field:
* 'c' -- stands for character device
* 'b' -- for block

We can work with both of them as with files, but on block device a file system can be created. What about file size? In place of the "size" we see two strange numbers that have nothing to do with, for example, the actual size of the device. To understand the meaning of these numbers, we must take a quick look at the organization of the device subsystem in a UNIX-like kernel.

From the very beginning, drivers in the UNIX kernel were placed in two special tables, `cdevsw` and `bdevsw` -- character and block device switches. These tables have a separate row for each device driver. And the first number of two (the so-called "major number") is just a position in this table. Each driver places the initial entry points for standard file functions in its own table row: `open`, `close`, `read`, `write`, `seek` and everything that did not fit into these functions - into the `ioctl` (I/O control) function. To write a new driver, you just need to implement such functions for your device.

OK. But what about the second number -- the so-called "minor number"? Let's take a look at the '/dev' directory again:
```
$ ls -l /dev/zero 
crw-rw-rw-. 1 root root 1, 5 Aug 28 19:06 /dev/zero
$ ls -l /dev/mem 
crw-r-----. 1 root kmem 1, 1 Aug 28 19:06 /dev/mem
```
It looks interesting -- we have the same "major" number for all devices '/dev/null', '/dev/zero' and even '/dev/mem'. This means that they are all handled by the same driver. And one more thing:
```
$ ls -l /dev/sd*
```
As we can see, all hard disks with all partitions are also handled by one driver. There is only one difference between these files: the "minor" number. And this is just a parameter that is passed to the driver. By this minor number, the driver understands which device we need -- '/dev/null', '/dev/zero' or '/dev/mem'", or what hard disk or partition we are working with.

In the old days, device special files in the '/dev' directory were created by the `mknod` utility in the MAKEDEV script with fixed major and minor numbers. Today, all device files are created automatically on the special device's file system.

But the `mknod` utility can be useful in some cases:
```
man mknod
```
As we can see, we can create special files by choosing the device type: "c" for a character and "b" for block devices. But we also have a very special file type 'p' for so called "named pipes". We can use it as shell's channels for interprocess communication:
```
$ mknod /tmp/p p
$ cat > /tmp/p
qwe
123
^D
$ cat /tmp/p
qwe
123
```

