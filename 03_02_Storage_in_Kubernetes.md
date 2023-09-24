
# <p style="text-align: center;">Kubernetes Storage Management</p>

## Container Storage Interface<br>

In the early days, the Docker Container runtime engine was the go to CRI for the Kubernetes. All the codes required to run the Docker Containers were already embedded into the
Kubernetes Codes.<br>
With other container engines such as rkt and cri-o coming in, it was important to accomodate them into the container runtime interface.<br>
The CSI or the Container Storage Interface is the standard that defines how an orchestration solution like Kubernetes would communicate with container runtimes like Docker.<br>
So in the future when a new container runtime interface is developed, they can simply follow the CRI standards and their solutions will work without any new code additions.<br>
It is important that the new CRI developers, adhere to the CRI/CSI/CNI standards for their products to work seamlessly in a Kubernetes Environment.<br>
So to support CSI the new developers will have to create plugins based on the CNI standards and they would simply work together with the Kubernetes solution.<br>
Note CSI is not a Kubernetes specific standard and if implemented would allow any container orchestration tool would allow any storage vendor to work with any supported plugin.<br>
Currently Kubernetes, Cloud Foundry and Mesos support CSI.<br>
**A CSI typically defines:**
+ set of RPCs that will be called by the container orchestrator and these must be implemented by the storage driver.
+ Example, CSI says that when a pod is created and requires a volyme, the container orchestrator in this case Kubernetes, should create volume RPC and pass set of details such
  as the volume name. The Storage driver should implement this RPC on the storage array and return the results of the operation.
+ Similarily, when the container orchestrator calls the Delete Volume RPC, then the storage driver should implement the code to remove the volume.

Earlier to Kubernetes version 1.28, there was support for various external volumes such as AWS EBS, AzureDisk, CephFS, Cinder to name a few, which were directly inbuilt into 
the kubernetes code. However, from version 1.8 onwards, kubernetes suggests we use third party drivers called CSI drivers from the same.<br>
As AWS suggests. CSI drivers replaces the kubernetes 'In-Tree' storage drivers that exists in the Kubernetes Source code.<br>
Detailed volume management documentation can be found on the kubernetes website at this [location](https://kubernetes.io/docs/concepts/storage/volumes/#using-subpath).<br>


## Volumes in Kubernetes:

Docker containers are transient in nature meaning they are short lived. They are called when they need to process data and destroyed once the work is completed.<br>
Like wise the data within the containers is also deleted, when the container which handled the data is destroyed.<br>
For more details on Persistent Volumes in Docker Containers, Check out the persistent volume management in Dockers in section 03_01.<br>
As for the Kubernetes, every volume configuration information goes into the pod definition file.<br>

A Pod can support any number of volumes simultaneously.<br>
To use a volume in a pod, specify the volumes to be used as ```.spec.volumes```, declare where to mount the volumes as ```.spec.containers[*].volumeMounts```.<br>


## Persistent Volumes in Kubernetes:

To manage storage more centrally from within the cluster, a cluster-wide centralized pool of storage volumes ae configured by an administrator.<br>
The users can now carve storage from the storage pool to be used within the pods, using persistent volume claims.<br>
PVs are resources in the cluster. 
PVCs are requests for those resources and also act as claim checks to the resource.<br>

Below is a sample PV definition file:

```ruby
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-vol01
spec:
  # Permissable accessModes are: **1. ReadWriteOnce | 2. ReadWriteMany | 3. ReadOnlyMany**
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 1Gi
   awsElasticBlockStore
```
**We can also mount external storage such as EBS vols from AWS, FC vols and iSCSI too.<br>**

From the PV created, we can carve a Persistent Volume Claim and can be presented to the nodes.<br>
A Persistent Volume Claim(PVC) is a request for storage by a user for use within a node.<br>
Pods consume node resources and PVCs consume OPV resources.<br>
Claims can request **specific sizes and access modes**.<br>
Cluster Administrators need to provide varieties of PVs that differ in sizes, performance and access methods.<br>

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

## Persistent Volume Claims:

PVs and PVCs are 2 seperate objects in the Kuberenetes namespace.
Administrator creates PVs and user creates PVCs.
Kubernetes binds the PV and the PVCs based on the request and properties set on the volume.
Every PVC is bound to a single PV. When a PVC is requested, kubernetes, tries to find the best PV that has:
  +  suffucient capacity to satify the claim.
  +  access modes
  +  volume modes
  +  storage classes

If there are multiple possible matches for a single claim and you want to use a specific volume, then you can still use labels and selectors to bind the right volumes.<br>
Point to Note:<br>
+ Small PVC requests may bind large PVs if the requirements seems fit.
+ Once a PV is bound to a PVC, it cannot be used by other volumes.
+ If no suitable match for a PVC request is found, then the PVCs continue to stay in a pending state unless a suitable PV is available.

Sample PVC Definition File:

```ruby
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: myclaim
spec:
  # Permissable accessModes are: **1. ReadWriteOnce | 2. ReadWriteMany | 3. ReadOnlyMany**
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```
Ref the above sample to the PV sample file.<br>
In the above PVC, the vol size requested is 500M , however the PV is 1Gi, and the accessModes match.<br>
Since no other PVs are available, the PV and the PVC are bound. If you notice the PV is 1Gi and the request is 500M. In this case the remaining 500M is wasted, since the one PV can be bound to one PVC only.<br>

The PVC and PV info can be viewed by 
`# kubectl get persistentvolumeclaim`
`# kubectl get persistentvolume`

To Delete the Volume:<br>
`# kubectl delete persistentvolumeclaim pvc_name`<br>
Now to retain the PV, when the PVC was created, use the following line, which is the default:<br>
`persistentVolumeReclaimPolicy: Retain`<br>
With the above option set, the PV will remain until manually deleted.<br>
However, to delete the PV when the PVC is deleted automatically and reclaim, set as below:<br>
`persistentVolumeReclaimPolicy: Delete`<br>
Once the PV has been detached from the PVC, it cannot be claimed by another PVC.<br><br>
There is option to scrub the data and make the PV available using:<br>
`persistentVolumeReclaimPolicy: Recycle`<br>

Usage within a Pod or RS or Deployment:
```ruby
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: mypd
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: myclaim
```


Important Links:

[Link to manage PVs and PVCs in Pods](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)




