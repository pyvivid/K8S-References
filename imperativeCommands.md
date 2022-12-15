The Kubectl run to create a pod.

> $ kubectl run --image=nginx nginx

The kubectl create deployment command to create a deployment.

> $ kubectl create deployment --image=nginx nginx

The kubectl expose command to create a service, to expose a deployment.

> $ kubectl expose deployment nginx --port 80

And the kubectl edit command may be used to edit an existing object.

> $ kubectl edit deployment nginx

For scaling a deployment or replica set, use the kubectl scale command.

> $ kubectl scale deployment nginx --replicas=5

And updating the image on a deployment, we use the kubectl set image command.

> $ kubectl set image deployment nginx nginx=nginx:1.18

And editing an object using the kubectl replace command.

> $ kubectl replace –f nginx.yaml

And deleting an object using the kubectl delete command.

> $ kubectl delete –f nginx.yaml
