# <p style="text-align: center;">Kubectl apply vs edit vs replace(Imperative Vs Declarative Approach)</p>

Kubernetes provides several methods to create and update resources using apply, edit, patch, and replace.<br>
Understanding the differences between
+ kubectl apply
+ kubectl create
+ kubectl edit
+ kubectl replace
+ kubectl patch<br>
is crucial for managing the Kubernetes resources effectively.

kubectl apply 
* is a declarative command that manages applications through files defining the resource. 
* reads the manifest file and creates the resource if it doesn't exist, and if it does, the resource is automatically updated. 
This is why kubectl apply is often preferred over kubectl create and kubectl replace as it allows management of resources in a more controlled and predictable manner.<br>

The syntax for kubectl apply is pretty straightforward<br>
`# kubectl apply -f FILENAME`<br>
e.g. # kubectl apply -f my-app-config.yml

Lets say you want to update the image version within a pod, then we update the manifest file and run the "kubectl apply" to update the images in realtime.

**kubectl create** is an imperative command that creates a new resource. However, it fails if the resource already exists.<br>
**kubectl replace** 
  * is also imperative and replaces the existing resource with a new one. It creates a new resource if it doesn't exist yet.
  * also replaces the existing resource with the one defined in the spec.
  * command behaves kind of like a manual version of the edit command. 

You have to download the current version of the resource spec, e.g., using kubectl get -o yaml, edit it, and then use kubectl replace to update the resource using the modified spec. 
If any changes have occurred between reading and replacing the resource, the replace will fail.

**kubectl edit** command will read the resource from the Kubernetes API, writes the resource specs into a local file, and opens that file up in a text editor for you.
You can then edit and save the changes you made back the Kubernetes API, which takes care of effecting the changes in the edit.
When using the kubectl edit command the changes effected using the edit, is not stored permanently into the configuration file and  hence we lose track of the changes effected at each stage.
To mitigate this, when using the Kubectl edit, use the kubetl replace command to effect the changes, so that the configuration changes are captured into the live definition file.
To Create Objects(Imperative Approach):

`# kubectl create -f nginx.yaml`

To Update the objects(Imperative Approach):

`# kubectl edit deployment nginx`<br>
`# kubectl replace -f nginx.yaml`<br>
`# kubectl replace --force -f nginx.yaml`<br>

**kubectl create** will fail if the object already exists.<br>
**kubectl replace** will fail if the object does not exist already.<br>

Meanwhile, the Imperative commands can be used for getting tasks done quickly as well as generate a definition template easliy.<br>
If you want to test your command but not create the resources, then<br>
`# kubectl run pod_name --image=image_name --dry-run=client` <br>
will tell, if the resource can be created with your command successfully, without having created your objects.<br>

Let us say, we want to generate a definition file to build up on, we can use<br>
`# kubectl run pod_name --image=image_name --dry-run=client -o yaml > def_file_to_be_created.yaml` - wil create a pod definition template and store it in a file.<br>
`# kubectl create deployment deployment_name --image=image_name --dry-run=client -o yaml > def_file_to_be_created.yaml` - will create a deployment definition file.<br>
`# kubectl create deployment deployment_name --image=image_name --replicas=4 --dry_run=client -o yaml > def_file_to_be_created.yaml` - will create a deployment definition file with 4 replicas.<br>

