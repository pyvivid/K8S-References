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





