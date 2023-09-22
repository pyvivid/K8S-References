# <p style="text-align: center;">Stateful Sets in Kubernetes</p>

When Deployments cannot satify some app requirements?

Let us say we want to deploy DB pods, with multiple replicas and data synchronisation, the challenges faced are:<br>
+ We require each of these replicas coming up in a specific order, acting as such the first pod is the master node and then a slave1 and then slave2. 
+ Additionally, the data in the DB pod should be synchronized to the volume attached to DB Slave1 and then to DB Slave2.
+ With deployments, when we start a deployment all the pods come up at the same time.
+ To address the above issue a Constant Hostname or IP Address will be required to address the fact, that the . However, Deployment cannot give a constant IP addr, since every time a pod is recreated, it recevies a new IP address and also not a static hostname.

To address the above challenges we use Stateful Sets.<br>
+ Stateful Sets are used to manage stateful applications.<br>
+ Stateful Sets manages the deployment and scaling of a set of Pods, and provides guarantees about the ordering and uniqueness of these Pods.<br>
+ Unlike a Deployment, a StatefulSet maintains a sticky identity for each of its Pods. <br>
+ These pods are created from the same spec, but are not interchangeable: each has a persistent identifier that it maintains across any rescheduling.<br>

## Storage Volumes and Pods:

If you want to use storage volumes to provide persistence for your workload, you can use a StatefulSet as part of the solution. 
Although individual Pods in a StatefulSet are susceptible to failure, the persistent Pod identifiers make it easier to match existing volumes
to the new Pods that replace any that have failed.

## StatefulSet Use cases:

StatefulSets are valuable for applications that require one or more of the following.
+ Ordered Deployment, the first pod is up, running and only then the next pod is started - graceful deployment and scaling.
+ Stateful Sets assign a unique ordinal index to each pods, a number starting from 0 incrementing by 1, combined with the statefulSet name.
+ The above startegy applies to each of the replicas added for scalablity.
+ Stateful Sets maintain a sticky identity for each of their pods.
+ Stable, unique network identifiers.
+ Stable, persistent storage.
+ Ordered, automated rolling updates.<br>




  
