# Calculator's network enabled UI

Ok, we have a working network service, and it's time to change our user interface to network communication with it.
```
$ git checkout Example_7
$ git diff Example_6 Example_7 | less
```
The main changes are made in the `calc_ui` script. At the beginning of the script, as you can see, added some default definitions: HOST, PORT for calc-server connection and CALC script name.

Then we can see added support for configuration files. First, we check the user's personal configuration in the home directory -- this is a hidden file starting with a "dot" calc.conf. If such a file exists, we load it as a Shell library file. If we do not find this file, we check the system-wide configuration `/etc/calc.conf` and load it if it exists. You can put your own connection variable definitions in these files.

We see a new `help` function for displaying a help message and some logic for processing script parameters. We now handle the `--help` parameter and the optional host/port positional parameters. As we can see, we can only set the host or both the host and port using the script arguments.

And finally -- we check the name of the script by stripping it with the `basename` function from the current path to the script. If the script is called `ncalc_ui`, we change the CALC variable to `netcat` with the host access parameters. If such parameters are not specified, we display an error message. In the line where we called the `calc` script, we replace it with the CALC variable.

That's it -- we just changed the UI file without changing the main logic. Let's install it:
```
$ sudo make install
[sudo] password for liveuser: 
install calc calc_ui /usr/local/bin
which gdialog >/dev/null 2>&1 || install gdialog /usr/local/bin
grep -q "`cat calc.services`" /etc/services || cat calc.services >> /etc/services
install calc.xinetd /etc/xinetd.d/calc
ln -s /usr/local/bin/calc_ui /usr/local/bin/ncalc_ui
```
As we can see, there is a symbolic link from `calc_ui` to `ncalc_ui`.

OK. Let's test it:
```
$ ncalc_ui 
```
It works! But maybe we're wrong and this is just our old local calculator? Let's check by stoping the `xinetd` service:
```
# systemctl stop xinetd
```
Our calculation ended with an error. And what about a non-networked `calc_ui`?
```
$ calc_ui 
```
Still works. Let's run `xinetd` again:
```
# systemctl start xinetd
```
Networked `ncalc_ui` works again! Quod erat demonstrandum -- the networked version of the calculator created!
