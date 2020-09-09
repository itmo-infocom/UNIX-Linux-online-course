## Archiving and backups

Historically the archiver, also known simply as `ar`, is a first Unix utility developed at 1971 in AT&T that maintains groups of files as a single archive file. Today, ar is generally used only to create and update static library files that the link editor or linker uses. An implementation of `ar` is included as one of the GNU Binutils.

But the most widely used archiving tools are `tar` and `cpio`.
 
The `tar` is a "tape archiver" originally developed in AT&T at end of 70s for storing data on magnetic tape. It saves many files together into a single tape or disk archive, and can restore individual files from the archive:
```
man tar
```
Basic operations with a tar archive:
* 'c' -- create archive
* 't' -- list files in archive
* and 'x' -- extract files from archive
Useful options:
* 'v' -- verbose
* 'f' -- file or device file with archive. "Dash" means standard input or output.
The GNU version also supports compressing/decompressing archives:
* -a, --auto-compress -- use archive suffix to determine the compression program
* -z, --gzip, --gunzip, --ungzip
* -Z, --compress, --uncompress
* -j, --bzip2
* -J, --xz
```
tar cvzf arch.tar.gz some_files...
tar tvzf arch.tar.gz
tar xvzf arch.tar.gz some_file
```
For standard UNIX `tar`, external compression / decompression programs should be used:
```
tar cvf - some_files... | gzip -c > arch.tar.gz
gunzip -c arch.tar.gz | tar tvf -
gunzip -c arch.tar.gz | tar xvf - some_file
```
The main problem with compressed archives is if you have corruption in the middle of the archive file, you will lose all content from the tail. Just because this format is focused on storing on tape and all the metadata about files stored sequentially, not in some central directory. And if you want to improve the reliability of your data, it makes sense to compress the files separately and put them in an uncompressed archive.

Another widely used archiving tool is `cpio`:
```
man cpio
```
Basic operations with it:
* -o|--create
* -t|--list: Print a table of contents of the input.
* -i|--extract
* also -p|--pass-through is so-called copy-pass mode, cpio copies files from one directory tree to another, combining  the  copy-out  and  copy-in steps  without  actually  using  an  archive.

Unlike `tar`, which works with files, `cpio` works with stdin/stdout.

This is good, but such an archive may contain some special fil es that are not properly processed. For example, you can get hard links split across multiple files. And for real backup in UNIX-like systems, special programs have been developed that know about the internal structure of the file system, for example:
* dump/restore - ext2/3/4 filesystem backup/retore.
* xfsdump/xfsrestore -- XFS filesystems backup/retore.
The main arguments are: the list of files and directories for dump and '-f dump_file'. But we can also choose the "dump level", which is just an integer. A level 0, full backup, specified by -0 guarantees the entire file system is copied. A level number above 0, is so-called "incremental backup", tells `dump` to copy all files new or modified since the last dump of a lower level. The default level is 0.
 
And this makes it possible to implement various "backup strategies". For example, you can create a full backup at the end of the week and then make incremental backups every day of the week. Then at the end of the week for new full backup, you can use the oldest backup storage from the full backup pool. This way, you will have weekly full backups for a specific period and daily saved states in incremental backups for a week or two.

And then you can extract the full dump or individual files or directories from the saved dump using the restore utility:
```
man restore
```
You can also do this interactively (-i).
