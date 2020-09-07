## Users and groups

As we remember, users are one of the three pillars on which the UNIX world stands.

You can use some graphical interfaces to manage users and groups, but simple CLI utilities are often more convenient. There are:
* adduser, useradd - create a new user or update default new user information
* groupadd - create a new group
* passwd - update user’s authentication tokens

To create a new user, we (as 'root') simply have to run the program `adduser` and set a password with` passwd`. But it's not over yet! 

Actually, adduser is also black magic - in fact, all data related to users and groups is placed in common text files that can only be modified with ordinary text editors:
```
less /etc/passwd
```
The file format is quite simple - one line per user with colon-separated fields:
```
$ man 5 passwd
```
The fields, in order from left to right, are:

1. User name: the string a user would type in when logging into the operating system: the logname. Must be unique across users listed in the file.
2. Information used to validate a user's password; And at the very beginning, the password data was actually placed in this field. But we can read this file as a regular user, this is a design requirement. Did users have the ability to read passwords of other users at this time? Not. In Robert Morris and Ken Thompson's classic article [“Password Security: A Case History”](https://rist.tech.cornell.edu/6431papers/MorrisThompson1979.pdf) about the UNIX password system, Morris described a real-life incident he himself saw:
```
Perhaps the most memorable such occasion occurred in the early 1960s when a system administrator on the CTSS system at MIT was editing the password file and another system administrator was editing the daily message that is printed on everyone’s terminal on login. Due to a software design error, the temporary editor files of the two users were interchanged and thus, for a time, the password file was printed on every terminal when it was logged in.
```
And the main idea of ​​UNIX passwords is not to believe that you can simply hide them. Better not to save passwords in the system at all. Actually, when creating a password, a random code was simply generated (the so-called SALT code), and then from this code and password by means of a one-way `crypt` procedure with the DES algorithm:
```
man crypt
```
And the result of this operation cannot be decrypted (actually, we received some kind of hash) -- when entering the system, the system receives SALT from the password field, encrypts it with the entered password, and simply compares it with the contents of the password field.

In most modern uses, this field is usually set to "x" (or "*", or some other indicator) with the actual password information being stored in a separate shadow password file. On Linux systems, setting this field to an asterisk ("*") is a common way to disable direct logins to an account while still preserving its name, while another possible value is "*NP*" which indicates to use an NIS server to obtain the password.[2] Without password shadowing in effect, this field would typically contain a cryptographic hash of the user's password (in combination with a salt).
3. User identifier number, used by the operating system for internal purposes. It need not be unique. Moreover, a superuser is simply a user with a zero user ID, and you can have multiple superusers in addition to the traditional “root” superuser. For example, you can create some superuser with UID 0 and a name like "halt" and with the command "shutdown" as a shell for the user, and provide a password for that user to anyone who needs to shutdown the system at night.
4. Group identifier number, which identifies the primary group of the user; all files that are created by this user may initially be accessible to this group. You can change this default during the current session with the command `newgrp`.
5. Gecos field, commentary that describes the person or account. Some early Unix systems at Bell Labs used GE/Honeywell mainframe computers with General Comprehensive Operating System (GCOS) for print spooling and various other services, so this field was added to carry information on a user's GECOS identity.
Typically, now this is a set of comma-separated values including the user's full name and contact details which may be used by some commands for example by mail user agent.
6. Path to the user's home directory.
7. Program that is started every time the user logs into the system. For an interactive user, this is usually one of the system's command line interpreters (shells). For example, for pseudo-users who do not need interactive sessions, this could be `nologin` or just `false` executables, which will exit immediately upon startup.

The description of the groups is also placed in a text file:
```
less /etc/group
```
In this file, we see a similar format:
```
man 5 group 
```
1. group_name -- the name of the group.
2. password -- Password field that has never been used
3. GID -- the numeric group ID.
4. user_list -- a list of the usernames that are members of this group, separated by commas.

Finally, a file with real data regarding passwords:
```
ls -l /etc/shadow
```
As we can see, only the superuser has access to this file. The transfer of password hashes from `/ etc / passwd` to this file was carried out to prevent brute-force attacks using modern computing equipment, which is now becoming cheaper and cheaper. And we can see the hashes of the passwords in the second field of the records for each user:
```
man 5 shadow
```
A password field which starts with an exclamation mark means that the password is locked. The rest of the characters in the string represent the password field before the password was locked, and you can simply remove the exclamation mark to unlock it.

[Under the hood -- special permission bits about `passwd` s-bit](under_the_hood/09_special_permission_bits.md)

On a multiuser system with many administrators, it is advisable to use the `vipw` and `vigr` commands to avoid conflicts when multiple administrators are editing the same file at the same time:
```
man vipw
```
This file-based machinery for handling of user accounts is not hardcoded. You can switch to network authentication services such as LDAP or Winbind using the setup utility:
```
setup
```
or simply by editing the text configuration file `/etc/nsswitch.conf`
```
less /etc/nsswitch.conf
```
Other security related settings on Linux systems can be done in the `/etc/security` and PAM configuration directories:
```
ls /etc/security/
ls /etc/pam.d/
```
As we can see, the UNIX system administration paradigm does not hide the details from the user, everything can be configured by hands or scripts. For beginners, such systems simply provide more or less user-firendly tools and wizards to lower the barrier to entry. 


