# <p style="text-align: center;">Understanding Docker Networking</p>

Lets say we have a machine with Docker installed on it. The machine has 1 eth0 interface attached to it, with an ip address of 192.168.1.10.
This machine is hosting a webserver, that is reachable on port 80. 
Now when hosting the Docker engine, we have multiple network options to use.

### Option 1:
With the **NONE** network, the docker containers created within the host are not connected to any network, they cannot reach the outside world and are not reachable from the outside world.
### Option 2:
With the **HOST** Network, the containers are attached to the host's network and there is no isolation within the hosts container.
If we deploy a web application listening on port 80 on the host, then no other container can use the same port for accepting incoming connections
### Option 3:
With the **Bridge** network option, other than the eth0 a virtual network is created within the host, which the Docker containers can attach to.
![p1](https://github.com/pyvivid/K8S-References/assets/94853400/d29bddcf-a418-45ba-88ff-10dfe24e68c0)<br>
Now, in the above bridge network, we can see that the bridge network is using the 172.17.0.0 network. All containers attaching to this network, will be assigned a similar IP address range.

When Docker is installed on a host, an internal private network called Bridge is created by default.
This can be viewed by running the below command:
```ruby
ubuntu $ docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
b8493630f96b   bridge    bridge    local
b1033c189d63   host      host      local
0b01716bc8c6   none      null      local
ubuntu $ 
```
This bridge network on the host is created as Docker0. List the interfaces on the host as below:
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
```# ip netns``` 
When a container is created, we can inspect the docker container and see as below:




