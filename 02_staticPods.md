# <p style="text-align: center;">Static Pods</p>

Static Pods are managed direclty by the kubelet daemon.<br>
We can schedule pods to run with just the kubelet and without any of the other Kubernetes components such as API-server, scheduler.<br>
Static Pods are just simple Pods but they are not being controlled by the master node.
Rather the kubelet present on the node spins them up and watches them during their whole lifecycle. Even restarts them whenever they fail.
**The kubelet automatically tries to create a mirror Pod on the Kubernetes API server for each static Pod. **
Static pods are usually used by different software for bootstrapping Kubernetes itself. 
For example, kubeadm uses static pods to bring up Kubernetes control plane components like api-server, controller-manager as static pods on the Master Node.
Then these components will be looked by Kubelet present on the Master Node.

Creating and running a static pod is very much like running any other pod, however 
+ The pod definition file should be placed within the node where the pod will be run under the /etc/kubernetes/manifests directory. However, this is not a hard and fast rule.
+ The pod defintion file can also be placed under another directory, but its location is configured within the **config.yaml** file under the /var/lib/kubelet directory.
+ The --pod-manifest-path is the value within the config.yaml file, that contains the path to the static pod definition file.

## Static Pods Vs Daemon Sets
<!-- TABLE_GENERATE_START -->
|                   Static Pod                   |                  DaemonSet                              |
|------------------------------------------------|---------------------------------------------------------|
| Created by kubelet                             |	Created by kube-api server                             |
| Ignored by kube-scheduler                      |	Ignored by kube-scheduler                              |
| Deploy controlplane components as static pods	 |  Deploy monitoring, logging agents as pods on each nodes|
<!-- TABLE_GENERATE_END -->
