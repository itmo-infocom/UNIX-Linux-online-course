Let's add some networking to our design:
```
$ git checkout Example_6
Previous HEAD position was f266a24... GUI
HEAD is now at d3e5228... Network server
$ git diff Example_5 Example_6
...
$ ls
Makefile  README.md  calc  calc.services  calc.xinetd  calc_ui  gdialog
```
As you can see, just two new files are calc.services and calc.xinetd. Because we will go the easy way - we will create a service for the xinetd superserver. As we recall, for this we just need a program that reads standard input and writes to standard output. And we also have such a program - this is our `calc` script!

To start our own network service, we just need to create the correct configuration for the xinetd server and we have to extend our `install` target in the Mnetcatakefile:
```
$ cat Makefile
...
```
We check the `/etc/services` configuration file for a `calc` service port definition and if it doesn't exist, add it:
```
$ cat calc.services
calc            1234/tcp
```
As we can see, we are configuring our service on TCP port 1234.

And finally we install calc xinetd config file a /etc/xinetd.d/calc:
```
$ sudo yum install xinetd
```
or in Ubuntu:
```
$ sudo apt install xinetd
```
and then:
```
$ sudo make install
install calc calc_ui /usr/local/bin
which gdialog >/dev/null 2>&1 || install gdialog /usr/local/bin
grep -q "`cat calc.services`" /etc/services || cat calc.services >> /etc/services
install calc.xinetd /etc/xinetd.d/calc
```
Let's restart `xinetd` after installing of our service:
```
$ sudo service xinetd restart
```
We can use `telnet` or the lighter `netcat` to test our server - this is the `nc` package on RH-like distributions:
```
$ sudo yum install nc
$ nc localhost 1234
Ncat: Connection refused.
```
or `netcat` on Ubuntu:
```
$ sudo apt install netcat
$ nc localhost 1234
$
```
Does not work... Let's understand the problem -- look in the system log. As we recall, we can find it in `/var/log/syslog` on Debian-based Ubuntu and `/var/log/messages` on RH-like systems. And on any `systemd` based system we can use `journalctl` for this:
```
$ sudo journalctl
...
... xinetd[4449]: Server /data/home/sadov/works/courses/calc is not executable 
... xinetd[4449]: Error parsing attribute server - DISABLING SERVICE [file=/et
```
Well. We found the root of the problem: this is another mistake of mine - I did not change my experimental "calc" script path to our standard "/usr/local/bin/calc". Let's fix it:
```
$ sudo vim /etc/xinetd.d/calc
...
        server          = /usr/local/bin/calc
...
```
And restart `xinetd` service:
```
$ sudo service   restart
```
Redirecting to /bin/systemctl restart xinetd.service
```
$ nc localhost 1234
2+3
5
^C
```
Great - we're in the network now!

