# <p style="text-align: center;">Scheduling Pods - Taints and Tolerations</p>

In this section, we will discuss in detail about the pod-to-node relationship and how we can restrict what pods are placed on what nodes.<br>
Taints and Tolerations are used to set restrictions on what pods can be scheduled on a node.<br>
Points to note:<br>

### Taints are set on nodes.<br>
### + Tolerations are set on pods.<br>

`# kubectl taint nodes node-name key=value:taint-effect`<br>
`# kubectl taint node node01 app=blue:NoSchedule`

### Taint-effects:
+ NoSchedule = Pods will not be placed at all on this node
+ PreferNoSchedule = Pods will not be placed, but not guaranteed
+ NoExecute = New Pods will not be scheduled on this node and existing pods will be evicted, if the already running pods, do not tolerate the taint.

Sample Definition file:<br>
![5](https://github.com/pyvivid/K8S-References/assets/94853400/102e057e-24ec-4c2c-aced-f872f3466a75)<br>

The values Key, Operator, value and effect should all be enclosed within quotes as in the above image.<br>

### Use case scenario 1:<br>

There are 3 worker nodes and 4 pods.<br>
We allow any pod to be scheduled on any of the 3 nodes and the pods are spread equally across the nodes.<br>

### Use case scenario 2:<br>

In node 1, to accomodate a specific type of an app, we have provisioned the node with more resources and we want only the pods of the specific app to be scheduled on this node 1.<br>
By default pods have no tolerations.We can prevent pods from being scheduled on a node, by placing a taint on the node.<br>
Once a node is tainted, no pods can be scheduled on it.<br>
**Part 1:** Lets assume that node 1 is now tainted and no pods can be placed on it, unless the pod can tolerate the taint.<br>
**Part 2:** We need to enable certain pods to be placed on the node and the pods are tolerant to this particular taint. Assume that pod A is only to be allowed to be placed on the node 1, 
then a toleration is placed on Pod A. Now when the scheduler, tries to place the pod A on node 1, it will be scheduled successfully.<br>
**Part 3:** Though the Pod A is set with a toleration on node 01, the pod A, may be still be placed on node02 or node03, since the node02 and node03, do not have any taints on them.<br>
Taints and Tolerations, do not tell a pod to go to a particular node, instead, it telss the node to accept only the pods with a certain tolerations.<br>
If we want the pods to be placed on **a particular node only**, then we will have to use **nodeaffinity**.

When a kubernetes cluster is first setup, a taint is to be set on the Master Node automatically.
To see if a taint 

