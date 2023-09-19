# <p style="text-align: center;">Methods to Schedule Pods in a Kubernetes Cluster</p>

## Manual Scheduling

If you have set up your kubernetes cluster using kubeadm or similar tools, then the scheduler already exsist. <br>
However, if you are doing a manual setup, and if you hadn't installed the scheduler, then, how can we manually schedule the pods.

### Scenario 1:<br>
We create a pod  definition file, explicitly specifying the nodeSeletor in the spec of the pod definition file.
![Manual Scheduling](https://github.com/pyvivid/K8S-References/assets/94853400/82139a0f-7fc2-4f1c-b7f1-66778abb668b)

### Scenario 2:<br>
If our pod is already running on a specific node and we wish to move the pod from one node to another then,<br>
We create a pod binding definition file, convert from yaml to JSON and then provide it as a binding object to the original pod definition file.<br>
![ms](https://github.com/pyvivid/K8S-References/assets/94853400/2eaace3a-37d0-418a-a764-b2f077e856ab)![Manual Scheduling1](https://github.com/pyvivid/K8S-References/assets/94853400/27dbc46f-2af8-487b-abde-d782e4a45e84)<br>
![Manual Scheduling](https://github.com/pyvivid/K8S-References/assets/94853400/e4cb6bfe-fdbe-439a-8ff7-5c52d7ed971e)<br>
