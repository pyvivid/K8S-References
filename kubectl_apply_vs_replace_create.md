# Kubectl apply vs edit vs replace

Kubernetes provides several methods to create and update resources using apply, edit, patch, and replace.
Understanding the differences between
+ kubectl apply
+ kubectl create
+ kubectl edit
+ kubectl replace
+ kubectl patch/br
is crucial for managing the Kubernetes resources effectively.

kubectl apply is a declarative command that manages applications through files defining the resource. 
It reads the manifest file and creates the resource if it doesn't exist, and if it does, the resource is automatically updated. 
This is why kubectl apply is often preferred over kubectl create and kubectl replace as it allows management of resources in a more controlled and predictable manner.
The syntax for kubectl apply is pretty straightforward

`# kubectl apply -f FILENAME`
e.g. # kubectl apply -f my-app-config.yml

Lets say you want to update the image version within a pod, then we update the manifest file and run the "kubectl apply" to update the images in realtime.

kubectl create is an imperative command that creates a new resource. However, it fails if the resource already exists.

kubectl replace is also imperative and replaces the existing resource with a new one. It creates a new resource if it doesn't exist yet.
kubectl replace also replaces the existing resource with the one defined in the spec.
kubectl replace command behaves kind of like a manual version of the edit command. 
You have to download the current version of the resource spec, e.g., using kubectl get -o yaml, edit it, and then use kubectl replace to update the resource using the modified spec. 
If any changes have occurred between reading and replacing the resource, the replace will fail.

kubectl edit command will read the resource from the Kubernetes API, writes the resource specs into a local file, and opens that file up in a text editor for you.
You can then edit and save the changes you made back the Kubernetes API, which takes care of effecting the changes in the edit.
***When using the kubectl edit command the changes effected using the edit, is not stored permanently into the configuration file and 
hence we lose track of the changes effected at each stage.
To mitigate this, when using the Kubectl edit, use the kubetl replace command to effect the changes, so that the configuration changes are captured into the live definition file.

`# kubectl edit deployment nginx`
`# kubectl replace -f nginx.yaml`
`# kubectl replace --force -f nginx.yaml`


