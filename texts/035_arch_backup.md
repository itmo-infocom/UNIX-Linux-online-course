## Archiving and backups

Historically the archiver, also known simply as `ar`, is a first Unix utility developed at 1971 in AT&T that maintains groups of files as a single archive file. Today, ar is generally used only to create and update static library files that the link editor or linker uses. An implementation of `ar` is included as one of the GNU Binutils.

But the most widely used archiving tools are `tar` and `cpio`.
 
The `tar` is a "tape archiver" originally developed in AT&T at end of 70s for storing data on magnetic tape. It saves many files together into a single tape or disk archive, and can restore individual files from the archive:
```
man tar
```
Basic operations with a tar archive:
* Create archive
* List files in archive
* and Extract files from archive

-v
-f

The GNU version also supports compressing / decompressing archives.

cpio - copy files to and from archives

dump/restore - ext2/3 filesystem backup/retore
