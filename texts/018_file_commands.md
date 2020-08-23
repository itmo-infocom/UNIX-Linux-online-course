UNIX tools support a standard set of commands for working with files and directories:

* ls - list directory contents. Let's look in `man ls`. We can simply specify files and directories as arguments and view the listing in different ways according to the options.

Ok, let's take a look at our current directory -- it's just `ls` without arguments. As we remember, after logging in, this is the home directory.
```
ls
```
We see some directories, but we don't see, for example, shell startup files. No problem, let's run:
```
ls -a
```
We can see the shell startup files and more - the directories "point" (current) and "double point" (top level) are also visible. Because that means "all" files and directories, including hidden ones. Hidden files in UNIX are just a naming convention - names must begin with a period. It is not an attribute as it is on Microsoft systems. Initially it was just a trick in the `ls` utility to hide the current and top directories, and then it came to be used as a naming convention to hide any file or directory.

Also we can see directory listing recursively:
```
ls -R
```
Another very important option is the "long list":
```
ls -l
```
We see a table with information about the file / directory in the corresponding lines.
- The first column is the file attribute. The first letter is the file type: "dash" is a regular file, "d" is a directory, and so on. Then we can see read, write, and execute permissions for three user groups: owner, owner group, and everyone else. Once again, we see the difference between UNIX and Microsoft. In the first case it is an attribute, in the second case executability is just a naming convention: '.com', '.exe', '.bat'.
- Some mystery column that we will discuss later.
- Then we can see owner and owner group, size of file, time of modification and the name of file. 

* pwd - print name of current/working directory
* cd – change directory. Without arguments -- to home firectory.
* cp - copy files and directories. Most interesting option is '-a|--archive' with create recursive archive copy with preserving of permissions, timestamps, etc... 
* mv - move (rename) files and directories.
* rm - remove files or directories.
```
rm -rf ...
```
means recursive delete without asking for confirmation.
* mkdir - make directories. If any parent directory does not exist, you will receive an error message:
```
mkdir a/b/c
mkdir: cannot create directory 'a/b/c': No such file or directory
```
To avoid this, use the -p option:
```
mkdir -p a/b/c
```
* rmdir - remove empty directories. If directory is not empty, you will receive an error message. Nowadays, running 'rm -rf something...' is sufficient in this case. But in the old days, when 'rm' did not have a recursive option, to clean up non-empty directories, you had to create a shell script with 'rm's in each subdirectory and the corresponding 'rmdir's.


* ln - make links between files. Links are a very specific file type in UNIX and we will discuss them in more detail. If we look at the man page for the 'ln' command, we see a command very similar to 'cp'. But let's take a closer look:
```
cat > a
ln -s a b
ln a c
cat b; cat c
```
At the moment everything looks like a regular copy of the file, but let's try to change something in the one of them:
```
cat >> c
cat a; cat b
```
Wow, all the other linked files have changed too! We are just looking at the same file from different points, and changing one of them will change all the others. And in this they all seem to be alike. But let's try to delete the original file:
```
rm a
cat b; cat c
```
In the first case, we can still see the contents of the original file, but in the second case, we see an error message. Simply because the first is a so-called hard link and the second is symbolic. We can see the difference between the two in the long ls list:
```
ls ?
```
And we can restore access to the content for the symbolic link by simply recreating the original file:
```
ln b a
cat c
```
Another difference between them is the impossibility of creating a hard link between different file systems and the possibility of such a linking for soft links. For more details on internal linking details, see the corresponding ["Under the Hood"](under_the_hood/links.md) lecture.

##Permissions

And finally, let's discuss file permissions. As we remember, we have the owner user, the owner group and all the others, as well as read, write and execute permissions for such user classes. And we have the appropriate command to change these permissions:
```
chmod [-R] [ugoa][-+=](rwx) 
```
And as we understand it, permissions are just a bit field. As far as we understand, permissions are just a bitfield and in some cases it might be more useful to set them in octal mode - see ["Under the Hood"](under_the_hood/octal_mode.md) for information on this.

You can also change the owner and group for a file or directory by command `chown`. 
```
man chown - change file owner and group
```
But keep in mind - for security reasons, only a privileged user (superuser root) can change the owner of a file. The common owner of a file can change the group of a file to any group that owner is a member of:
```
chown :group file...
chgrp group file...
```
