# Networking in Kubernetes - Prerequisites

## Networking Basics:

Older Linux versions especially Red Hat, had a naming convention of eth0, eth1 and so on.<br>
Usually eth0 is the first network detected during the boot. However, the PCIe standard does not guarantee that the first detected device will be eth0 on every reboot.<br>
Newer versions of Linux OSes, instead of using the detection based naming system, names the interfaces based on
1. Firmware
2. PCI Bus Toplogy
3. Type of Network Service

Network Interface names start with the type of Interface:
+ Ethernet Interfaces start with en
+ WLAN Interfaces start with wl
+ WWAN Interfaces start with ww

The rest of the interface name after the type will depend on information provided by the server's firmware or location of the device in the PCI topology.
+ oN - Onboard device  - **eno1** = Onboard Ehternet Device 1.
+ sN - Indicates the PCI Slot number - **ens3** = Onbaord Ethernet Device in Slot 3
+ pMsN - Indicates this is a PCI device on bus M, in slot N - **wlp4s0** = WLAN card on PCI bus 4, slot 0

NIC Devices with multiple ports 
+ enp0s1f0 - Indicates this device is on PCI bus 0, slot 1, function 0.
+ enp0s1f1 - Indicates this device is on PCI bus 0, slot 1, function 1.

**List all ethernet Interfaces on the system:**
```# ip link show```
```
[user@host ~]$ ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT
 group default qlen 1000
 link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT
 group default qlen 1000
 link/ether 52:54:00:00:00:0a brd ff:ff:ff:ff:ff:ff
3: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT
 group default qlen 1000
 link/ether 52:54:00:00:00:1e brd ff:ff:ff:ff:ff:ff
```
In the above example, there are 3 network interfaces:
+ lo = Loopback interface, denoting the self
+ ens3 and ens4 = Indicates there are 2 ethernet ports on this device.

The MAC address of the device is listed after link/ether for each interface. So you know that the network card with the MAC address 52:54:00:00:00:0a is the
network interface ens3.

**List the interfaces and their IP addresses(note a single network interface can have multiple IPv4 or IPv6 addresses):**
```# ip addr show   ```
```
[user@host ~]$ ip addr show ens3
2: ens3: <BROADCAST,MULTICAST, UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP
 qlen 1000
 link/ether 52:54:00:00:00:0b brd ff:ff:ff:ff:ff:ff
 inet 192.0.2.2/24 brd 192.0.2.255 scope global ens3
 valid_lft forever preferred_lft forever
 inet6 2001:db8:0:1:5054:ff:fe00:b/64 scope global
 valid_lft forever preferred_lft forever
 inet6 fe80::5054:ff:fe00:b/64 scope link
```
```ens3: <BROADCAST,MULTICAST, UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP``` - Indicates the Interface is UP.<br>
```link/ether 52:54:00:00:00:0b brd ff:ff:ff:ff:ff:ff``` - Indicates the MAC address of the port.<br>
```inet 192.0.2.2/24 brd 192.0.2.255 scope global ens3``` - Inet, indicates that its a IPv4 address, with the network prefix and scope.<br>
```inet6 2001:db8:0:1:5054:ff:fe00:b/64 scope global``` - Inet6, indicates the IPv6 address, with the network prefix and scope.<br>
```inet6 fe80::5054:ff:fe00:b/64 scope link``` - This inet6 line shows that the interface has an IPv6 address of link scope that can only be
used for communication on the local Ethernet link.<br>

Display the Performance statistics of an ethernet port:
```
[user@host ~]$ ip -s link show ens3
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen
 1000
link/ether 52:54:00:00:00:0a brd ff:ff:ff:ff:ff:ff
 RX: bytes packets errors dropped overrun mcast
 269850 2931 0 0 0 0
 TX: bytes packets errors dropped carrier collsns
 300556 3250 0 0 0 0
```

To check if the communication between 2 systems are fine, a ping command will do, however, both the systems should be on the same network:<br>
```# ping <ip_addr_of_destination_host>```

When we need 2 computers to talk to each other, a switch is the device that creates the network between the 2 devices.<br>
To connect the computer to the switch, we need an inteface on each host and each of these hosts can be physical or virtual.<br>

