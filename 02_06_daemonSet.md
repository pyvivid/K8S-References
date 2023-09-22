# <p style="text-align: center;">Daemon Sets</p>

Daemon Sets are like ReplicaSets, that allows us to deploy multiple instances of Pods. 
However, it runs one copy of the pod on each node within the cluster.
Whenever a new node is added to the cluster, the Daemon Set is started on the node automatically.
If the Daemon Set fails on any node, it is automatically restarted.

Some typical uses of a DaemonSet are:

+ running a cluster storage daemon on every node
+ running a logs collection daemon on every node
+ running a node monitoring daemon on every node

Creating a Daemon Set is very Similar to creating a Replica Set. The Daemon Set file Structure is very similar to that of ReplicaSet, except the 'kind' is DaemonSet.

Sample DaemonSet Definition File:

```ruby
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: monitoring-daemon
spec:
  selector:
    matchLabels:
      app: monitoring-agent
  template:
    metadata:
      labels:
        app: monitoring-agent
    spec:
      containers:
      - name: monitoring-agent
        image: monitoring-agent
```

Then create the DaemonSet using the definition file

```kubectl apply -f daemonSet-Definition.yaml```


