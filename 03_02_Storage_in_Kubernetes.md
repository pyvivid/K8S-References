
# <p style="text-align: center;">Kubernetes Storage Management</p>
<p style="text-align: center;">Text_content</p>


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

Earlier to Kubernetes version 1.28, there was support for various external volumes such as AWS EBS, AzureDisk, CephFS, Cinder to name a few, which were directly inbuilt into 
the kubernetes code. However, from version 1.8 onwards, kubernetes suggests we use third party drivers called CSI drivers from the same.
As AWS suggests. CSI drivers replaces the kubernetes 'In-Tree' storage drivers that exists in the Kubernetes Source code.
Detailed volume management documentation can be found on the kubernetes website at this [location](https://kubernetes.io/docs/concepts/storage/volumes/#using-subpath).


## Volumes in Kubernetes:

Docker containers are transient in nature meaning they are short lived. They are called when they need to process data and destroyed once the work is completed.
Like wise the data within the containers is also deleted, when the container which handled the data is destroyed.
For more details on Persistent Volumes in Docker Containers, Check out the persistent volume management in Dockers in section 03_01.
As for the Kubernetes, every volume configuration information goes into the pod definition file.

A Pod can support any number of volumes simultaneously.
To use a volume in a pod, specify the volumes to be used as ```.spec.volumes```, declare where to mount the volumes as ```.spec.containers[*].volumeMounts```.


## Persistent Volumes in Kubernetes:

A persistent volume is a cluster-wide pool of storage volumes configured by an administrator to be used by administrators deploying application within the cluster.
The users can now select storage from the storage pool using persistent volume claims.
PVs are resources in the cluster. PVCs are requests for those resources and also act as claim checks to the resource.

PVs can be provisioned:
  + **Statically:**
    + A cluster administrator creates a number of PVs.
    + They carry the details of the real storage, which is available for use by cluster users.
    + They exist in the Kubernetes API and are available for consumption.
  + **Dynamically:**
    + When none of the static PVs the administrator created match a user's PersistentVolumeClaim, the cluster may try to dynamically provision a volume specially for the PVC.
    + This provisioning is based on StorageClasses: the PVC must request a storage class and the administrator must have created and configured that class for dynamic 
    provisioning to occur.
    + Claims that request the class "" effectively disable dynamic provisioning for themselves.

Below is a sample PV definition file:

```ruby
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv0003
spec:
  # Permissable accessModes are: 1. ReadWriteOnce | 2. ReadWriteMany | 3. ReadOnlyMany
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: slow
  mountOptions:
    - hard
    - nfsvers=4.1
  nfs:
    path: /tmp
    server: 172.17.0.2
```
We can also mount external storage such as EBS vols from AWS and FC vols too.

## Persistent Volume Claims:



