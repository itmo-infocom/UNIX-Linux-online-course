## Software installation

Well. Now let's talk about installing software. An initial set of software is installed during system installation, and installed software packages are updated by system services when newer versions are published to the distribution sites. But let's take a deeper look.

[Diomidis Spinellis, "Evolution of the Unix System Architecture: An Exploratory Case Study"](https://ieeexplore.ieee.org/iel7/32/4359463/08704965.pdf)

From the First Research Edition (November 3, 1971) in which the PDP-7 Unix was rewritten on the PDP-11 processor, UNIX documented the "User Maintained Programs" guidelines by organizing third-party code as so-called "packages" or "ports".

The two first Berkeley distributions introduced to the user community third-party software packages targeting Unix. Over the years packages proliferated and got distributed, initially through USENET newsgroups and later over the internet in the form of ports to a specific operating system distribution. The established filesystem directory hierarchy, provided a template for laying out the source code, the documentation, and the manual pages. In addition, the use of `make` utility provided a common way for expressing compilation and deployment rules. 

And now if we are talking about free and open source, the most general way is compiling from source. Many projects simply require downloading the source, running the configure script, and running `make install`. This command reads an instruction from a file named "makefile" and installs the software into the target directory, by default `/usr/local`. You can change this and other settings during configuration.

Sounds good, but in most cases we may have problems uninstalling and updating installed software, because in most cases such actions may not be so simple, and the purpose of “uninstall” is not implemented in the Makefiles. And to perform a complete set of actions with the software, a special type of files called software packages and software were developed to manage them. They differ on different systems and distributions.

## Repositories and packages

BSD UNIX packaging has been extended to the FreeBSD `ports` machinery, which provides a mechanism for compiling and installing third-party packages and their dependencies. The main package Linux utilities are `rpm` (RPM Package Manager) for RH-like systems and` dpkg` for Debian-based distributions:
```
man rpm
man dpkg
```
A package is a file that you can install, remove, and update. But when we have many packages with a complex system of dependencies between them, it can be too difficult to handle the full set of dependent packages during package manipulation.

To solve this problem, so-called repositories have been developed, which collect many packages, resolve dependencies between them and put information about this in metadata files.Such repositories are hosted on the servers of the respective projects, and we can access them via the Internet.

The main tools for working with repositories are:
* `yum` -- Yellowdog Updater Modified for RPM repositories, now replaced with `dnf` package manager.
* `apt` -- package manager for Debian-based repositories.
As we can see, using these tools, we can perform the same actions as with `rpm` and `dpkg`: install, remove and update packages with dependencies. We can also get information about packages and package groups in the repositories, get a list of packages, search for packages by name or by files included in the package.

Also may be useful `yumdownloader` -- program for downloading RPMs from Yum repositories.

You can find descriptions of the repositories in:
* /etc/yum.repos.d/ -- 
* /etc/apt/sources.list

You can see the [Table of equivalent commands for package management on both Ubuntu/Debian and Red Hat/Fedora systems](https://help.ubuntu.com/community/SwitchingToUbuntu/FromLinux/RedHatEnterpriseLinuxAndFedora)

[Under the hood -- Devices and drivers](under_the_hood/devices_and_drivers.md)

CPAN, PyPi, NPM, static binaries, docker containers
