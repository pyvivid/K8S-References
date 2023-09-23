# <p style="text-align: center;">Kubernetes Storage Management</p>

## Container Storage Interface<br>

In the early days, the Docker Container runtime engine was the go to CRI for the Kubernetes. All the codes required to run the Docker Containers were already embedded into the
Kubernetes Codes.
With other container engines such as rkt and cri-o coming in, it was important to accomodate them into the container runtime interface.
The CSI or the Container Storage Interface is the standard that defines how an orchestration solution like Kubernetes would communicate with container runtimes like Docker.
So in the future when a new container runtime interface is developed, they can simply follow the CRI standards and their solutions will work without any new code additions.
It is important that the new CRI developers, adhere to the CRI/CSI/CNI standards for their products to work seamlessly in a Kubernetes Environment.
So to support CSI the new developers will have to create plugins based on the CNI standards and they would simply work together with the Kubernetes solution.
Note CSI is not a Kubernetes specific standard and if implemented would allow any container orchestration tool would allow any storage vendor to work with any supported plugin.
Currently Kubernetes, Cloud Foundry and Mesos support CSI.
**A CSI typically defines:**
+ set of RPCs that will be called by the container orchestrator and these must be implemented by the storage driver.
+ Example, CSI says that when a pod is created and requires a volyme, the container orchestrator in this case Kubernetes, should create volume RPC and pass set of details such
  as the volume name. The Storage driver should implement this RPC on the storage array and return the results of the operation.
+ Similarily, when the container orchestrator calls the Delete Volume RPC, then the storage driver should implement the code to remove the volume.

## Volumes in Kubernetes:

Docker containers are transient in nature meaning they are short lived. They are called when they need to process data and destroyed once the work is completed.
Like wise the data within the containers is also deleted, when the container which handled the data is destroyed.
For more details on Persistent Volumes in Docker Containers, Check out the persistent volume management in Dockers in section 03_01.


