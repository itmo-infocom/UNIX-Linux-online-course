## File systems

And now that our partitioning is complete, it's time to see how we can use our disk space. As mentioned earlier, UNIX-like systems can treat disks or disk partitions as files. And some databases, for example, can use raw disk partitions to store data with higher performance.

But most of the time, disk space is used in file systems. UNIX-like systems and especially Linux support many different file systems. All the details of their implementation are reduced to a common denominator -- the VFS abstraction. Then we can mount them in a single directory tree, navigate through the hierarchy, read, write, work with owners and permissions, according to the restrictions imposed by the original file systems.

The standard tool for creating a new filesystem is `mkfs`:
```
man mkfs
```
We can choose the type of filesystem and some parameters to create. But it's actually just a wrapper around the real mkfs tools for different types of filesystems:
```
# ls /sbin/mkfs*
/sbin/mkfs        /sbin/mkfs.cramfs  /sbin/mkfs.ext3  /sbin/mkfs.fat    /sbin/mkfs.msdos  /sbin/mkfs.xfs
/sbin/mkfs.btrfs  /sbin/mkfs.ext2    /sbin/mkfs.ext4  /sbin/mkfs.minix  /sbin/mkfs.vfat
```
and they all support their own set of options:
```
# man mkfs.ext4
```
The most commonly used file systems in Linux right now are:
* EXT4 is the Linux journaling file system, or the Fourth Extended File System, which is the successor to the extended file system line originally created in 1992 by Rémy Card to overcome certain limitations of the MINIX file system. The ext4 filesystem can support files up to 16TB and volumes with sizes up to 1 exbibyte (EiB), but this may be limited for certain system versions. For example for RHEL 7/8 -- 50TB.

* XFS is a high performance 64-bit journaling file system created by Silicon Graphics, Inc (SGI) in 1993 for their UNIX called IRIX. Although XFS scales to exabytes, the host operating system limits can reduce this limit. For example - 500 TB for the maximum file size and file system size for RHEL7 and 1PB/8EB for RHEL8.

Typically ext4 provides better performance for small filesystems on machines with limited I/O capabilities, while XFS provides better performance for large filesystems on machines with high-performance parallel I/O. Also in XFS it is more difficult to reduce the size of the filesystem.

With the `mkfs` options, you can set various parameters for creating the filesystem, for example, optimize it for storing large files or for more smaller files.

Once the filesystem is created, we can "mount" it. In most cases, this happens automatically when you insert a flash drive or SD card into your computer. But in some cases it needs to be done manually, and you can do it by running the `mount` command.
```
man mount
```
You just need to specify the device and directory - mount point, and after mounting you will see the contents of the file system from this device or pseudo device in this directory. And also you can choose the "mount" options. For example, we can mount the ISO image with the `loop` option:
```
ls /mnt
mount -o loop ...iso /mnt
ls /mnt
```
And then we can `unmount` it:
```
umount /mnt
ls /mnt
```
 by setting the device or the mount directory as an argument:
```
man umount
```
But Linux/UNIX will not allow you to unmount a device that is busy. There are many reasons for this (such as program accessing partition or open file) , but the most important one is to prevent the data loss. You can use the `fuser` and `lsof` commands to find the processes that are loading your filesystems:
```
man fuser
...
-k, --kill
...
```
Finally, we can check our filesystem. For journaled file systems, recovering from a power outage is not as relevant, but in some cases it may be useful. In a difficult situation, such as a damaged hard disk, during system boot, you may receive an error message recommending that you run the `fsck` command to check the file system:
```
man fsck - check and repair a Linux file system
```
As we can see, we have many options for the `fsck` command, but the main one is 'y' -- 'yes'. This means - always try to fix any file system corruption you find automatically, otherwise you could get a zillion troubleshooting questions during the fixup.

After completing the repair, you can find some lost data in a special directory "/lost+found" in the root of the damaged filesystem, which consists of many directories and files whose names contain only numbers -- so called 'i-nodes'.

And then you can rename them manually - for example, you found some directory with the files:
* 'passwd', 'group' and 'shadow' - this means that this is '/etc'
* or 'sh', 'ls' and 'cp' -- this means '/bin'
and so on...

## Swapping

And finally, a few words about swapping. Swapping or  paging is a memory management scheme by which a computer stores and retrieves data from secondary storage for use in main memory. It is an MMU-driven virtual memory mechanism that is used in modern operating systems to use secondary storage in order for programs to exceed the amount of available physical memory.

[Under the Hood -- Virtual Memory](under_the_hood/virtual_memory.md)

This means you can run applications with a total memory usage that exceeds the physical RAM on your system. The scheduler sends inactive processes to disk swap and loads active tasks from disk into memory. This can reduce overall system performance, but it will increase the ability to run applications.

The main program for creating of swapping area is `mkswap`:
```
man mkswap
```
You just need to specify the device as an argument. Or a file if you need temporary swap space like Microsoft does on Windows.

Then you can enable swap space with the command `swapon`:
```
man swapon
```
After that, you will see additional swap space using the `free` command or in the pseudo file `/proc/meminfo`. You can also turn off the swap area with the `swapoff` command.

OK. But all these mounts and swaps will be connected to our system only until the reboot. To automatically mount them at boot time, we must write them to the filesystems table in the file `/etc/fstab`:
```
cat /etc/fstab
```
In this text file, we can place static information about connecting file systems and enabling swapping areas:
```
man fstab
```
Each  filesystem  is  described on a separate line; fields on each line are separated by tabs or spaces.
* The first field (fs_spec) describes the block special device or remote filesystem to be mounted.
*  The second field (fs_file) describes the mount point for the filesystem.  For swap partitions, this field should be specified as `none'.
* The third field (fs_vfstype) describes the type of the filesystem. An entry `swap` denotes a file or partition to be used for swapping.
* The fourth field (fs_mntops) describes the mount options associated with the filesystem.
* The fifth field (fs_freq) is used for these filesystems by the dump command to determine which filesystems  need  to be backuped.
* The sixth field (fs_passno) is used by the fsck(8) program to determine the order in which filesystem checks are done at reboot  time.

After putting some entry in the fstab file, you can run the `mount` command with only one of them: device or mount point.

