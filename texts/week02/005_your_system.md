# Your system

Historically, we had many flavors of UNIX-like systems, and some of them are still alive today. And most of them are opensorce and free: [Unix History Timeline](http://www.levenez.com/unix/)

The best advantage of free systems is their availability. You can download many kinds of Linux or UNIX systems for free. You can distribute such systems, downloaded from the Internet, and use them to create your own customized solutions using a huge number of already existing components.

For example, for educational purposes we use our own Linux distribution called NauLinux. This title is the abbreviated title of the Russian translation of the original Scientific Linux project -- "Nauchnyi Linux". We are adding some software packages for working software-defined networks and quantum cryptography emulating and are using this new distributions to simulate various complex systems in educational or research projects. This distribution is free and is used by students to create their own solutions.

Scientific Linux on which we are based is also free. It was created at Fermilab for use in high energy physics and has focused from the beginning on creating specialized flavours optimized for the needs of laboratories and universities.

This, in turn, is based on Red Hat Enterprise Linux (RHEL), a commercial Linux distribution widely used in the industry. You will be charged for using the binaries for that distribution and getting support from the vendor. But the sources from this distro are still free, and anyone can download it and rebuild their own distro.

The source of RHEL, in turn, is the Fedora experimental project, developed by the community with the support of Red Hat. Leveraging large communities of skilled and motivated users lowers the cost of testing, development, and support for the company. And this is an example of the profitable use of the Free and Open Source model by a commercial company.

There are many free BSD OS variants, currently FreeBSD, NetBSD, OpenBSD, DragonFly BSD. They all have their own specifics and their own kernels with incompatible system calls. This is a consequence of the fact that the development of these systems is driven only by communities in which disagreements arise from time to time, and they are divided according to different interests regarding the development of systems.

On the Linux project, we still have one and only one "benevolent dictator", Linus Torvalds. As a result, we still have a single main kernel development thread published on kernel.org. While many other experimental Linux kernel flavours are also being developed, not all of them are accepted into the mainstream. In turn, on the basis of this single kernel, the development of various OS distributions is made, often with some changes from the distribution vendors.

The most commonly used free Linux distributions are:
* community driven Debian project
* Ubuntu Distro based on Debian and developing by Canonical company
* The Fedora Project on which RHEL development is based
* and Centos -- another free RHEL respin
Gentoo, Arch, Alpine and many other Linux distributions are also well known. Many projects are focused on embedded systems, such as BuildRoot, Bitbake, OpenWRT, OpenEmbedded and others.

You can usually use them in different ways - install on your computer (including coexistence with other systems such as Windows, with the ability to dual boot), boot from a live image or network server without installing the OS to a local hard drive, run as a container or virtual machine on your local computer or network cloud, etc. You can find detailed information on installing and configuring such systems in the documentation of the respective projects.

Moreover, you can simply use online services to access UNIX or Linux systems, for example:
* https://skn.noip.me/pdp11/pdp11.html -- PDP-11 emulator with original UNIX
* https://bellard.org/jslinux -- a lot of online Linux'es

When you log in, you will be asked for a user and password. Depending on your system configuration, after logging in, you will have access to a graphical interface or text console. In both cases, you will have access to the Shell command line interface, which we are most interested in.

The user password is set by the `root` superuser during installation or system configuration, and this password can be changed by the user himself by the command `passwd`. As you can see, this may not be so easy - `passwd` protects us from bad passwords that are easy to crack. The most common guidelines for a good password are:
* long, at least 8 characters long;
* includes Numbers, Symbols, Capital Letters, and Lower-Case Letters;
* isn’t a Dictionary Word or Combination of Dictionary Words.

But recently, as a recommendation, you can often find advice to simply use a regular long phrase as a password. It usually brings many more combinations, making it difficult for hackers to crack.

OK. Now let's try to change out password:
```
passwd
```

But the superuser can change the password for any user with the same command without any restrictions:
```
sudo passwd user
```
