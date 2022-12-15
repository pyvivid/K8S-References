Using the kubectl run command can help in generating a YAML template. And sometimes, you can even get away with just the kubectl run command without having to create a YAML file at all.For example, if you were asked to create a pod or deployment  with specific name and image you can simply run the kubectl run command.

While you would be working mostly the declarative way - using definition files, imperative commands can help in getting one time tasks done quickly, as well as generate a definition template easily. This would help save considerable amount of time during your exams.

Before we begin, familiarize with the two options that can come in handy while working with the below commands:

> --dry-run // By default as soon as the command is run, the resource will be created.
> --dry-run=client // If you simply want to test your command. This will not create the resource, instead, tell you whether the resource can be created and if your command is right.
> -o yaml //This will output the resource definition in YAML format on screen.


Use the above two in combination to generate a resource definition file quickly, that you can then modify and create resources as required, instead of creating the files from scratch.
References:

> </link>https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands</link>
> </link>https://kubernetes.io/docs/reference/kubectl/conventions/</link>

<b>Create an NGINX Pod</b>

> $ kubectl run nginx --image=nginx

<b>Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)</b>

> $ kubectl run nginx --image=nginx --dry-run=client -o yaml

<b>Create a deployment</b>

> $ kubectl create deployment --image=nginx nginx

<b>Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)</b>

> $ kubectl create deployment --image=nginx nginx --dry-run=client -o yaml

<b>Generate Deployment YAML file (-o yaml). Don't create it(--dry-run) with 4 Replicas (--replicas=4)</b>

> $ kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > nginx-deployment.yaml

Save it to a file, make necessary changes to the file (for example, adding more replicas) and then create the deployment.

> $ kubectl create -f nginx-deployment.yaml

OR

<b>In k8s version 1.19+, we can specify the --replicas option to create a deployment with 4 replicas.</b>

> $ kubectl create deployment --image=nginx nginx --replicas=4 --dry-run=client -o yaml > nginx-deployment.yaml

OR

<b>You may scale the deployment using the

> $ kubectl scale deployment nginx --replicas=4

<b>save the YAML definition to a file and modify</b>

> $ kubectl create deployment nginx --image=nginx --dry-run=client -o yaml > nginx-deployment.yaml

You can then update the YAML file with the replicas or any other field before creating the deployment.

<h4>Services</h4>

<b>Create a Service named redis-service of type ClusterIP to expose pod redis on port 6379</b>

> $ kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml
    This will automatically use the pod's labels as selectors

> $ kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml
    This will not use the pods labels as selectors, instead it will assume selectors as app=redis. You cannot pass in selectors as an option. So it does not work very well if your pod has a different label set. So generate the file and modify the selectors before creating the service

<b>Create a Service named nginx of type NodePort to expose pod nginx's port 80 on port 30080 on the nodes:</b>

> $ kubectl expose pod nginx --type=NodePort --port=80 --name=nginx-service --dry-run=client -o yaml
    This will automatically use the pod's labels as selectors, but you cannot specify the node port. You have to generate a definition file and then add the node port in manually before creating the service with the pod.

Or

> kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml
    This will not use the pods labels as selectors