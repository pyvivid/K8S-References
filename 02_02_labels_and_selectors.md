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

