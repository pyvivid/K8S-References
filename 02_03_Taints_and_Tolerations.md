# <p style="text-align: center;">Scheduling Pods - Taints and Tolerations</p>

In this section, we will discuss in detail about the pod-to-node relationship and how we can restrict what pods are placed on what nodes.
Taints and Tolerations are used to set restrictions on what pods can be scheduled on a node.
Points to note:

### + Taints are set on nodes.
### + Tolerations are set on pods.

## Use case scenario 1:

There are 3 worker nodes and 4 pods. 
We allow any pod to be scheduled on any of the 3 nodes and the pods are spread equally across the nodes.

## Use case scenario 2:

In node 1, to accomodate a specific type of an app, we have provisioned the node with more resources and we want only the pods of the specific app to be scheduled on this node 1.
By default pods have no tolerations.We can prevent pods from being scheduled on a node, by placing a taint on the node. 
Once a node is tainted, no pods can be scheduled on it.
**Part 1:** Lets assume that node 1 is now tainted and no pods can be placed on it, unless the pod can tolerate the taint.
**Part 2:** We need to enable certain pods to be placed on the node and the pods are tolerant to this particular taint. Assume that pod A is only to be allowed to be placed on the node 1, 
then a toleration is placed on Pod A. Now when the scheduler, tries to place the pod A on node 1, it will be scheduled successfully.