![image](https://github.com/pyvivid/K8S-References/assets/94853400/7d7d5bd6-0a40-48e4-aefd-b71bb36fb529)

To view the interfaces available on a linux host(some may be physical or virtual) use the ```# ip link``` command.<br>
Notice the eth0, does not show an ip address assigned to it.<br>
We can then assign an IP addr to the port on the host using:
```# ip addr add <ip_to_assigned>/<slash-notation> dev <dev_id>```<br>
In our case we can assign the IP addresses as follows:<br>
For eth0 on Sys1 host:<br>
```# ip addr add 192.168.1.10/24 dev eth0```<br>
For eth0 on Sys2 host:<br>
```# ip addr add 192.168.1.11/24 dev eth0```<br>
Once we up the link using the following command on both the Systems, using the command:<br>
```# ip link set dev <interface> up``` - Interface in our case is eth0.<br>
the hosts should be able to communicate with each other.<br>

To view the IP addresses assigned to each of the physical or virtual ports:<br>
```
This is another sample, do not compare to the core discussion.
ubuntu $ ip addr show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc fq_codel state UP group default qlen 1000
    link/ether f2:05:f6:3f:86:80 brd ff:ff:ff:ff:ff:ff
    inet 172.30.1.2/24 brd 172.30.1.255 scope global dynamic enp1s0
       valid_lft 86312840sec preferred_lft 86312840sec
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:38:d5:45:ab brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
```

Now, lets say, if we have 2 networks and we need to allow both the networks to communicate with each other, then device to be used is a router:
![image](https://github.com/pyvivid/K8S-References/assets/94853400/5495e987-f2b7-41f9-9ca3-ab22ea7b890d)<br>
A router:
+ Allows to connect 2 networks together.
+ A router connects and presents itself as an individual device in each of the network it connects to and hence will have 2 IPs.
+ As in the above diagram, the router had 2 IP address
   + 192.168.1.1
   + 192.168.2.1
+ One IP assigned to it from each of the network it is connected to. The Idea is that the router acts like an individual device within each seperate network.<br>
Remember, like the router there can be numerous other devices within the network.<br>
Now as in the above diagram, lets say, System B(192.168.1.11) wants to communicate to System C(192.168.2.10).<br>
<br>
This is where **Gateway** comes in. If the Network was the room, then the Gateway is the door to the outside world, which can simply be other networks or to the Internet.<br>
The systems within each network needs to know, where the GW is located to go through that.
The exisiting routing configuration can be viewed as below(its currently holds no configuration):

```
ubuntu $ route
Kernel IP routing table
Destination      Gateway         Genmask         Flags Metric Ref    Use Iface
ubuntu $
```
You can see there are no entries and its currently holds no configuration.<br>
The above is the kernel's routing table on every single machine within the networks. Machines within the same network only can commuincate with each other as of now.<br>
Lets say we want the Sys B to communicate to SysC add the following route:<br>
```# ip route add 192.168.2.0/24 via 192.168.1.1```<br>
The above command will let know the machines that to reach the machine in the 2.0 network, it has to travel via 192.168.1.1. <br>
After having added the above line on the Sys B, if we run the route command again:
```
ubuntu $ route
Kernel IP routing table
Destination      Gateway         Genmask         Flags Metric Ref  Use Iface
192.168.2.0      192.168.1.1     255.255.255.0   UG    0      0    0   eth0
ubuntu $
```
Remember, the above process has to be repeated on all the machines within all the networks.<br>
If the Sys C has to communicate to Sys B, then a routing table needs to be added to the Sys C as:
```# ip route add 192.168.1.0/24 via 192.168.2.1```<br>
After having added the above line on the Sys C, if we run the route command :
```
ubuntu $ route
Kernel IP routing table
Destination      Gateway         Genmask         Flags Metric Ref  Use Iface
192.168.1.0      192.168.2.1     255.255.255.0   UG    0      0    0   eth0
ubuntu $
```
Now we want our machines in all the networks to communicate to the outside world(internet).<br>
After connecting the router to internet, we add a route to the routing table entry for every machine in every network.
```# ip route add 192.168.1.0/24 via 192.168.2.1```
```# ip route add 172.217.194.0/24 via 192.168.2.1```
If the route command is executed again, we should see like:
```
ubuntu $ route
Kernel IP routing table
Destination      Gateway         Genmask         Flags Metric Ref  Use Iface
192.168.1.0      192.168.2.1     255.255.255.0   UG    0      0    0   eth0
172.217.194.0    192.168.2.1     255.255.255.0   UG    0      0    0   eth0
ubuntu $
```
This looks quite tedious task, right. And we have numerous websites and applications that we would want to connect in the internet.<br>
Instead, we can say, like, if you do not know the route to any network use this router as the default gateway.<br>
```# ip route add default via 192.168.2.1``` <br> or <br>
```# ip route add 0.0.0.0/0 via 192.168.2.1```<br>
notice the default replaced by 0.0.0.0/0.<br>
This way any request to any network, will be routed via the particular router on 192.168.2.1, which tells the machines in the 2.0 network, that for any communications to the outside world or other network, use the 192.168.2.1 gateway.<br>

Let us say, you have multiple routers in your network, one for internal communications and one for internet, then you will **need to have 2 seperate entries for each router**.<br>
![image](https://github.com/pyvivid/K8S-References/assets/94853400/d51d02a5-e73e-4455-9f3c-3dbcf81ce39d)<br>

As in the above diagram, we need to have 2 entries as below:<br>
```
ubuntu $ route
Kernel IP routing table
Destination      Gateway         Genmask         Flags Metric Ref  Use Iface
default          192.168.2.1     0.0.0.0         UG    0      0    0   eth0
192.168.1.0      192.168.2.2     255.255.255.0   UG    0      0    0   eth0
ubuntu $
```
### Setting up a Linux host as a router:

Let us say we have 3 hosts A, B and C. We will use host B as the router here.
A and C each has 1 interface and B has 2 interfaces.
+ eth0 on A and eth0 on B are connected. A and B are connected on the 192.168.1.0 network.
+ eth0 on B and eth1 on B are connected. B and C are connected on the 192.168.2.0 network.

**Now how do I get A to talk to C?**
To enable A to talk to C, we have to follow a 2 step process here
1. Let Host A know the route to C
    ```# ip route add 192.168.2.0/24 via 192.168.1.6```
2. Let Host C know the route to A
   ```# ip route add 192.168.1.0/24 via 192.168.2.6```
3. At this stage, when you try to ping C from A, you do not get any response, no failure error also, due to security reasons.
4. Theres this file under ```/proc/sys/net/ipv4/ip_forward``` that needs to be updated to 1, to allow ip forwarding. Default value within the file will be 0, update to 1.
   This is not a persistent setting.
6. To allow communications between the two hosts, persistently, update the ```/etc/sysctl.conf``` file as below:
   ```net.ipv4.ip_forward = 1```




## DNS Basics:

We have 2 nodes, Sys A and Sys B , each assigned with assigned address 192.168.1.10 and 192.168.1.11 respectively. The nodes are pingable from each other.<br>
The Sys B hosts DBs and has a hostname "db". <br>
If we ping the 2nd node from the 1st node as ```ping db``` rather than using its IP address, we will not get a response from the 2nd node.<br>
To make the Sys A understand that whenever we reference to a hostname as DB it references to 192.168.1.11, within the Sys A, **/etc/hosts** file, must have an entry as below:<br>

```
# cat /etc/hosts
192.168.1.11          db
```

The entry in the above file states that the 192.168.1.11 has a hostname to be referenced as "db". Whatever we put into the /etc/hosts the system will take for granted.<br>
The Sys A does not check if the Sys B's hostname is Db or not. Now, lets say the hostname on Sys B is changed, but still the Sys A will be able to ping Sys B.<br>
If within an /etc/hosts file, there are 2 different hostnames referencing to the same IP address, in this case Sys A, Sys A can reach Sys B as db or any other name set in the /etc/hosts file.<br>

```
# cat /etc/hosts
192.168.1.11          db
192.168.1.11          www.google.com
```

In the above case the node with IP address 192.168.1.11 will be reachable from Sys A as both db or www.google.com.<br>
You can have as many host information as you want within the hosts file.<br>
When any application or ping or ssh tries to reach a host, it will check into the /etc/hosts file, find the ip address of that host and reach it. This process of translating hostnames to IP addresses is called **"Name Resolution"**.<br>
When within a small network, the above method works fine. However, if we need to work with a large number of nodes within a network, maintaining the information on every host and updates to the file as the IP changes are quite a tedious task. This is where a DNS server comes in.<br>
The DNS server maintains the list of all hosts within the network and each node within the network can check with the DNS host and find the IP address, rather than having all the information within its /etc/hosts file.<br>
Every node has a file **/etc/resolv.conf** which will contain the DNS host information, which the node can reach out to, to find the IP address of any node within a network.<br>

```
# cat /etc/resolv.conf
nameserver         192.168.1.100
```

This information will need to be configured in each of the node within your network and when any node does not know the IP address of the node it wants to communicte to, it will check the **/etc/resolv.conf** file for the DNS nameserver information and find it from there.<br>
Now, if the IP address of any of the hosts within the network changes, then just update the IP address in the DNS server and now any node to reach the updated node, can find the infomation from the DNS nameserver.<br>
Now for one time or indiviual test needs a node can still refer to the /etc/hosts file for this information.<br>
So a system is able to use host name to IP mapping from the /etc/hosts file locally as well as from a remote DNS server.<br>

### DNS Hierarchy:

Let us say, I have an entry in my local file set to 192.168.1.115 for a server, while, within the DNS server, the entry for the server is set as 192.168.1.116.<br>
The node which requires the IP will first look in the local /etc/hosts file for the IP, if the IP is found it starts moving towards the IP found in the hosts file which is 115 in this case.<br>
Else, it moves to check the DNS server specified in the /etc/resolv.conf file and checks on the DNS server, and if the IP is found there it moves to 116.<br>
However, the order in which the node checks for the IP can be spcified in the /etc/nsswitch.conf. The contents of the nsswitch.conf resembles:<br>
```
# cat /etc/nsswitch.conf
...
hosts:         files    dns
...
```
With the above configuration, the node checking for the IP of the other node, will first check in the local hosts file and then the DNS.<br>
If we switch the order of the "files dns" to "dns   files", the node will first check on local /etc/hosts file and then the dns file, which is /etc/resolv.conf.<br>

Additionally you can add another DNS server info in the /etc/resolv.conf file, like<br>
```
# cat /etc/resolv.conf
nameserver         192.168.1.100
nameserver         8.8.8.8
```
The 8.8.8.8 is a DNS server hosted by google, that contains all the info about all the domains in the internet.<br>
We can have multiple name servers configured in the resolv.conf file of the host.<br>
We can also have our DNS server, 192.168.1.100 configured to forward any unknown host names to the public name server on the internet.<br>

## Understanding Domain Names:<br>

**www.facebook.com** is a domain name.Domain names allow us to remember the name of a company/service easily rather than the IP address. <br>
The last portion of the domain name ".com" = Top Level Domains. Other TLDs include .org, .net, .edu to name a few.<br>
facebook = Assigned Domain Name<br>
www = Sub Domain or maps.google.com = maps is a subdomain. A single domain have multiple subdomains associated with it.<br>
![image](https://github.com/pyvivid/K8S-References/assets/94853400/56c4cfa8-7084-4e96-a500-a82104dbf3a4)


Now let see the path a data request will flow, when trying to reach a particular domain like apps.google.com. Assuming apps.google.com is hosted at 216.58.221.78.
From your machine, the request flows to your organization's DNS server. Since your DNS server does not info about the google.com or apps.google.com, it will forward the request to the internet.<br>
On the internet, multiple DNS servers may be used to resolve the IP address of the apps.google.com. This flow occurs by forwarding the request 
+ First to the DNS server providing .com domain name resolution.
+ Then forwards the request to Google's DNS server to locate the server hosting the "app".
+ Once the IP of the app is found the response is received from the app.google.com into your local machine, from where the request originated.
+ The Org's DNS server will cache the IP of the destination for a set amount of time, to expedite the whole process, if another request to the same destination comes in.

![image](https://github.com/pyvivid/K8S-References/assets/94853400/ed77f5ee-40c8-4751-a592-98b568511289)
<br>

## DNS Records

DNS Records of a Domain are stored in a Zone File also called as the HostZone file.<br>
![image](https://github.com/pyvivid/K8S-References/assets/94853400/f558d10a-67af-4af7-8e71-d97eaab5901f)<br>

FQDN:<br>
    + Fully Qulaified Domain Name<br>
A and AAAA Records:<br>
    + Both the A and AAAA map a host to an IP address.<br>
    + The A record is used for IPv4 IP addresses and AAAA is used for IPv6 IP addresses.<br>
    ![image](https://github.com/pyvivid/K8S-References/assets/94853400/4e73feec-0318-404e-bcf4-684e3bea7dd2)<br>
CNAME Records<br>
    + CNAME records define the Canonical Name for the Server in which the domain is hosted.<br>
    + CNAME maps one name to another. 
    ![image](https://github.com/pyvivid/K8S-References/assets/94853400/353d0f0b-7faf-47d3-b78e-4af46cc70875)<br>
MX Records:<br>
    + MX records are used to define the mail exchanges that are used for the domain. This helps email messages arrive at your mail server correctly.<br>
    ![image](https://github.com/pyvivid/K8S-References/assets/94853400/7bfdbe83-df64-4a6d-99cf-416ce6267ca0)<br>
NS Records:<br>
    + NS Records defines the DNS Server information of the specific domain.<br>
    ![image](https://github.com/pyvivid/K8S-References/assets/94853400/5b566a0e-43d7-490f-a3c5-4eab46e13830)<br>

To find the DNS resolution we can use the nslopkup command.
```
uroot01@uroot01:~$ nslookup www.google.com
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
Name:	www.google.com
Address: 142.250.76.68
Name:	www.google.com
Address: 2404:6800:4007:815::2004
```

## Networking NameSpaces in Linux:<br>

Just like system level namespaces, the network namespaces are used by containerization tools like Docker to implement **network isolation** of resources.<br>
The host within which the containers are running have their own Ethernet Interfaces and their own IP addresses.
When a new container is created on a host, it creates a network namespace for it, that way, it has no visibility to any other network information on the host or other containers within the host.<br>
Each container within a host, has its own virtual interface and it can have its own Routing and ARP tables.<br>
We can create network namespaces within a linux host as below:<br>
```
# ip netns add red
# ip netns add blue
# ip netns
red
blue
```
To view the link interfaces of a node, we can use the ```# ip link``` command. Like wise, if I wanted to see the interface created by a network namespace, we can use:<br>
```
# ip netns exec red ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc state UNKNOWN mode DEFAULT group default qlen 1000
link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
```
What we see from above is that a loopback address of the network namespace is visible, however we cannot see the eth0 interface on the host.<br>
So with namespaces, we have successfully isolated and **prevented the container from seeing the host interface**.<br>
Same is the case with the ARP and routing table. When running the ARP within the main host:<br>
```
# arp
Address          HwType        HwAddress            Flags  Mask    Iface
172.17.0.21      ether         02:42:ac:11:00:15	C              etho
172.16.0.8       ether         06:fe:d3:b5:59:65	C              etho
_gateway         ether         02:42:d5:7a:84:8e	C              etho
host01q          ether         02:42:ac:11:00:1c	C              etho
# ip netns exec red arp
Address          HwType        HwAddress            Flags  Mask    Iface
```
<br>
As of now, these network namespaces have no network connectivity, they have no interfaces of their own and they cannot see the underlying host network.<br>
To connect a network namespace to the underlying host or to connect two network namespaces we can create and use a virtual ethernet cable called Pipe.<br>
The pipe acts like a virtual cable with 2 interfaces on each of the ends.
To create a Pipe, we need to create with both the ends defined as below:

```# ip link add veth-red type veth peer name veth-blue```

The next step is to attach the interfaces to their respective namespaces. 
```
# ip link set veth-red netns red
# ip link set veth-blue netns blue
```

We can then assign IP addresses to each of these namespaces. 
```
# ip -n red addr add 192.168.15.1 dev veth-red
# ip -n blue addr add 192.168.15.2 dev veth-blue
# ip netns exec red ping 192.168.15.2
```
The above set up should have set the IP address to the virtual ethernet ports of the namespaces.<br>
The above set up also stands good when dealing with just 2 containers, however, usually we may have more than a few virtual instances within each host and we would need each of these hosts to communicate with each other.<br>
To allow multiple instances within a server communicate with each other on their own ethernet addresses, we need to create a switch.<br>
There are many apps which can do this for us, like
1. Linux Bridge
2. Open V-Switch
In this case, our switch is a Linux Bridge. To create a bridge:<br>
```
# ip link add v-net-0 type bridge
# ip link set dev v-net-0 up
```
The v-net-0 interface behaves like a switch within the virtualization environment, allowing instances to communicate with each other.<br>
Now running the ip link command on the host, will display the bridge as an interface for us.<br>
![271572711-ec04b65f-65b5-42d9-a4d](https://github.com/pyvivid/K8S-References/assets/94853400/c0374b93-7b69-4153-b0df-d3d95bf877f8)<br>
<br>
```
# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state
   UNKNOWN mode DEFAULT group default qlen 1000
   link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
   fq_codel state UP mode DEFAULT group default qlen 1000
   link/ether 02:0d:31:14:c7:a7 brd ff:ff:ff:ff:ff:ff
6: v-net-0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state UP
   mode DEFAULT group default qlen 1000
   link/ether 06:9d:69:52:6f:61 brd ff:ff:ff:ff:ff:ff
```
Now with the Bridge network in place, we can have the Virtual Instances connect to each other via the bridge.<br>
So, we can now delete the eth0 interfaces, which we had created earlier. Deleting one veth, like veth-red, will also delete the veth-blue, since they are a pair.<br>
```# ip -n red link del veth-red```
Now, we can create virtual connection from the network namespace to the Bridge like:<br>

```# ip link add veth-red type veth peer name veth-red-br```
The veth-red is the interface on the namespace, while the veth-red-br is the interface on the switch within the switch.

Repeat the same process for the blue interface also.
Remember, we still have to attach the other end to the bridge network, which can be done by:
```
# ip link set veth-red netns red
# ip link set veth-red-br master v-net-0
# ip link set veth-blue netns blue
# ip link set veth-blue-br master v-net-0
```
We can now assign IP addresses to the interfaces:<br>
```
# ip -n red addr add 192.168.10.1 dev veth-red
# ip -n blue addr add 192.168.10.2 dev veth-blue
```
Assuming we have all the 4 namespaces now created and connected to the bridge network and they all communicate with each other.
They all have IP addresses of 192.168.10.1..4.
The node within which all the instances are running is currently on 192.168.1.2. 
Though the namespaces are within the node, the host will not be able to ping the IP addresses of the namespaces newly created on 192.168.10.1..4.
This is because, we haven't assigned an IP address to the bridge, so to do that:
```# ip addr add 192.168.10.5/24 dev v-net-0```
Once the bridge is assigned an IP address, we should be able to ping the bridge from the host.
This is all within the node, and we dont have access to the outside world. 

All access to the outside world, from the internal namespaces will be through the eth0 on the main node/host.<br>

<img title="v-net-0 setup" alt="-v-net-setup" src="https://github.com/pyvivid/diagrams/blob/main/v-net-basics.png">

Now, lets say the interface from the virtual instance/internal namespace wants to reach another physical server, then it looks at its routing table to find the route to that network.
In this case, the interface on the host node of the virtual namespaces serves as the gateway to the outside world for the internal namespaces/virtual instances.
To view the route table of the blue namespaces:
```
# ip netns exec blue ip route add 192.168.1.0/24 via 192.168.15.5
Destination      Gateway         Genmask         Flags Metric Ref  Use Iface
192.168.15.0     0.0.0.0         255.255.255.0   UG    0      0    0   veth-blue
192.168.1.0      192.168.15.5    255.255.255.0   UG    0      0    0   veth-blue
```












