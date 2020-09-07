To understand what these hard and soft links are, we need a brief introduction to the file system structure of UNIX-like systems. We have many different file systems on UNIX-like systems. But the basic idea of the UNIX filesystem has remained unchanged from the very beginning of PDP7.

Typically, we can have a boot block at the beginning of a device or filesystem partition, then we have a so-called superblock with filesystem metadata, and then a data space with data blocks that make up the files.

The superblock is a very "high level" metadata structure for the filesystem, and is very important for the filesystem. And if the superblock of the partition is damaged, the corresponding file system cannot be mounted by the operating system. Therefore, it is saved in multiple backups for each file system.

The superblock includes some information about the file system as a whole and some tables, such as a list of free data blocks, possibly a list of bad blocks, and finally a list of i-nodes. Each i-node (or index-node) describes a separate file. It includes metadata related to the file, such as ownership, access mode (read, write, execute), and file type and size. But i-node also includes a list of physical blocks holding the files content.

The size of the blocks supporting a single i-node is fixed and, when combined with the data block size, determines the maximum file size on that file system. When you create some filesystems, you can change the size of the i-node list and the size of the data block, and use these options to configure the filesystem to handle fewer larger files or more smaller files.

And about directories -- it's just a special kind of file that contains a sequence of names and their associated i-nodes. We can have multiple directory entries associated with one i-node and this is called a hard link. We can see this with the `ls` command:
```
$ touch 1
$ ln 1 2
$ ls -i
50069589 1  50069589 2
```
As we remember, changing any of the related files changes the other file synchronously. But this is interesting -- the mode change also occurs synchronously for both files:
```
$ ls -l
total 0
-rw-rw-r-- 2 user user 0 Sep  4 20:02 1
-rw-rw-r-- 2 user user 0 Sep  4 20:02 2
$ chmod 777 2
$ ls -l
total 0
-rwxrwxrwx 2 user user 0 Sep  4 20:02 1
-rwxrwxrwx 2 user user 0 Sep  4 20:02 2
```
Just because the file metadata is located in the i-node. Also, the i-node has a file link counter. And in the UNIX API, we don't have something like the `delete` system call -- just `unlink`. And when we call the `rm` command, we just doing `unlink` and decrement the link count. Only when the link count reaches zero are the data blocks associated with the file moved to the free blocks list.

It looks good, but unfortunately we cannot establish hard links between different file systems, because it would be too difficult to synchronize the metadata of these file systems. And for that, a soft or symbolic link was designed in 4.2BSD. What is it? Let's look:
```
$ ln -s 1 3
$ ls -l
total 0
-rwxrwxrwx 2 user user 0 Sep  4 20:02 1
-rwxrwxrwx 2 user user 0 Sep  4 20:02 2
lrwxrwxrwx 1 user user 1 Sep  4 20:15 3 -> 1
```
As we can see, this is just a special type of file, and we can see the length of 1 instead of the zero size of the hard-linked files. And this means only one thing - a line with the path to the linked file is simply placed in this special file. As a consequence, we have no restrictions on linking between file systems. But if we delete the original file, we will lose access to it via the soft link.
