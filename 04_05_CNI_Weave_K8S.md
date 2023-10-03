### CNI Weave in Kubernetes

CNI defines the responsibilities of container run time as per CNI container run times.
Kubernetes is responsible for creating container network name spaces, identifying and attaching those name spaces to the right network by calling the right network plugin.
The CNI plugin must be invoked by the component within Kubernetes that is responsible for creating containers because that component must then invoke the appropriate network plugin after the container is created.
The CNI plugin is configured in the kubelet service on each node in the cluster.
If you look at the kubelet Service file you will see an option called network plugin set to CNI. You can see the same information on viewing the Running kubelet service.
You can see the network plugin set to CNI and a few other options related to CNI, such as the CNI bin directory and the CNI conflict directory.
+ The CNI bin directory has all the supported CNA plugins as executables, such as the bridge, dscp, flannel, et cetera. 
+ The CNI conflict directory has a set of configuration files. This is where the kubelet looks to determine which plugin to be used.

By Default all CNI binaries are located under the /opt/cni/bin path.

### How Weave Works

Weave deploys an agent or a service on each node within the cluster.
These agents exchange information regarding the nodes, networks and pods within them.
Each agent within the setup, stores information regarding the entire topology of the setup, that way they know their pods and nodes in the entire cluster.
Weave creates its own bridge and the nodes, assigns IP addresses to each network.
Note: A single pod may be attached to multiple bridge networks, multiple Weave Bridge or Docker Bridge.
What path the packet takes to reach the destination depends on the route configured on the container.

Weave and Weave peers can be deployed as services or daemons on each node in the cluster manually or if the Kubernetes is setup already, it can be deployed as pods in the cluster.<br>
Once the base Kubernetes system is ready with nodes and networking configured correctly between the node and the basic control plane components are deployed, Weave can be deployed in the cluster  with a single kubectl apply command.
```
# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64
| tr -d '\n')"
serviceaccount/weave-net created
clusterrole.rbac.authorization.k8s.io/weave-net created
clusterrolebinding.rbac.authorization.k8s.io/weave-net created
role.rbac.authorization.k8s.io/weave-net created
rolebinding.rbac.authorization.k8s.io/weave-net created
daemonset.extensions/weave-net created
```
The Weave peers are deployed as Daemon Sets, and the Daemonsets ensures that one Weave Pod is always running on all nodes at all times.

## IP Address Management in Weave:

Let us now focus on

+ How the virtual Bridge networks in the nodes assigned an IP subnet?
+ How pods are assigned an IP?
+ Where is this information stored?
+ Who is responsible for ensuring that no duplicate IPs are assigned?

It is the responsibility of the CNI solutions to assign IP address to the containers.
The core solution is to maintain a list of IPs already assigned to the containers, to ensure they are not duplicated. This is the responsibility of the CNI.
The CNI comes with 2 plugins, which will take care of this task.
1. host-local plugin:
   + It is our responsibility to invoke that plugin.
   + 
2. 
The CNI configuration file located at ```/etc/cni/net.d/net-script.conf``` file has the IPAM config, where we can specify the type of plugin, subnet and route to be used.<br>


