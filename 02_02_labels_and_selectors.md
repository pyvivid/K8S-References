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
![1](https://github.com/pyvivid/K8S-References/assets/94853400/9351c908-ed4e-4c00-855f-d020f4772feb)<br>
To put the selector to use, test using the following command.<br>
+ `# kubectl get pods --show-labels`
+ `# kubectl get pods --selector app=App1`
+ `# kubectl get pods --selector rel=dev`
+ `# kubectl get pods --selector app=App1,rel=dev`<br>
<br>
![2](https://github.com/pyvivid/K8S-References/assets/94853400/a38008cc-48c5-4c48-8f51-604b0efdc224)



