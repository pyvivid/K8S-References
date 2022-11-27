# k8s-manifests
This repo consists of Sample </h3>PersistentVolume manifests</h3> to be used for K8S.

<h3>PV Access Modes</h3></br>
> RWO - ReadWriteOnce -- the volume can be mounted as read-write by a single node</br> 
> ROX - ReadOnlyMany - the volume can be mounted read-only by many nodes</br>
> RWX - ReadWriteMany - the volume can be mounted as read-write by many nodes</br>
> RWOP - ReadWriteOncePod - the volume can be mounted as read-write by a single Pod.</br>
       > if you want to ensure that only one pod across whole cluster can read that PVC or write to it.</br>

<h3>persistentVolumeReclaimPolicy</h3></br>
> retain - Setting the reclaim policy to Retain means that the storage volume is retained when no longer required by the pod and can be reused by other pods.</br>
> delete - Setting the reclaim policy to Delete means that the storage volume is deleted when it is no longer required by the pod.</br>
