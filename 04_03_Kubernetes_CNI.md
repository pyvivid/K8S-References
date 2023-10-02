# <p style="text-align: center;">Kubernetes - Container Networking Interface</p>

So far, we saw how network name spaces work, as in, 
1. how to create an isolated network namespace environment within our system,
2. we saw how to connect multiple such name spaces through a bridge network,
3. how to create virtual cables or pipes with virtual interfaces on either end,
4. how to attach each end to end name space and the bridge
5. how to assign IP and bring them up
6. enable NAT or IP masquerade for external communication, et cetera.

Docker containers too follow a similar methodologies in managing their network within a host. Other Containerization solutions like Rkt and Mesos also function in a similar way. 
Instead of each of these containerization tools having to develop their own programs and tools to do the same job, why not create a program or script that performs all the required tasks to get the 
container attached to a bridge network. The "bridge" program is an example of the above solution, where running a command like:
```# bridge add 15ftyh76u /var/run/netns/15ftyh76u```
when a new container is created, they call the bridge program and pass the container ID and the namespace to get the networking configured for the container.

The CNI is a standard that defines how a program should look, how container run times will invoke them so that everyone can adhere to a single set of standards and develop solutions that work across run times.<br>
That's where container network interface comes in. The CNI is a set of standards that define how programs should be developed to solve networking challenges in a container runtime environments.<br>
These programs are referred to as plugins and in this case, Bridge program that we have been referring to is a CNI plugin.
CNI defines 
+ how the plugin should be developed
+ how container run times should invoke them.
+ a set of responsibilities for container run times and plugins.

For container run times, CNI specifies that 
+ it is responsible for creating a network name space for each container.
+ It should then identify the networks the container must attach to,
+ container run time must then invoke the plugin when a container is created using the add command and also invoke the plugin when the container is deleted using the del command.
+ It also specifies how to configure a network plugin on the container runtime environment using a JSON file.<br>

On the plugin side, it defines that the plugin should 
+ support add, del and check command line arguments
+ that these should accept parameters like container and network namespace.
+ should take care of assigning IP addresses to the pods
+ Any associated routes required for the containers to reach other containers in the network.

Any run time should be able to work with any plugin. CNI comes with a set of supported plugins already such as Bridge, VLAN, IP VLAN, MAC VLAN, one for Windows
as well as IPAM plugins like Host Local and DHCP.
A list of other 3rd party plugins are:
1. Weave
2. Flannel
3. Cilium
4. VMWare NSX
5. Calico
6. Infoblox
to name a few.

All of these container run times implement CNI standards so any of them can work with any of these plugins. But there is one that is not in this list.
Docker.
Docker does not implement CNI.
Docker has its own set of standards known as CNM which stands for container network model which is another standard that aims at solving container networking challenges
similar to CNI but with some differences. But that doesn't mean you can't use Docker with CNI at all. You just have to work around it yourself.<br>

For example, create a Docker container without any network configuration and then manually invoke the bridge plugin yourself.
That is pretty much how Kubernetes does it. When Kubernetes creates Docker containers, it creates them on the non-network.
It then invokes the configured CNI plugins who take care of the rest of the configuration.

### Networking Configurations required on the Master and Worker Nodes of the Kubernetes Cluster:

Each node must have at least one interface connected to a network.
Each interface must have an address configured.
The hosts must have a unique host name set, as well as a unique MAC address.
You should notice, especially if you created the VMs by cloning from existing ones.
There are some ports that needs to be opened as well. These are used by the various components in the control plane.<br>
The master should accept connections on **6443 for the API server**.<br>
The worker nodes, kubectl tool, external users, and all other control plane components access the Kube API server via this port.<br>
The **Kubelets** on the master and worker nodes **listen on port 10250**.
The **kube-scheduler** requires port **10251** to be open.<br>
The **kube-controller-manager** requires port **10252** to be open.<br>
The **worker nodes expose services** for external access on ports **30000 to 32767**, so these should be open as well.<br>
Finally, the **etcd server listens on port 2379**.<br>

If you have multiple master nodes, all of these ports need to be open on those as well.
And you also need an additional port 2380 open so the etcd clients can communicate with each other.
The list of ports to be opened are also available in the Kubernetes documentation page.
So consider these when you set up networking for your nodes in your firewalls or IP table rules or network security group in a cloud environment, such as GCP or Azure or AWS.
And if things are not working, this is one place to look for while you're investigating.


