## Network configuration

Finally, let's discuss the administrative tasks associated with the network. In most cases, after installing the system, you have a more or less configured network in accordance with the DHCP settings of your local network. The most you need is to set a password for your WiFi.

But in some cases it would be helpful to have some utilities to view and manage network settings. Unlike other devices, network interfaces do not have their own representations in the device files in the /dev directory. You can work with them only with the help of special utilities. Traditional set of utilities for network configuration:
* ifconfig - configure a network interface
* route - show/manipulate the IP routing table

With no arguments, ifconfig just shows us the current state of enabled network interfaces. By pointing to a network interface, we can "up" and "down" them, we can also manually set the IP address and netmask:
```
man ifconfig
```

You can use the `route` utility to work with the routing table. To view the route table we may run command:
```
route -n
```
The option '-n' show  numerical  addresses instead of trying to determine symbolic host names. This can be useful if you are having problems accessing the DNS server. 
```
man route
```
With this command we can add and remove routes to hosts and networks. We can set gateways to them.

In modern Linux distributions, these `net-tools` are outdated and are not installed by default. They are migrating to the more versatile `ip` utility, which also supports more advanced networking options than `net-tools`:
```
man ip
```
You can use `ip link` to perform the same tasks as `ifconfig` and `ip route` to replace `route`:
```
$ ip link help 2>&1 | less
$ ip route help 2>&1 | less
```
The next important task when setting up your network is setting up DNS resolving. This configuration is placed in `/etc/resolv.conf`:
```
$ cat /etc/resolv.conf
```
Here we can configure up to 3 nameservers.
```
man resolv.conf
```
Also, using the `search` configuration option, we can configure the domains in which short names will be searched.

## Network access
And finally, a few words about regulating network access to your computer. As we understand, network attacks are currently the most dangerous. And the most famous tool for restricting access is a firewall.

At its deep level, the firewall in Linux is controlled by the `iptables` utility. But at a higher level, different systems manage it in different distributions:
* Canonical’s Uncomplicated Firewall (ufw) to configure the iptables on every Ubuntu and Debian system I’ve used in recent years. The firewall isn’t enabled by default in Ubuntu nor installed by default in Debian. As its name suggests, it’s fairly uncomplicated to set up and maintain. It has an easy to remember syntax that’s more friendly to human users than the underlying iptables rules.
* Fedora and Red Hat Enterprise Linux enables FirewallD by default. Its firewall-cmd front-end has almost the same feature set for basic firewall management as ufw, and adds network zone management to the mix. Zone management allows you to set up presets with rules for different network conditions/locations. For example “Home” and “Office” where all communications with local machines are allowed, and “Public Wi-Fi” where no communication with the same subnet would be allowed. Rules can be applied automatically per network interface, or used through NetworkManager and the GNOME network GUI `system-config-firewall`.

/etc/init.d/iptables
/etc/sysconfig/iptables

Host access control files:
/etc/hosts.deny:
          ALL: ALL
/etc/hosts.allow:
          ALL: LOCAL @some_netgroup
          ALL: .foo.bar EXCEPT hacker.foo.bar

## Network services

xinetd - the extended Internet services daemon
system-config-services, /etc/xinetd.d

/etc/exports - NFS server export table
