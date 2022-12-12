Using the kubectl run command can help in generating a YAML template. 
And sometimes, you can even get away with just the kubectl run command without 
having to create a YAML file at all. 
For example, if you were asked to create a pod or deployment 
with specific name and image you can simply run the kubectl run command.


https://kubernetes.io/docs/reference/kubectl/conventions/

<h1>Create an NGINX Pod</h1>

kubectl run nginx --image=nginx

<h1>Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)</h1>

kubectl run nginx --image=nginx --dry-run=client -o yaml

<h1>Create a deployment</h1>

kubectl create deployment --image=nginx nginx

<h1>Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)</h1>

kubectl create deployment --image=nginx nginx --dry-run=client -o yaml

<h1>Generate Deployment YAML file (-o yaml). Don't create it(--dry-run) with 4 Replicas (--replicas=4)</h1>

kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > nginx-deployment.yaml

Save it to a file, make necessary changes to the file (for example, adding more replicas) and then create the deployment.

kubectl create -f nginx-deployment.yaml

OR

<h1>In k8s version 1.19+, we can specify the --replicas option to create a deployment with 4 replicas.</h1>

kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml