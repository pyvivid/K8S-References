Below Reference taken from https://matthewpalmer.net/kubernetes-app-developer/articles/kubernetes-apiversion-definition-guide.html



What does each apiVersion mean?
<h3>alpha</h3>
API versions with ‘alpha’ in their name are early candidates for new functionality coming into Kubernetes. These may contain bugs and are not guaranteed to work in the future.

<h3>beta</h3>
‘beta’ in the API version name means that testing has progressed past alpha level, and that the feature will eventually be included in Kubernetes. Although the way it works might change, and the way objects are defined may change completely, the feature itself is highly likely to make it into Kubernetes in some form.

<h3>stable</h3>
These do not contain ‘alpha’ or ‘beta’ in their name. They are safe to use.

<h3>v1</h3>
This was the first stable release of the Kubernetes API. It contains many core objects.

<h3>apps/v1</h3>
apps is the most common API group in Kubernetes, with many core objects being drawn from it and v1. It includes functionality related to running applications on Kubernetes, like Deployments, RollingUpdates, and ReplicaSets.

<h3>autoscaling/v1</h3>
This API version allows pods to be autoscaled based on different resource usage metrics. This stable version includes support for only CPU scaling, but future alpha and beta versions will allow you to scale based on memory usage and custom metrics.

<h3>batch/v1</h3>
The batch API group contains objects related to batch processing and job-like tasks (rather than application-like tasks like running a webserver indefinitely). This apiVersion is the first stable release of these API objects.

<h3>batch/v1beta1</h3>
A beta release of new functionality for batch objects in Kubernetes, notably including CronJobs that let you run Jobs at a specific time or periodicity.

<h3>certificates.k8s.io/v1beta1</h3>
This API release adds functionality to validate network certificates for secure communication in your cluster. You can read more on the official docs.

<h3>extensions/v1beta1</h3>
This version of the API includes many new, commonly used features of Kubernetes. Deployments, DaemonSets, ReplicaSets, and Ingresses all received significant changes in this release.

Note that in Kubernetes 1.6, some of these objects were relocated from extensions to specific API groups (e.g. apps). When these objects move out of beta, expect them to be in a specific API group like apps/v1. Using extensions/v1beta1 is becoming deprecated—try to use the specific API group where possible, depending on your Kubernetes cluster version.

<h3>policy/v1beta1</h3>
This apiVersion adds the ability to set a pod disruption budget and new rules around pod security.

<h3>rbac.authorization.k8s.io/v1</h3>
This apiVersion includes extra functionality for Kubernetes role-based access control. This helps you to secure your cluster. Check out the official blog post.


