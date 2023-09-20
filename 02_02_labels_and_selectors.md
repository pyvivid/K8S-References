# <p style="text-align: center;">Scheduling Pods - Labels and Selectors</p>

Labels are properties attached to each item. Each object may have multiple labels attached to them.<br>
Selectors helps us to filter those objects which have labels attached to them.<br>
Labels and Selectors are a standard method of grouping things within the Kubernetes Cluster.<br>

Objects within the Kubernetes may be grouped by their
  + Type = Pods, Deployments or ReplicaSets
  + Application = Payment App, Voting App, Catalogue
  + functionality = frontend, backend<br>
  
Only the following objects support Labels and Selectors:<br>
  + Deployments
  + ReplicaSets
  + DaemonSets
  + Jobs

## Usage example 1:

In a pod definition file, under metadata section, create a section called labels and under the labels add, labels in "key:value" format.<br>
![1](https://github.com/pyvivid/K8S-References/assets/94853400/191749f1-1b77-4989-9749-a3e22c1bd214)<br>
To put the selector to use, test using the following command.<br>
+ `# kubectl get pods --show-labels`
+ `# kubectl get pods --selector app=front-end`
+ `# kubectl get pods --selector rel=dev`
+ `# kubectl get pods --selector app=front-end,rel=dev`<br>
![2](https://github.com/pyvivid/K8S-References/assets/94853400/d7a1f2a6-f3b6-4497-9b58-5fe8cbe9f599)<br>

## Usage example 2:

Kubernetes uses labels and Selectors to connect different objects together.<br>
Now that the pods have been created with labels, we can use the selectors within the replicaSet to group the pods.<br>
Important point to note:<br>

+ The labels in the metadata of the replicaset does not add value at the moment, however will be put to use only when we configure someother object, to discover the replicaSet.
+ We need to focus on getting the replicaSet to discover the pod.
+ All the pods which match the label tier:front-end, will be a part of the replicaset.
+ The label in the pod template and the selector section of the spec must match.<br>
  
![3](https://github.com/pyvivid/K8S-References/assets/94853400/30e0e011-1cd3-4eb7-8577-4241e76f86a4)<br>






