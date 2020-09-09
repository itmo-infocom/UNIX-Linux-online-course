## Searching
If we are talking about text data, finding some text is a common task. And in fact, these are two separate tasks - to find some text inside a file or text stream and to find a file, for example, by name in some directories.

For the first task, we have the `grep` utility which print lines matching a pattern.
```
man grep
```
Both fixed strings and regular expressions can be used as a pattern. Also you can do recursive search. 

Another commonly used command is `find` -- search for files in a directory hierarchy.
```
man find
```
You must set the starting point -- the directory to start the search or starting points if you are interested in several directories and expressions with search criteria and actions. You may search by name with using of standard shell matching patterns, by time of modification or access, by size, by user and group, by permissins, file type, etc. You can use logical operators such as "and", "or" and "not" in your expressions.

Also you can do some actions when you find something that matches the criteria. The default action is `print`. You can also use formatted printing, list of found files, delete them, and execute commands with them. In `exec` actions, you can use curly braces to insert the name of the found file. But keep in mind - you must end your command with a semicolon, and to avoid interpreting this Shell character, you must escape it with a 'slash'.

But the main drawback of `find` is the long execution time if you are looking in large deep directories. And to speed up this process, you can use the `locate` utility. It finds files by name from databases prepared by `updatedb` and does it incredibly fast. But you have to understand - `updatedb` is started automatically by the cron service at night. And if you only install the `lookup` toolkit or want to find something in the changed filesystem at this time - you have to update this database manually by running `updatedb`.

## Utilities for manipulation with a text data

Another operation that we often need is comparing files or directories. And we have some tools for this.
```
man cmp
```
The `Cmp` utility compares the two files byte-by-byte and reports the position from which we have a difference. By this way we can compare binaries.

To compare text files `diff` utility can be used:
```
man diff
```
We can compare files, directories with the `--recursive` option. We can get the output as a set of commands for the `ed` editor or the `patch` utility. This method of propagating changes was the first in the development of projects in the UNIX ecosystem and is still useful today.

Another important action with text data is sorting, and we have the `sort` utility which sort lines of text files:
```
man sort
```
To eliminate duplicate lines, we have the uniq utility, but first we have to sort our text stream:
```
sort file | uniq
```

We may output the first/last part of files by `head` and `tail` utilities. By default is the first or last 10 lines of standard input, or each FILE from arguments to standard output. You can set another number of lines as an option:
```
tail -15
```
Also in `tail` you can use the `--follow` option to display the appended data as the file grows.

More that,  from text lines you can cut some fields, separated by some kind of separators by `cut` utility.

Also you can join lines of two files on a common field by `join` utility and merge lines of files by `paste`.

And finally, we have `awk`, a scanning and templating language that can do this and other complex work on text files or streams.
