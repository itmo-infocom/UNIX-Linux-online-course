# Special symbols

In addition to the "dollar" sign, which was used to retrieve a value from a variable by name, we have seen some other special characters earlier: "space" and "tab" as word separators, "hash" as a line comment. We also have many other special characters.

"Newline" and "semicolon" are command separators.

The "ampersand" can also look like a command separator. But if you use this sign, the command written before it will run in the background (that is, asynchronously as a separate process), so the next command does not wait for completion.

"Double quote"d string means partial quoting. This disables the interpretation of word separator characters within STRING - the entire string with spaces appears as one parameter to the command.

"Single quote"d string interpreted as a full quoting. Such quoting preserves all special characters within STRING. This is a stronger form of quoting than double quoting.

"Backslash" is a quoting for single characters.

The "backquotes" indicates command substitution. This construct makes the output of the command available as part of the command line. For example to assign to a variable. In POSIX-compliant environments, another form of command ("dollar" and "round brackets") can be used.

And in the special characters of the shell, we can see some of the characters that we will see in the regular expressions. They are used to compose a query to find text data. It is a very important part of the UNIX culture, borrowed by many programming languages to form such search patterns. These are "asterisk" and a "question" signs.

"Asterisk" used when a filename is expected. It matches any filename except those starting with a "dot" (or any part of a filename, except the initial "dot").

"Question" symbol used when a filename is expected, it matches any single character.

The set of characters in "square brackets" means -- any of this set. The same with an "exclamation" sign - none of this set.
