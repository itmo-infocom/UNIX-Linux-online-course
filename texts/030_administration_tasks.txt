## UNIX/Linux administration

By installing the system on your computer, you become more or less an administrator and you need to have some basic administration skills. The most important tasks:
* Users and groups management;
* Working with repositories and packages;
* Devices and drivers handling;
* File systems configuring;
* Archiving and backups;
* Network administration.

Typically, system administration in different UNIX-like systems is the most different part of the system, although the general approaches to administration are more or less the same everywhere. On some systems, you have tools that can help you perform some of the adminisconsolehelpertrative tasks. For example:
* gnome-control-center in systems with GNOME UI
* RHEL: simple text config -- setup, GUI-configs -- system-config-*
* commercial systems provide their own more or less administrator-friendly tools

As we understand it, we need superuser rights to perform such tasks. Some systems may require stricter restrictions where system administration tasks can be decoupled from those of a security officer using mandatory access control (MAC) systems, such as those developed by the National Security Agency (NSA) SELinux subsystem in the Linux kernel.

Let's take a look at the RH `setup` tool:
```
$ setup
You are attempting to run "setup" which requires administrative
privileges, but more information is needed in order to do so.
Authenticating as "root"
Password: 
```
We have to enter the root password and after that we can do some settings:
* Authentication configuration 
* Keyboard configuration
* System services 

But when we run `system-config-date`, the system asks for the user's password. This is because these programs use different machinery for increasing privileges:
```
$ ls -l /usr/bin/setup
lrwxrwxrwx. 1 root root 13 Nov  9  2019 /usr/bin/setup -> consolehelper
```
The setup program is just a symbolic link to `consolehelper`, a tool that allows console users to easily run system programs. And the pkexec runner is used to execute `system-config-date`:
```
$ cat /usr/bin/system-config-date 
#!/bin/sh

exec /usr/bin/pkexec /usr/share/system-config-date/system-config-date.py
```
A more general way is to just switch to the `root` superuser, and the first way to do this is with the su command:
```
man su
```
su - run a command with substitute user and group ID, bu default -- to 'root' superuser. For such a switch, we need to say the password of this user. When called without arguments `su` defaults to running an interactive shell as 'root'. A very important option is just a 'dash', it's mean -- starts the shell as login shell with an environment similar to a real login.

After switching to superuser "root" your prompt will change from a dollar sign to a hash sign:
```
$ id
...
$ su -
Password: 
# id
...
# logname
...
```

On BSD systems, for security reasons, only users in the 'wheel' group (group 0) can use `su` as 'root', even with the 'root' password. In many UNIXes and Linux the Plugin Authentication Module (PAM) is now being used to fine tune the privilege change. The settings for this subsystem are located in the /etc/pam.d/ directory.
```
$ ls /etc/pam.d/
```
And one of the applications whose config files we can find in this directory is the `sudo` command. The default PAM security policy allows users configured appropriately in '/etc/sudoers' to run commands with 'root' privileges. And you don't need to know the password of 'root' user to do this.

Also, by default only one command is executed with `sudo`, instead of `su` where we have to use the '-c' option to run one command. This reduces the chances of an unexpected error for an inexperienced user. And this is, for example, the default policy for Ubuntu systems. When Ubuntu is installed, a standard root account is created, but no password is assigned to it. You cannot log in as root until you assign a password for the root account. Only `sudo` may be used with such default settings.

To allow a regular user to run `sudo` this way on RH based systems such as Fedora, RHEL, CentOS, our NauLinux, you must add this user to the 'wheel' group (as in BSD). And the easiest way to get a 'root' shell session like in `su` with` sudo` in Ubuntu is to just run it `sudo -i` (interactive).




