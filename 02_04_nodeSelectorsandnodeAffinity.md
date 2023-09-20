# <p style="text-align: center;">Scheduling Pods - nodeSelector and nodeAffinity</p>

# <p style="text-align: center;">Scheduling Pods - nodeSelector</p>

nodeSelector is the simplest way to constrain Pods to nodes with specific labels.
nodeSelectors come in handy when choosing to schedule the pods on a single node classification.
Let us say you have multiple nodes, with some nodes with abundant system resources, while some with limited resource.
We can label the node based on their size such as large, medium or small and use the nodeSelector to place the pod on nodes only with size=large.
For this to be effected, the node has to be labelled as per the sizes discussed earlier.
To label a node:

`# kubectl label node nodename label-key=label-value`
E.g. 
`# kubectl label node node01 size=Large`

We can now use this within the pod definition file to place the pods on a specific size.
![7](https://github.com/pyvivid/K8S-References/assets/94853400/d3c26507-ea89-4b7c-96ad-b182af60acfd)

