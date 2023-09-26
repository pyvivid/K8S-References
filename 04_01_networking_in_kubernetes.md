# <p style="text-align: center;">Networking in Kubernetes - Prerequisites</p>

## Networking Basics:

To check if the communication between 2 systems are fine, a ping command will do, however, both the systems should be on the same network:<br>
```# ping 192.168.1.10```

When we need 2 computers to talk to each other, a switch is the device that creates the network between the 2 devices.<br>
To connect the computer to the switch, we need an inteface on each host and each of these hosts can be physical or virtual.<br>
To view the interfaces available on a linux host, use(some may be physical or virtual):<br>
```
ubuntu $ ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether f2:05:f6:3f:86:80 brd ff:ff:ff:ff:ff:ff
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:38:d5:45:ab brd ff:ff:ff:ff:ff:ff
```
<br>

To view the IP addresses assigned to each of the physical or virtual ports:<br>
```
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
To assign an IP addr to a specific port:<br>
```# ip addr add 192.168.1.10/24 dev eth0```

Now, lets say, if we have 2 networks and we need to allow both the networks to communicate with each other, the device is a router:
![image](https://github.com/pyvivid/K8S-References/assets/94853400/5495e987-f2b7-41f9-9ca3-ab22ea7b890d)<br>
A router:
+ Allows to connect 2 networks together
+ A router connects and presents itself as an individual device in each of the network it connects to and hence will have a IP assigned to it from each of the network it is connected.

Now as in the above diagram, lets say, System C wants to connect to System A, and like the router there can be numerous other devices within the network.<br>
This is where **Gateway** comes in. If the Network was the room, then the Gateway is the door to the outside world, which can simply be other networks or to the Internet.<br>
The systems within each network needs to know, where the GW is located to go through that.
The exisiting routing configuration can be viewed as below:
```
ubuntu $ route
Kernel IP routing table
Destination      Gateway         Genmask         Flags Metric Ref    Use Iface
default          192.168.1.1     0.0.0.0         UG    0      0        0 enp1s0
192.168.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0
192.168.1.0      0.0.0.0         255.255.255.0   U     0      0        0 enp1s0
ubuntu $
```
The above is the kernel's routing table on a single machine within the networks.
If there are no routing configurations available then we can add routes as below:<br>
```# ip route add 192.168.2.0/24 via 192.168.1.1```<br>
The above command will let know all the machines in the 2.0 network to reach to machines in the 1.0 network via 192.168.1.1. 
From above, this seems like we have to add the route on all systems within the 2.0 network to have this knowledge. Also for the machines in the 2.0 network to
communicate to the outside world(internet, after connecting the router to internet, we add a route to the routing table entry. This looks quite tedious task, right.
Instead, we can say, 
```# ip route add default via 192.168.2.1``` <br> or <br>
```# ip route add 0.0.0.0/0 via 192.168.2.1```<br>
notice the default replaced by 0.0.0.0/0
which tells the machines in the 2.0 network, that for any communications to the outside world or other network, use the 192.168.2.1 gateway.






