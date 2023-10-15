# <p style="text-align: center;">Understanding Docker Networking</p>

Lets say we have a server with Docker installed on it. The machine has 1 eth0 interface attached to it, with an ip address of 192.168.1.10.
This machine is hosting a webserver, that is reachable on po rt 80. 
Now when hosting the Docker engine, we have multiple network options to use for the containers.

### Option 1 - None Network:
With the **NONE** network, the docker containers created within the host are not connected to any network, they cannot reach the outside world and are not reachable from the outside world. The container is not reachable internally or externally.

### Option 2 - Host Network:
With the **HOST** Network, the containers are attached to the host's network and there is no isolation within the hosts container. There is no port mapping involved here.
If we deploy a web application listening on port 80 on the host, then no other container can use the same port for accepting incoming connections.<br>

### Option 3 - Bridge Network:
With the **Bridge** network option, other than the eth0 a virtual network is created within the host, which the Docker containers can attach to.
![p1](https://github.com/pyvivid/K8S-References/assets/94853400/d29bddcf-a418-45ba-88ff-10dfe24e68c0)<br>
Now, in the above bridge network, we can see that the bridge network is using the 172.17.0.0 network. All containers attaching to this network, will be assigned a similar IP address range.

When Docker is installed on a host, an internal private network called **Bridge** is created by default.
This can be viewed by running the below command:
```ruby
ubuntu $ docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
b8493630f96b   bridge    bridge    local
b1033c189d63   host      host      local
0b01716bc8c6   none      null      local
ubuntu $ 
```
**Note: This bridge network on the host is created as Docker0. **

List the interfaces on the host as below:
```ruby
ubuntu $ ifconfig
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:38:d5:45:ab  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

enp1s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1460
        inet 172.30.1.2  netmask 255.255.255.0  broadcast 172.30.1.255
        ether f2:05:f6:3f:86:80  txqueuelen 1000  (Ethernet)
        RX packets 362254  bytes 507823162 (507.8 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 41571  bytes 18096644 (18.0 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 329  bytes 41230 (41.2 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 329  bytes 41230 (41.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```
Basically what has happened is that, when the Docker was installed, a link was added as below:
```
# ip link add docker0 type bridge
```
Remember, the bridge in the ```# docker network ls``` command refers to the ```docker0``` on the host.
Also note, the bridge is like an interface to the host, but acts like a switch the containers within the host.
So, whenever a container is created, Docker creates a network namespace for it. We can view the network namespaces created using the command:
```
# ip netns
b3165c10a92b
``` 
When a container is created, we can inspect the docker container and see as below:
```
# docker inspect 97efg80e565d8
NetworkSettings": {
           "Bridge": "",
           "SandboxID": "b3165c10a92b50edce4c8aa5f37273e180907ded31",
           "SandboxKey": "/var/run/docker/netns/b3165c10a92b",
```
To further verify this(remember a virtual cable was created, connecting one end to the bridge and another to the container namespace).
First run 
```
root@dock-ser:/home/ubuntu# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 42:01:0a:80:00:14 brd ff:ff:ff:ff:ff:ff
    altname enp0s4
3: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:2f:72:92:a5 brd ff:ff:ff:ff:ff:ff
5: **veth5e6a709@if4:** <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue **master docker0** state UP mode DEFAULT group default 
    link/ether 12:9b:11:ea:dd:c3 brd ff:ff:ff:ff:ff:ff link-netnsid 0
```
Notice the veth5e6a709@if4 was created and usual one end is attached to the Docker Network Bridge(to be understood like a virtual switch) and the other end is connected to the container as usual.
Notice the output of ip link above at option 5, where one end is denoted as attached to the docker 0.
Now if we run the below command, we can see the other end attached to the pipe as below:
```
# ip -n <netns_output> link
7: eth0@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT
group default
   link/ether 02:42:ac:11:00:03 brd ff:ff:ff:ff:ff:ff link-netnsid 0
```
![p1](https://github.com/pyvivid/K8S-References/assets/94853400/6ce7c5d1-18e0-478f-a3c2-ddc12e2f225d)

To view the IP address of the virtual port attached to the container:
```
# ip -n br3165c10a92b addr
7: eth0@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UP group default
     link/ether 02:42:ac:11:00:03 brd ff:ff:ff:ff:ff:ff link-netnsid 0
     inet 172.17.0.3/16 brd 172.17.255.255 scope global eth0
        valid_lft forever preferred_lft forever
```
The same procedure is replicated each time a container is created. 
+ Docker creates a namespace.
+ creates a pair of interfaces.
+ attaches one end to the container and another end to the bridge network.
  
![Picture1](https://github.com/pyvivid/K8S-References/assets/94853400/5c73e11c-a782-4cf6-bf21-588711fdd5a8)

Review the image carefully, the interface pairs can be identified by their number. The Bridge end interface has 9, while the container end had 10.
Odd and even form a pair.</br>
Now the containers can communicate with each other within the host and within the Docker network and yet the containers are not accessible from the outside world. To allow the containers to be accessible from the outside world, we use port mapping feature of the Docker.</br>
Lets say if you are running an nginx server, then you perform port mapping, like</br>
``` # docker run -itd --name nginx -p 8080:80 nginx```
Tbe above command will map the port 8080 of the host to the port 80 of the container. If fro within the host, we try to access the nginx container which we spin up earlier, we should be getting a response from the nginx server. However, if you tro access the container from outside the host, it will not be reachable.</br>
This is where the port mapping feature comes in. Notice the -p 8080:80 option used, where the incoming connecting to the port 8080 of the host are routed to the port 80 of the container running the nginx server.</br>

The NAT rules are created using iptables to achieve the above of routing traffic from 8080 to 80. The iptables rule should look similar to as below:
```
iptables \
  –t nat \
  -A PREROUTING \
  -j DNAT \
  --dport 8080 \
  --to-destination 172.17.0.3:80
```
We can list and check on the iptables as below:
```
# iptables -nvL -t nat
Chain DOCKER (2 references)
target	prot opt source                destination
RETURN  all	--	anywhere       anywhere
DNAYT   tcp	--	anywhere       anywhere           tcp dpt:8080 to 172.17.0.2:80
```
             











     









