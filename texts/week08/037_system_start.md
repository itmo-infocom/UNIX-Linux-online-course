## Booting and services starting/stopping

All right. But how does our system get started? In fact, when you turnon the computer, a special piece of code is launched, built into the hardware -- firmware. There are many such firmwares: legacy PC BIOS, UEFI, Uboot, OpenBoot, Coreboot, etc. The firmware reads the main bootloader from disk: BIOS from MBR, UEFI from EFI system partition, and so on.

Then the secondary bootloader started. This loader can be more or less complex and customizable. The most commonly used Linux bootloaders currently are lightweight boot system SYSLINUX for FAT file system and ISOLINUX for ISO images, which is mainly used to boot installation or live images, and the general purpose Grub bootloader.

Usually Grub is installed during system installation, including configuring the boot of other operating systems installed on your computer. But in some cases MS Windows on a dualboot computer can reinstall the bootloader without asking you, in which case you may lose your boot settings. To restore it, you need to boot from the installation media in repair mode and run the `grub2-install` program for your system storage. For example:
```
grub2-install /dev/sda
```

After the kernel is loaded, a special process called `init` is started. In original UNIX, as well as BSD `init`, just run the script `/etc/rc`, which completely determines the further behavior of the system.

A different `init` machinery is implemented for SYSV systems. On such systems, you can invoke the `init` program at any time by setting the runlevel as a parameter. Runlevels defined in the `init` configuration is located in the ['/etc/inittab' file](https://manpages.debian.org/unstable/sysvinit-core/inittab.5.en.html). Each line in the `inittab` file consists of four colon-delimited fields and describes:
* what processes to start, monitor, and restart if they terminate
* what actions to take when the system enters a new runlevel
* the default runlevel

Inittab's fields:
```
id:runlevels:action:process
```
* id (identification code) – consists of a sequence of one to four characters that identifies its function.
* runlevels – lists the run levels to which this entry applies.
* action – specific codes in this field tell init how to treat the process. Possible values include: initdefault, sysinit, boot, bootwait, wait, and respawn.
* process – defines the command or script to execute.

The line 'initdefault' defines the default runlevel. Different systems define different init level hierarchies, but some of them have the same meaning:
* Runlevel 0 is halt.
* Runlevel 6 is reboot.
* Runlevel 1 is single-user.
* from 2 to 5 are most often some multiuser runlevels.

Most often, the executable scripts in `inittab` are just some `rc` scripts that go through the appropriate `/etc/rc<runlevel>.d/` directories and run the stop scripts first, starting with a big K (kill) with a 'stop' parameter, and then starting the scripts that start with large S with a 'start' parameter:
```
$ ls -l /etc/rc.d/rc5.d/
```
And, as we can see, this script is simply symbolic links to scripts from `/etc/init.d/`, moreover, the Kill scripts and the Start scripts can be linked to the same file. If we look at them, we will see -- there are just scripts that do something according to the `start` or `stop` parameter:
```
$ less /etc/init.d/network 
```
And if you want to implement your own service script, you just have to support the 'start' and 'stop' parameters on this. To configure your own policy for stopping and starting services at any level, you simply have to link the scripts which you need from `/etc/init.d/` to the appropriate runlevel directories. The order in which scripts are run is determined by the numbers at the beginning of the filenames.

Some commands that can help you with this work:
* `service` - run a System V service script
* `setup` and `chkconfig` - updates and queries runlevel information for system services

The most commonly used Linux distributions now use `systemd` instead of such systems. The main advantage of this system is faster parallel launch of services at system startup, as well as unification of services and work with devices. These utilities and scripts are still present for compatibility, but now the main tool is `systemctl`:
```
man systemctl
```
We can list system services, start, stop and get their status, enable and disable them to automatically start at boot time.

To find out the log messages about boot startup and system operation, we can look at the system log files. For example:
* `/var/log/messages` -- in RH-like Linuxes
* and `/var/log/syslog` -- in Debian and Ubuntu

In modern Linuxes based on `systemd` we have a `journalctl` command to work with the `systemd` journal system.
