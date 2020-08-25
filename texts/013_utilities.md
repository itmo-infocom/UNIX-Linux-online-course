All commands typed on the command line or executed in a command file are either commands built into the interpreter or external executable files. The set of built-in commands is quite small, which is determined by the basic concept of UNIX - the system should consist of small programs that perform fairly simple well-defined functions that communicate with each other via a standard interface.

A rich set of standard utilities is a good old tradition for UNIX-like systems. The shell and the traditional set of UNIX utilities, is a POSIX standard.

As we discussed earlier, we have different branches of development of UNIX-like systems with different types of utilities:
* BSD-like dating back to the original UNIX implementations;
* SYSV based systems;
* GNU utilities.

Some command syntax was changed by the USL with the introduction of SYSV, but on most commercial UNIX a set of older commands was still included for compatibility with earlier BSD-based versions of UNIX from the same vendor. GNU utilities often combine both syntaxes and add their own enhancements to traditional utilities. And now the GNU toolkit has become the de facto standard.

Executable files on UNIX-like systems do not have any file name extension requirements as they do on Windows. The utility executable can have any name, but must have execute permission for the user who wants to run it.

A standard utility can have options, argument of options, and operands. Command line arguments of programs are mainly parsed by the getopt() function, which actually determines the form of the parameters when the command is invoked. This is an example of utility's synopsys description:
```
utility_name[-a][-b][-c option_argument] [-d|-e][-f[option_argument]][operand...]
```
1. The utility in the example is named utility_name. It is followed by options, option-arguments, and operands. The arguments that consist of <hyphen-minus> characters and single letters or digits, such as 'a', are known as "options" (or, historically, "flags"). Certain options are followed by an "option-argument", as shown with [-c option_argument]. The arguments following the last options and option-arguments are named "operands".

The GNU getopt() function supports so-called long parameters, which start with two dashes and can use the full or abbreviated parameter name:
```
utility_name --help
```

2. Option-arguments are shown separated from their options by <blank> characters, except when the option-argument is enclosed in the '[' and ']' notation to indicate that it is optional.

In GNU getopt's long options also may be used the 'equal' sign between option and option-argument:
```
utility_name --option argument --option=argument
```

3. When a utility has only a few permissible options, they are sometimes shown individually, as in the example. Utilities with many flags generally show all of the individual flags (that do not take option-arguments) grouped, as in:
```
utility_name [-abcDxyz][-p arg][operand]
```
Utilities with very complex arguments may be shown as follows:
```
utility_name [options][operands]
```
4. Arguments or option-arguments enclosed in the '[' and ']' notation are optional and can be omitted. Conforming applications shall not include the '[' and ']' symbols in data submitted to the utility.

5. Arguments separated by the '|' ( <vertical-line>) bar notation are mutually-exclusive.
```
utility_name [-a|b] [operand...]
```
Alternatively, mutually-exclusive options and operands may be listed with multiple synopsis lines.
For example:
```
utility_name [-a] [-b] [operand...]
utility_name [-a] [-c option_argument] [operand...]
```
6. Ellipses ( "..." ) are used to denote that one or more occurrences of an operand are allowed.
