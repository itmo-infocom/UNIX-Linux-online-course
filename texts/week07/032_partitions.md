# Partitions

As storage systems grow, they need to be separated to store different data. And for this the partitioning was invented. There are different partition schemes developed by different vendors like IBM, Apple, Microsoft, etc.

In common PCs the Master Boot Record (MBR) partitioning scheme, widely used since the early 1980s, imposed limitations for use of modern hardware. A major deficiency is the limited size of 32 bits for block addresses and related information. For hard disks with 512-byte sectors, the MBR partition table entries allow a maximum size of 2 TiB. Also, the standard partitioning scheme only supports 4 primary partitions, and as the disk space increases, it will become necessary to implement such complex solutions as extended and logical partitions.

In the late 1990s, Intel developed a new partition table format as part of what eventually became the Unified Extensible Firmware Interface (UEFI). As of 2010, the GUID Partition Table (GPT) forms a subset of the UEFI specification. GPT uses 64 bits for logical block addresses, allowing a ZB disk size. Number of partitions -- depends on the space allocated for the partition table. By default, the GPT contains space to define 128 partitions.

Different systems use different naming schemes for devices and partitions. Modern Linux, for example, has special `/dev/sd` files for SCSI or Serial ATA (SATA) devices with a naming schema like this:
```
ls /dev/sd*
/dev/sda   /dev/sda10  /dev/sda12  /dev/sda2  /dev/sda4  /dev/sda6  /dev/sda8  /dev/sdb   /dev/sdb2
/dev/sda1  /dev/sda11  /dev/sda13  /dev/sda3  /dev/sda5  /dev/sda7  /dev/sda9  /dev/sdb1  /dev/sdb5
```
The letter "a" stands for the first device on the bus, and the numbers are the partitions. We can also access disk devices by disk labels:
```
ls -l /dev/disk/by-label
```

BSD disklabels, which also used on many commersial UNIXes, traditionally contain 8 entries for describing partitions. These are, by convention, labeled alphabetically, from 'a' to 'h'. Some BSD variants have since increased this to 16 partitions, labeled from 'a' to 'p'.

Also by convention, partitions 'a', 'b', and 'c' in BSD have fixed meanings:
* 'a' is the "root" partition, the volume from which the operating system is bootstrapped.
* 'b' is the "swap" partition;
* 'c' overlaps all of the other partitions and describes the entire disk. Its start and length are fixed. On systems where the disklabel co-exists with another partitioning scheme (such as on PC hardware), partition 'c' may actually only extend to an area of disk allocated to the BSD operating system, and partition 'd' is used to cover the whole physical disk.

On Linux, MBR related tools are:
* `fdisk` -- is a simple text-based tool:
```
# fdisk /dev/sda
Command (m for help): m
Command action
   d   delete a partition
   g   create a new empty GPT partition table
   G   create an IRIX (SGI) partition table
   l   list known partition types
   m   print this menu
   n   add a new partition
   o   create a new empty DOS partition table
   p   print the partition table
   q   quit without saving changes
   s   create a new empty Sun disklabel
   t   change a partition's system id
   v   verify the partition table
   w   write table to disk and exit
   x   extra functionality (experts only)

Command (m for help): p
...
```
The most useful operations: m, p, n, t, d, q, w.

Also we have:
* `cfdisk` -- is a fullscreen program, text-based variant of `fdisk`.
* `sfdisk` -- non-interactive variant of `fdisk`, it's useful for scripting.

Partition management programs that support GPT:
* `parted` – GNU Parted. 
```
#  parted /dev/sda
GNU Parted 3.1
Using /dev/sda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) help                                                             
  align-check TYPE N                        check partition N for TYPE(min|opt) alignment
  help [COMMAND]                           print general help, or help on COMMAND
  mklabel,mktable LABEL-TYPE               create a new disklabel (partition table)
  mkpart PART-TYPE [FS-TYPE] START END     make a partition
  name NUMBER NAME                         name partition NUMBER as NAME
  print [devices|free|list,all|NUMBER]     display the partition table, available devices, free space, all found
        partitions, or a particular partition
  quit                                     exit program
  rescue START END                         rescue a lost partition near START and END
  
  resizepart NUMBER END                    resize partition NUMBER
  rm NUMBER                                delete partition NUMBER
  select DEVICE                            choose the device to edit
  disk_set FLAG STATE                      change the FLAG on selected device
  disk_toggle [FLAG]                       toggle the state of FLAG on selected device
  set NUMBER FLAG STATE                    change the FLAG on partition NUMBER
  toggle [NUMBER [FLAG]]                   toggle the state of FLAG on partition NUMBER
  unit UNIT                                set the default unit to UNIT
  version                                  display the version number and copyright information of GNU Parted
(parted)                                                                  
```
* `gparted` -- graphical variant of `parted`.

