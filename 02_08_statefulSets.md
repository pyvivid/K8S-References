# <p style="text-align: center;">Stateful Sets in Kubernetes</p>

Stateful Sets are used to manage stateful applications.<br>
Stateful Sets manages the deployment and scaling of a set of Pods, and provides guarantees about the ordering and uniqueness of these Pods.<br>
Unlike a Deployment, a StatefulSet maintains a sticky identity for each of its Pods. <br>
These pods are created from the same spec, but are not interchangeable: each has a persistent identifier that it maintains across any rescheduling.<br>

## Storage Volumes and Pods:

If you want to use storage volumes to provide persistence for your workload, you can use a StatefulSet as part of the solution. 
Although individual Pods in a StatefulSet are susceptible to failure, the persistent Pod identifiers make it easier to match existing volumes
to the new Pods that replace any that have failed.

## StatefulSet Use cases:

StatefulSets are valuable for applications that require one or more of the following.
+ Stable, unique network identifiers.
+ Stable, persistent storage.
+ Ordered, graceful deployment and scaling.
+ Ordered, automated rolling updates.<br>



  
