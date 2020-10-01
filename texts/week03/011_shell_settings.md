# Shell settings

The shell is customizable.

As you will see, most UNIX commands have very short names -- just two characters for the most common commands. This is because the developers wanted to shorten the printing time on TTYs, but are still very useful for the CLI work with nowadays. And we have a very useful tool for making shorter commands from long sentences -- it's called aliases:
```
alias ll='ls -al'
alias
```
Et voila - now you only have a two letter command that runs the longer command.

And you can 'unalias' this:
```
unalias ll
alias
```
But after logging out of the shell session or restarting the system, all these settings and variable settings will be lost.

But you can put these settings in init files. These are common shell scripts where you may setup what you want:

`/etc/profile` -- system defaults

Files for the first shell session that starts at login:
* Bourne shell: `~/.profile`
* Bash: `~/.bash_profile`
* С-Shell: `~/.login`

And initialization files for secondary shells:
* `/etc/bashrc` -- system defaults
* Bash: `~/.bashrc`
* С-Shell: `~/.cshrc`
