# <p style="text-align: center;">Scheduling Pods - Labels and Selectors</p>

Labels are properties attached to each item. Each object may have multiple labels attached to them.<br>
Selectors helps us to filter those objects which have labels attached to them.<br>
Labels and Selectors are a standard method of grouping things within the Kubernetes Cluster.<br>

Objects within the Kubernetes may be grouped by their
  + Type = Pods, Deployments or ReplicaSets
  + Application = Payment App, Voting App, Catalogue
  + functionality = frontend, backend<br>

## Usage Scenario 1:

In a pod definition file, under metadata section, create a section called labels and under the labels add, labels in "key:value" format.<br>
![1](https://github.com/pyvivid/K8S-References/assets/94853400/191749f1-1b77-4989-9749-a3e22c1bd214)<br>
To put the selector to use, test using the following command.<br>
+ `# kubectl get pods --show-labels`
+ `# kubectl get pods --selector app=front-end`
+ `# kubectl get pods --selector rel=dev`
+ `# kubectl get pods --selector app=front-end,rel=dev`<br>
![2](https://github.com/pyvivid/K8S-References/assets/94853400/d7a1f2a6-f3b6-4497-9b58-5fe8cbe9f599)<br>

## Usage Scenario 2:

Kubernetes uses labels and Selectors to connect different objects together.<br>
Now that the pods have been created with labels, we can use the selectors within the replicaSet to group the pods.<br>
Important point to note:<br>

+ The labels in the metadata of the replicaset does not add value at the moment, however will be put to use only when we configure someother object, to discover the replicaSet, which we will see in the Usage Scenario #3.
+ We need to focus on getting the replicaSet to discover the pod.
+ The Selector specified within the **spec.selector.matchlabels** must match the pod **spec.template.metadata.labels**
+ All the pods which match the label tier:front-end, will be a part of the replicaset, which is reflected in "spec.template.metadata.lables"
+ The label in the pod template and the selector section of the spec must match.<br>
  
![3](https://github.com/pyvivid/K8S-References/assets/94853400/30e0e011-1cd3-4eb7-8577-4241e76f86a4)<br>

## Usage Scenario 3:

Assuming the pods have been created and so are the replicas, we now want to position a service in front of the pods within the replicaSet.
To achieve this:
+ We need to create a service definition file in such a way, that the spec.selector.app:App1 must match the spec.template.metadata.labels.app:App1<br>
![4](https://github.com/pyvivid/K8S-References/assets/94853400/7d4a475d-f987-4357-a933-cc0b8b0c1817)









