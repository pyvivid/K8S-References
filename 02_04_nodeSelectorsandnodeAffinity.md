# <p style="text-align: center;">Scheduling Pods - nodeSelector and nodeAffinity</p>

# <p style="text-align: center;">Scheduling Pods - nodeSelector</p>

nodeSelector is the simplest way to constrain Pods to nodes with specific labels.<br>
nodeSelectors come in handy when choosing to schedule the pods on a single node classification.<br>
Let us say you have multiple nodes, with some nodes with abundant system resources, while some with limited resource.<br>
We can label the node based on their size such as large, medium or small and use the nodeSelector to place the pod on nodes only with size=large.<br>
For this to be effected, the node has to be labelled as per the sizes discussed earlier.<br>

To label a node:

`# kubectl label node nodename label-key=label-value`<br>
E.g. <br>
`# kubectl label node node01 size=Large`<br>

We can now use this within the pod definition file to place the pods on a specific size.<br>
```ruby
apiVersion: v1
kind: Pod
metadata:
  name: webapp-pod
spec:
  containers:
  - name: webapp-pods-containers
    image: webapp
  nodeSelector:
    size: large
```
# <p style="text-align: center;">Scheduling Pods - nodeAffinity</p>

The nodeSelector and the nodeAffinity features, both does the same job. The nodeAffinity feature provides us with advanced capabilites to limit pod placement on specific nodes, based on complex choice making like placing the pods on large or medium nodes and pods that are not small.<br>

Sample Pod definition file using nodeAffinity:<br>                                               
![8](https://github.com/pyvivid/K8S-References/assets/94853400/7ddb2b80-8c80-4bb2-85c3-5f9500e307fd)  

 Sample Pod definition file using podAffinity:<br>
![image](https://github.com/pyvivid/K8S-References/assets/94853400/7b310c46-989d-477f-a1a5-1cd6c481b0a0)

Notice the spec.affinity.nodeAffinity:

- `requiredDuringSchedulingIgnoredDuringExecution` = The scheduler can't schedule the Pod unless the rule is met.
- `preferredDuringSchedulingIgnoredDuringExecution` = The scheduler tries to find a node that meets the rule. If a matching node is not available, the scheduler still schedules the Pod.
- `requiredDuringSchedulingRequiredDuringExecution` - Upcoming, not yet implemented

The Structure of using nodeAffinity is as: spec.affinity.nodeAffinity.requireDuringSchedulingIgnoreDuringExecution.matchExpresssions.key, operator, values.
-matchExpressions = List
-values = List

Acceptable operator values are:

You can use the operator field to specify a logical operator for Kubernetes to use when interpreting the rules. 
You can use 
 + In
 + NotIn
 + Exists
 + DoesNotExist
 + Gt and Lt.

The Structure of using podAffinity is as: spec.affinity.podAffinity.requiredDuringSchedulingIgnoredDuringExecution.-labelSelector.matchExpressions.-key, operator, values: -store.




