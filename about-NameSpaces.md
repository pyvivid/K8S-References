</h3> About NameSpaces </h3>
We've created objects such as pods, deployments, and services in our cluster. 
Whatever we have been doing, we have been doing within a namespace. We were inside a house all this while. 
This namespace is known as the default namespace and it is created automatically by Kubernetes when the cluster is first set up.
Kubernetes creates a set of pods and services for its internal purpose, such as those required by the networking solution, the DNS service, etcetera.
To isolate these from the user and to prevent you from accidentally deleting or modifying these services, Kubernetes creates them under another namespace created at cluster startup named kube-system.
A third namespace created by Kubernetes automatically is called kube-public. This is where resources that should be made available to all users are created.
