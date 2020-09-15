## X-Window concepts

The history of the UNIX graphics system goes back to the 1984 MIT Athena education project. Athena was not a research project, and the development of new models of computing was not a primary objective of the project. Indeed, quite the opposite was true. MIT wanted a high-quality computing environment for education. 

In collaboration with DEC and IBM, the project developed a platform-independent graphics system to link together different systems from multiple vendors through a protocol that can both run local and remote applications. This system was the basis of the X-Window System, which began its growth in 1985 and was ported to various UNIX and not just UNIX platforms.

We now have several successors to the classic X-Window system, the most famous being the Android on mobile devices or Wayland graphics system on Linux desktops, but X-Windows is still relevant today. And we will discuss some non-trivial concepts related to this. To see them just look into:
```
man X
```

First of all, the X-Window System is a network oriented client-server architecture. But the relationship between the client and the server doesn't seem very clear at first glance. Generally, the X server simply accepts requests from various client programs to display graphics (application windows) and sends back user input (from keyboard, mouse, or touchscreen). And the server for ex. will run on your tablet, and the apps that run on the supercomputer are just clients.

The main principle of X-Window: “Provide mechanism rather than policy. In particular, place user interface policy in the client's hands."

And the main locator for the X server is the DISPLAY environment variable:
* DISPLAY=hostname:displaynumber.screennumber
Hostname is optional. Its absence means localhost. The display number is a unique identifier for this X server and should always appear in the display specification. And the screen number is an optional parameter for multi-screen X server configuration.

Let's try to play with this. First, we will switch to another virtual console, for example to second one by 'Ctrl+Alt+F2'. Actually, in Linux we have twelve virtual consoles by number of function keys on keyboard. And we can switch between them using 'Ctrl+Alt+function key'. On some of them, we see a login prompt and can log in here. Now let's run X server:
```
$ X
(EE)
Fatal server error:
(EE) Server is already active for display 0
        If this server is no longer running, remove /tmp/.X0-lock
        and start again.
(EE)
(EE)
Please consult the The X.Org Foundation support
         at http://wiki.x.org
 for help.
(EE)
```
This is expected - we already have a running X-server in the system, which occupies a zero display. This is not a problem -- let's try to run on the next display:

```
$ X :1
X.Org X Server 1.20.4
X Protocol Version 11, Revision 0
Build Operating System:  3.10.0-957.12.2.el7.x86_64
Current Operating System: Linux localhost 3.10.0-1127.18.2.el7.x86_64 #1 SMP Thu Jul 30 10:36:16 CDT 2020 x86_64
Kernel command line: initrd=initrd0.img root=live:CDLABEL=NauLinux_Qnet77-LiveCD rootfstype=auto ro rd.live.image quiet  rhgb rd
.luks=0 rd.md=0 rd.dm=0  BOOT_IMAGE=vmlinuz0
Build Date: 07 August 2019  08:52:04AM
Build ID: xorg-x11-server 1.20.4-7.el7
Current version of pixman: 0.34.0
        Before reporting problems, check http://wiki.x.org
        to make sure that you have the latest version.
Markers: (--) probed, (**) from config file, (==) default setting,
        (++) from command line, (!!) notice, (II) informational,
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.1.log", Time: Wed Aug 26 18:45:45 2020
(==) Using system config directory "/usr/share/X11/xorg.conf.d"
(II) [KMS] Kernel modesetting enabled.
resizing primary to 1024x768
primary is 0x5645745b54b0
^C(II) Server terminated successfully (0). Closing log file.
```
It looks like a black screen without any graphic elements. Something is wrong? Oh no... On the fourth virtual screen, login again and set the DISPLAY variable:
```
$ export DISPLAY=:1
```
Now let's start the good old terminal interface -- the `xterm` application:
```
$ xterm
```
OK. Let's go to the third virtual console, where we left our X server. Great -- we see the terminal window! But this is strange -- we can only print something while staying in the terminal window, we cannot move or resize it, moreover, we do not have a button to destroy it!

It's just because we have a developed system based on the KISS paradigm -- `xterm` simply emulates a terminal. If we want to move or resize windows (for example, we don't need this for an information kiosk), we need a special program for this -- a window manager. Let's run it on `xterm` by starting one of the graphical user environments - GNOME:
```
$ gnome-session &
```
OK. We now have a fully functional graphical user system in which we can work with graphical applications in the usual way.


* GEOMETRY=WIDTHxHEIGHT+XOFF+YOFF
Now let's turn to another important point -- geometry. With this parameter, we can set the position and size of the application window:
```
$ xterm -geometry 100x30+10+10
$ xterm -geometry 150x50+100+100
```

Finally, we can choose colors for applications that support such settings. X supports the use of abstract color names as described in the configuration file /usr/share/X11/rgb.txt. In this file, we can see the red, green and blue values for the named color definitions.
* COLOR=<color_space_name>:<value>/.../<value>
And we can use color names like this for example as application parameters:
```
 xterm -bg blue -fg red
```

## X-Window fonts
Another non-trivial point is fonts. XWindow supports both bitmaps and scalable fonts. In the latter case, it's possible to use so-called font servers to remotely render scalable fonts to bitmaps, which was useful for low-level X terminals.

Classic XWindow fonts are handled by utilities: `xfontsel`, `xfd` and `xlsfonts`.
```
xfontsel
```
In the font specification, we see the manufacturer's name, type, variety, size, resolution, encoding, and so on:
```
-adobe-courier-medium-?-normal--10-100-75-75-m-60-iso8859-*
```
Font names tend to be fairly long as they contain all of the information needed to uniquely identify individual fonts. However, the X server supports wildcarding of font names, so the full specification. 

This is good, but not good enough for the modern WYSIWYG (What You See Is What You Get) world. The standard XWindow paradigm knows nothing about presentation on paper, only on screen. All documents are executed by applications creating PostScript language output for high quality printing.

And with the widespread distribution of office suites, this paradigm turns out to be insufficient. For the modern WYSIWYG graphical interfaces, a new font engine has been developed -- FontConfig, which works with PostScript and TrueType fonts and is processed by utilities: `fc-cache`, `fc-list`, `fc-cat` and `fc-match`. 

## X-Window options
Classic XWindow applications are built using the XToolkit library and generally support a standard set of options. The most commonly used:
* -display – name of the X server to use
* -geometry – initial size and location of the window
* -title – window title
* -bg, -background, -fg, -foreground – window background/foreground color
* -fn, -font – font to use for displaying text
and some resources related options:
* -name – name under which resources for the application should be found
* -xrm – resource name and value to override any defaults

## X-Window resources

What is it XWindow resources? They described in the manual pages for such applications can be used to customize the default settings for XWindow applications. Resources must be located in the `.Xdefaults` or `.Xresources` file in the $HOME directory and can be processed by the `xrdb` utility on the fly.

The description looks like this:
```
obj.subobj[.subobj].attr: value
```
And in XWindow, the object-oriented paradigm was implemented even before it was implemented in well-known programming languages. Program components are named in a hierarchical fashion,  with  each  node  in  the hierarchy  identified  by a class and an instance name.  At the top level is the class and instance name of the application itself. By convention, the class name of the application is the same as the program name, but with the first letter capitalized:
* Obj – class name
* obj – instance name

Some examples:
```
XTerm*Font:  6x10
emacs*Background:  rgb:5b/76/86
```

GNOME user interface uses its own resource management -- Gconf and tools for working with it: `gconf-editor` and `gconftool-2`.
