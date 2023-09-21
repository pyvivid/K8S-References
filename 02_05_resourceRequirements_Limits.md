# <p style="text-align: center;">Scheduling Pods - resourceRequirements_and_Limits</p>

Each worker node in the Kubernetes Cluster, has a set of resources assigned to them. <br>
Each of the pods that will positioned within these nodes, will be consuming those resources such as CPU and memory mainly.<br>
When the scheduler plans on positioning the pods on the nodes, will take into consideration the amount of resrources available on each of these nodes, before placing them.<br>
If the scheduler is unable to find a suitable pod to position the pod due to capacity constraints, then the pod will remain in a pending state.<br>
By default each of the pod is assigned 0.5 CPU and 256 mebibyte of memory. This is the minimum amount of CPU and memory request by the container.A mebibyte equals 220 or 1,048,576 bytes.<br>
For that default values to be applied, those values needs to be set in the namespace by creating a LimitRange.<br>
Each of the container will be having 
+ Resource Requests.
+ Resource Limits.<br>

A sample usage is as below:<br>

![image](https://github.com/pyvivid/K8S-References/assets/94853400/2a1b3cfc-23dd-4aed-ad03-5281e9a283fb)

A few points to remember:
+ G is Gigabyte, which equals to 1000 MB.
+ Gi is Gibibyte, which equals to 1024 MB.
+ CPU increments does not have to be in increments of 0.5, and can be even as low as 0.1.
+ 0.1 is the lowest value of CPU that can be assigned.
+ 0.1 has to be expressed as 100m.
+ The CPU cannot go lower than 1m.
+ By default Kubernetes limits the CPU to 1 vCPU per container, if not set explicitly.
+ One count of CPU = 1 vCPU. One Core in GCP or Azure or one hyper-thread.
+ As for memory, we can specify minimum of 256Mi or use the G for Gigabyte.
+ The default memory is 512MiB for each container thats deployed on each node.
+ If a pod tries to consume more memory than its limit constantly, the pod will be terminated.

