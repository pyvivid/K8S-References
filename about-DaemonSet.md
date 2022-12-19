> With the help of ReplicaSets and deployments we made sure multiple copies of our applications are available across various different worker nodes.

> DaemonSets are like ReplicaSets, as in it helps you deploy multiple instances of pods. But it runs one copy of your pod on each node in your cluster.

> Whenever a new node is added to the cluster, a replica of the pod is automatically added to that node.

> And when a node is removed the pod is automatically removed.