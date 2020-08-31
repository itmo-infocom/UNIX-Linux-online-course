## Software installation

Well. Now let's talk about installing software. If we are talking about free and open source, the most common way is compiling from source. Many projects simply require downloading the source, running the configure script, and running `make install`. This command reads an instruction from a file named "makefile" and installs the software into the target directory, by default `/usr/local`. You can change this and other settings during configuration.

Sounds good, but in most cases we may have problems uninstalling and updating installed software, because in most cases such actions may not be so simple, and the purpose of “uninstall” is not implemented in the Makefiles. And to perform a complete set of actions with the software, a special type of files called software packages and software were developed to manage them. They differ on different systems and distributions.

## Repositories and packages (RH-like)

rpm - RPM Package Manager
yum - Yellowdog Updater Modified
yumdownloader – program for downloading RPMs from Yum repositories

gnome-packagekit – Session applications to manage packages
yumex -- Graphical User Interface for Yum

/etc/yum.repos.d/ -- descriptions for repositries

[[Under the hood -- Devices and drivers](under_the_hood/devices_and_drivers.md)

CPAN, PyPi, NPM, static binaries, docker containers
