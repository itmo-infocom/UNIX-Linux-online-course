## Traditional network utilities

In the world of TCP/IP Network, other programs have been developed that are still relevant in some cases, classical Internet programs:
* telnet - user interface to the TELNET protocol
* ftp - ARPANET file transfer program
* mail - send and receive mail
Again we have a tool for remote execution and a tool for data transfer.

Generally, telnet just gives us a connection to the TELNET protocol server:
```
man telnet
```
It's just a CLI for another host and this protocol still used for access to some hardware devices. Moreover, you can use it for debugging by connecting to other servers by choosing of TCP server's port. On modern systems, you can use the lighter 'nc' utility, netcat. For example let's try to play with HTTP protocol:
```
$ telnet google.com 80
Trying 173.194.73.101...
Connected to google.com.
Escape character is '^]'.
GET /index.html HTTP/1.1
```
To switch to telnet command mode, press the "Ctrl-]" key. Here we can ask for help and exit, for example, if the program on the other side is frozen:
```
telnet> h
Commands may be abbreviated.  Commands are:

close   	close current connection
logout  	forcibly logout remote user and close the connection
display 	display operating parameters
mode    	try to enter line or character mode ('mode ?' for more)
open    	connect to a site
quit    	exit telnet
send    	transmit special characters ('send ?' for more)
set     	set operating parameters ('set ?' for more)
unset   	unset operating parameters ('unset ?' for more)
status  	print status information
toggle  	toggle operating parameters ('toggle ?' for more)
slc     	set treatment of special characters

z       	suspend telnet
environ 	change environment variables ('environ ?' for more)
telnet> q
Connection closed.
```

FTP or File Transfer Protocol is another well-known part of the networked world of the Internet. It is still supported by some internet servers and is also built into some devices. We can access the FTP server through a regular web browser as well as through the ftp utility:
```
man ftp
```
In some cases, the latter variant is preferable, because, for example, we may want to restore a file or upload/download many files. First, we have to log into the FTP server. Let's try to do this as an anonymous user:
```
$ ftp ftp.funet.fi
Name (ftp.funet.fi:user): ftp
331 Any password will work
Password:
```
In this case any password will work, but often FTP-server wait email address as a password.

FTP has its own command line interface where we can ask for help:
```
ftp> ?
Commands may be abbreviated.  Commands are:

!		dir		mdelete		qc		site
$		disconnect	mdir		sendport	size
account		exit		mget		put		status
append		form		mkdir		pwd		struct
ascii		get		mls		quit		system
bell		glob		mode		quote		sunique
binary		hash		modtime		recv		tenex
bye		help		mput		reget		tick
case		idle		newer		rstatus		trace
cd		image		nmap		rhelp		type
cdup		ipany		nlist		rename		user
chmod		ipv4		ntrans		reset		umask
close		ipv6		open		restart		verbose
cr		lcd		prompt		rmdir		?
delete		ls		passive		runique
debug		macdef		proxy		send
ftp> 
```
We can first determine our current directory, and as we understand it, we have two current directories: remote and local. We can get the remote directory with the standard `pwd` command. To get the current local directory we can use the same command preceded by an exclamation mark. This means - call this command on the local computer. You may change directory remotely by `cd` and local directory by `lcd`.

We can get a list of remote directoriy using the well-known `ls` command. And what about local `ls`? Yes -- just preced it by an exclamation mark. This means - run the program locally. If you have sufficient permissions, you can download file by `get` command and upload by `put`, but only a single file. If you want to work with multiple files, you will need to use the `mget`/`mput` commands.

In this case, it makes sense to disable the questions about confirming operations using the `prompt` command. Also switching to binary mode using the `bin` command can be important for the Microsoft client system. Otherwise, you may receive a corrupted file.

Finally, you can use the `reget` command to try to continue downloading the file after an interrupted transfer. And the `hash` command toggle the 'hash' printing for each transmitted data block, which can be informative if the connection to the server is poor.

Another useful scripting program is `mail`, which is a simple command line client for sending email:
```
$ mail user@localhost
Subject: test
This is a test!
.
```
The mail message must end with one 'dot' per line.

