# <p style="text-align: center;">Pod Networking in Kubernetes</p>

After having configured our master and worker nodes and their networking, our Kubernetes cluster is soon going to have a large number of Pods and services running on it.
The following are the challenges to be addressed:
+ How are the Pods addressed?
+ How do they communicate with each other?
+ How do you access the services running on these Pods internally from within the cluster, as well as externally from outside the cluster?

As of today, Kubernetes does not come with a built-in solution for this. It expects you to implement a networking solution that solves these challenges.

Kubernetes expects 
+ every Pod to get its own unique IP address,
+ every Pod should be able to reach every other Pod within the same node using that IP address.
+ every Pod should be able to reach every other Pod on other nodes as well, using the same IP address.

It doesn't care what IP address that is and what range or subnet it belongs to. As long as you can implement a solution that takes care of automatically assigning IP addresses
and establish connectivity between the Pods in a node as well as parts on different nodes, you're good, without having to configure any net rules.

So how do we implement a model that solves these requirements? There are many networking solutions which takes care of this such as:
1. Weave works
2. Flannel
3. Cilium
4. VMware NSX
5. Calico, etc.

However, let us understand how to manage them manually.
Let us assume, we have a three node cluster. It doesn't matter which one is master or worker.
They all run Pods, either for management or workload purposes. As far as networking is concerned, we're going to consider all of them as the same.
So first, let's plan what we are going to do.
+ The nodes are part of an external network, and has IP addresses in the 192.168.1. series.
+ Node one is assigned 11, node two is 12, and node three is 13.
+ Next step, when containers are created, Kubernetes creates network namespaces for them.
+ To enable communication between them, we attach these namespaces to a network. But what network?
+ We've learned about bridge networks that can be created within nodes to attach namespaces.
+ So we create a bridge network on each node and then bring them up.
+ It's time to assign an IP address to the bridge interfaces, or networks. But what IP address?
+ We decide that each bridge network will be on its own subnet.
+ Choose any private address range, say, 10.244.1, 10.244.2, and 10.244.3. Next, we set the IP address for the bridge interface.

Next the steps to be performed on the containers:
+ To attach a container to the network we need a pipe, or virtual network cable. We create that using the ip link add command.<br>
  ```# ip link add ...```
+ We then attach one end to the container, and another end to the bridge using<br>
 ```# ip link set ...```
+ We then assign IP address using the ip addr command and add a route to the default gateway.<br>
  ```# ip -n <namepace> addr add ...```<br>
  ```# ip -n <namepace> route add ...```
+ For now, we will assume the IP address of the container on the node1 as 10.244.1.2<br>

