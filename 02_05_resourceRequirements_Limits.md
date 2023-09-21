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




