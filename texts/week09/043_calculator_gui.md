Well. Let's go back to the fifth example:
```
$ git checkout Example_5
Previous HEAD position was d7f58c6... Shell spec. symbols escaping and input formatting for 'expr'.
HEAD is now at f266a24... GUI
$ git diff d6453c0c41548a55e3249ea8c3b788c71cb76f7 Example_5 | less
...
```
Looks too long, but let's take a closer look -- actually added only the gdialog file:
```
$ ls
Makefile  README.md  calc  calc_ui  gdialog
```
This is not our development - it's just a GTK+ graphical analogue of the `dialog` text program. Our changes simply add an install command for `gdialog` if not already installed:
```
cat Makefile
```
and change four lines in `calc_ui`:
```
cat calc_ui
```
We first check for the existence of the `gdialog` program, and if it exists on our system, we set the DIALOG environment variable as `gdialog`, if not, we set it as `dialog`. And then just we replaced all the places where the `dialog` is used with the environment variable DIALOG.

OK. Install the new version:
```
$ sudo make install
[sudo] password for liveuser: 
install calc calc_ui /usr/local/bin
which gdialog >/dev/null 2>&1 || install gdialog /usr/local/bin
```
and start our script again:
```
$ calc_ui
```
It works. But remember, the only thing used to communicate between the XWindow server and the client is the DISPLAY environment variable:
```
$ echo $DISPLAY
:0
```
Let's unset it and try to run our UI again:
```
$ unset DISPLAY
$ calc_ui
```
Tadaam -- we've got a text interface again! Simply because the `gdialog` script automagically switches to the text `dialog` if we are working in text mode. Just reset DISPLAY and we get the GUI again:
```
$ export DISPLAY=:0
$ calc_ui
```
