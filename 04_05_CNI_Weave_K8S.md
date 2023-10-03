### CNI Weave in Kubernetes

CNI defines the responsibilities of container run time as per CNI container run times.
Kubernetes is responsible for creating container network name spaces, identifying and attaching those name spaces to the right network by calling the right network plugin.
The CNI plugin must be invoked by the component within Kubernetes that is responsible for creating containers because that component must then invoke the appropriate network plugin after the container is created.
The CNI plugin is configured in the kubelet service on each node in the cluster.
If you look at the kubelet Service file you will see an option called network plugin set to CNI. You can see the same information on viewing the Running kubelet service.
You can see the network plugin set to CNI and a few other options related to CNI, such as the CNI bin directory and the CNI conflict directory.
+ The CNI bin directory has all the supported CNA plugins as executables, such as the bridge, dscp, flannel, et cetera. 
+ The CNI conflict directory has a set of configuration files. This is where the kubelet looks to determine which plugin to be used.
