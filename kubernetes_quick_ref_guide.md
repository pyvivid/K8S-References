#                                                                 Kubernetes Quick Reference Guide:

Kubernetes has:
  **1.	Master Node running Control Plane Components**
  2.	Worker Nodes running Kubelet + Kubeproxy + Pods that host the containers within them.
The Master node hosts the Control Plane Components which include:
  1.	Kube API Server: All interactions to the Cluster occurs through the Kube API Server.
  2.	Controller Manager: Manages the controllers that run on the Master Node.
  3.	ETCD data store: Stores data about every single component within the cluster.
  4.	Scheduler
  5.	Cloud Control Manager
Applications are run within the containers. 
The Applications and the services such as DNS and Networking services are hosted on the cluster as containers. 
The Kubernetes requires as container runtime environment to run these containers and the docker is the most popular one.
Docker or its equivalent container runtime engine requires to be installed on all the nodes(including master nodes for controller pods)  that will be running the containers.
