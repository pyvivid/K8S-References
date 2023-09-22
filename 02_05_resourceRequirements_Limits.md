# <p style="text-align: center;">Scheduling Pods - resourceRequirements_and_Limits</p>

## Resource Requests and Limits:

Each worker node in the Kubernetes Cluster, has a set of resources assigned to them. <br>
Each of the pods that will positioned within these nodes, will be consuming those resources such as CPU and memory mainly.<br>
When the scheduler plans on positioning the pods on the nodes, will take into consideration the amount of resrources available on each of these nodes, before placing them.<br>
If the scheduler is unable to find a suitable pod to position the pod due to capacity constraints, then the pod will remain in a pending state.<br>
By default each of the pod is assigned 0.5 CPU and 256 mebibyte of memory. This is the minimum amount of CPU and memory request by the container.A mebibyte equals to 1,048,576 bytes(1024 x 1024).<br>
For that default values to be applied, those values needs to be set in the namespace by creating a LimitRange.<br>
The LimitRange is yet another definition file for a specific namespace, to define the default CPU and Mem of each containers within the namespace.<br>
Each of the container will be having 
+ Resource Requests = Actual used resource.
+ Resource Limits = Allowed resource limit.<br>

A sample usage is as below:<br>
```ruby
apiVersion: v1
kind: Pod
metadata:
  name: frontend
spec:
  containers:
  - name: app
    image: images.my-company.example/app:v4
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
  - name: log-aggregator
    image: images.my-company.example/log-aggregator:v6
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```

A few points to remember:
+ **G is Gigabyte**, which equals to 1000 MB while **Gi is Gibibyte**, which equals to 1024 MB.
+ By default a container has ono limits on the amount of resources that it can consume off a node.
+ When assiging CPU limits and resources, the CPU increments does not have to be in increments of 0.5, and can be even as low as 0.1.
+ 'm' stand for milli. 0.1 has to be expressed as 100m.
+ 1m is the lowest value of CPU that can be assigned. 
+ The CPU cannot go lower than 1m. 
+ By default Kubernetes limits the CPU to 1 vCPU per container, if not set explicitly.
+ One count of CPU = 1 vCPU. One Core in GCP or Azure or one hyper-thread.
+ As for memory, we can specify minimum of 256Mi or use the G for Gigabyte.
+ The default memory is 512MiB for each container thats deployed on each node.
+ If the limits are set on a container and if it tries to consume resources more than the allowed limit constantly, the pod will be terminated.
+ If no requests are set and limit is set, then the value of the limit is also the value of the request.

## Setting the LimitRange for a nameSpace:

Step 1: Create a LimitRange.yaml file as below:

```ruby
apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-limit-range
spec:
  limits:
  - default:
      cpu: 1
    defaultRequest:
      cpu: 0.5
    max:
      cpu: "1"
    min:
      cpu: 100m
    type: Container
```
 
Step 2: Apply the LimitRange for the specific namespace:

`kubectl apply -f https://k8s.io/examples/admin/resource/cpu-defaults.yaml --namespace=default-cpu-example`

## Resource Quotas:

We can create resource quotas to restrict the total amount of resources that can be consumed bu applications in a kubernetes cluster.
### Resource Quota is a namespace level object and can be created to set hard limits.

Sample Resource Quota Limit:

```ruby
apiVersion: v1
kind: ResourceQuota
metadata:
  name: dev-resource-quota
spec:
  hard:
    requests.cpu: 4
    requests.memory: 4Gi
    limits.cpu: 10
    limits.memory: 10Gi
```

