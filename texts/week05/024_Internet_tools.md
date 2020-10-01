# Internet tools

OK. But what about modern Internet world?

The main problem with these classic `telnet` and `ftp` tools is insecurity: the user and password are transmitted over the network in plain text and can be hijacked by an evil hacker. Today they have practically been replaced by the Secure Shell utilities. Secure Shell provides secure, encrypted communication between untrusted hosts on an unsecured network. And again we have a remote Shell and transfer tool:
* ssh - SSH client (remote login program)
* scp - secure copy (remote file copy program)
```
man ssh
```
In ssh, you must specify the host and can set user and port. If you don't set a user, by default you will try to log in with the same name as the local user. Alternatively, you can add the command you want to run remotely directly to the command line, without that ssh will just start an interactive shell session on the remote host.

`scp` copies files between hosts on a network.  It uses the same authentication and provides the same security as ssh, also data transfer encrypted by ssh. You also may choose a port, you can use compression while transferring.

Secure Shell utilities can be configured for passwordless authentication using certificates.

## Internet data-transfer utilities

Finally, there are many tools that can be used to non-interactively access network resources in scripts.

The first is the `lynx` text web browser. With the "-dump" parameter, it dumps the text formatted output of the URL of the WEB resource to standard output. This output can then be used when processing the web page in a script.

Also we have non-interactive network downloaders -- `wget` and `curl`. These tools can be used to download and mirror online resources offline.
 
`lftp` -- sophisticated file transfer program with different access methods - FTP, FTPS, HTTP, HTTPS, HFTP, FISH, SFTP and file.

And finally `rsync` — remote (and local) file-copying tool which reduces the amount  of  data  sent over the network by sending only the differences between the source files and the existing files in the destination.  Rsync is widely used for backups and  mirroring and as an improved copy command for everyday use. There  are two different ways for rsync to contact a remote system: using a remote-shell program as the transport (such as ssh or rsh) or contacting an rsync daemon directly via TCP.

