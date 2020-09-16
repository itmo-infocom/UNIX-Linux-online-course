## Disk space

Another important task with data in your file system is archiving and backing up. In case your file system is full, it's wise to look into your filesystems first to analyze disk usage. On many systems some graphical disk analysis program will run and you can detect problems visually. But we can also do this job using command line tools that can help you automate some of the admin tasks.

The main tool for reporting file system disk space usage is the `df` utility:
```
man df
```
The most useful option is "-h, --human-readable" for human readable print sizes in kilobytes, megabytes, gigabytes.

For a more accurate analysis, you can use the `du` utility to estimate the file space usage of directories and files:
```
man du
```
So, we can get the size of some directory:
```
# du -hs /tmp/
136K	/tmp/
```
And the most commonly used options are "-k", which displays sizes in kilobytes, and "-x", which means that it will scan only this file system and skip directories on other file systems. Let's take a look at an example of using the command line tools to find the largest directories and files:
```
$ du -kx /tmp | sort -rn | less
```
We examine the directory '/tmp', perform a numeric sorting of the sizes of directories and files, and redirect the result to the viewer `less` for analysis.

And after finding the largest files and directories, we can clean up our file system and before this archive and back up some data. The easiest way is to simply copy using the `cp -a` command to some external drive, or using `scp -rC` or `rsync -avz` to a remote host.

Also, using the `cp` or` scp` commands, you can copy any partition or the entire disk, because for us they are just files. But a more efficient way to do this is with the `dd` (disk dump) command:
```
man dd
```
By default, it just copies stdin to stdout, perhaps with some re-coding if we ask. But the most interesting options for us are: 'if' -- input file, 'of' -- output file, 'bs' -- block size, 'count', 'seek' and 'skip'. With a combination of these options, we can select the input and output files, choose the block size to increase speed of I/O, the number of blocks we want to copy, and seek/skip on output/input. Thus, we can cut and paste any fragment from one file or device to another.
 
We can also use the `od` (octal dump) command to low-level view of a file or device in different formats:
```
man od
```
For example -- let's look to our hard drive:
```
# od -bc /dev/sda1 | less
```

