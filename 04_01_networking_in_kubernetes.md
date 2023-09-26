# <p style="text-align: center;">Networking in Kubernetes - Prerequisites</p>

## Networking Basics:

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
The above is the kernel's routing table on every single machine within the networks.<br>
Lets say we want the Sys B to communicate to SysC add the following route:<br>
```# ip route add 192.168.2.0/24 via 192.168.1.1```<br>
The above command will let know the machines that to reach the machine in the 2.0 network, it has to travel via 192.168.1.1. <br>
Remeber, this has to be configured on all the systems. <br>
From above, this seems like we have to add the route on all systems within the 2.0 network to have this knowledge. Also for the machines in the 2.0 network to
communicate to the outside world(internet, after connecting the router to internet, we add a route to the routing table entry. This looks quite tedious task, right.
Instead, we can say, 
```# ip route add default via 192.168.2.1``` <br> or <br>
```# ip route add 0.0.0.0/0 via 192.168.2.1```<br>
notice the default replaced by 0.0.0.0/0
which tells the machines in the 2.0 network, that for any communications to the outside world or other network, use the 192.168.2.1 gateway.

## DNS Basics:







