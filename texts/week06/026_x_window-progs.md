## Xserver
OK. Let's look to some classical XWindow applications.

The first one as we know is a X server:
```
man X
```
Most important options:
:displaynumber – default is 0
-fp fontPath – search path for fonts
-s minutes – screen-saver timeout time in minutes

And some options that can help organize a local XWindow network with low-cost X terminals and application servers:
-query hostname – enables XDMCP and sends Query packets to the specified hostname on which this or that display manager is running;
-broadcast – enables XDMCP and broadcasts BroadcastQuery packets to the network. In this way, simple load balancing between application servers can be organized.
-indirect hostname – enables XDMCP and send IndirectQuery packets to the specified hostname. In this case, you will see a list of available application servers that you can select.

## Xserver settings

After starting the X-server, it is possible to change some parameters on the fly by `xset` command:
```
man xset - user preference utility for X

Options:
-display display – set display
q – current settings
[+|-]fp[+|-|=] path,... – set the font path for X-server, including font-server
fp default – font path to be reset to the server’s default.
fp rehash – reset the font path to its current value (server reread the font  databases  in  the  current  font path)
p – pixel color values
s – screen saver parameters
```

## X-Window utiltities
As we discussed earlier, the main principle of the X Window System is "Provide a mechanism, not a policy." And the look and feel in X Window can be anything -- it is simply determined by the set of widgets on which a particular application is built. It is not a paradox, but the appearance of the original XWindow applications may seem a little odd to modern users, as they are based on an ancient set of widgets from the Athena project. It looks "ugly" at now days, but they were often used in the period of X history that he describes as the "GUI wars", as a safe alternative to the competing Motif and Open Look toolkits.

Let's look at the well-known for us `xterm` application:
```
xterm
```
As we can see, these are very simple 2D graphics with very unusual scrollbar behavior, which often discourages new users. The general abstraction of a mouse pointer in an XWindow is a three-button device. If you have a mouse with fewer buttons, the middle button is emulated, for example, by simultaneously pressing the left and right buttons. So here: pressing the left button on the scroll bar scrolls forward, the right button backward, and the middle button scrolls to the selected position.

Yet another classic XWindow utilities:
```
xkill - kill a client by its X resource
xdpyinfo - display information utility for X
xwininfo - window information utility for X
xlsclients - list client applications running on a display
showrgb - display an rgb color-name database
appres - list X application resource database
xrdb - X server resource database utility
editres - a dynamic resource editor for X Toolkit applications
xsetroot - root window parameter setting utility for X
xev - print contents of X events
xmodmap - utility for modifying keymaps and pointer button mappings in X
setxkbmap - set the keyboard using the X Keyboard Extension
xrefresh - refresh all or part of an X screen
```
and others.
