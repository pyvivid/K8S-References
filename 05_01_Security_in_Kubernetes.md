# <p style="text-align: center;">Security in Kubernetes - Basics</p>

## Security Primitives in K8S

As usual we need to secure access to the K8S hosts, which includes</br>
+ Route access disabled.</br>
+ Password based authentication disabled.</br>
+ Only SSH based authentication available.</br>
  to name a few.</br>

Remember the **kube-api server** is the key entry point for all communications to the cluster. Controlling access to the Kube-api server is a key component in the overall secuity of the K8S.</br>
To frame the security of our</br>
infrastructure, We need to decide on:</br>
1. Who can access what?</br>
   A. This is achieved using the **authentication** mechanisms.</br>
   B. There are different ways to authenticate to a server, such as using IDs and passwords stored in static files or tokens, certificates or with external authentication like LDAP.</br>
2. What can be done by whom?</br>
   A. Once access to the cluster is done, what the user can do is defined by the **authorization** mechanism.</br>
   B. Authorization is achieved using RBAC(Role Base Access Controls), where users are grouped according to the role performed by them, with each of the group having specific permissions/authorizations.</br>
   
Note: There are also attribute based access controls(ABAC), Node authorizers, Web hooks, etc.</br>

All communication between the components of the Control Plane as well as the Components of the Worker Nodes are secured using TLS encryption.</br>

![12](https://github.com/pyvivid/K8S-References/assets/94853400/8d013da6-1dc7-42f3-8cdb-a6aca1f012a7)

By Default all Pods can access all other pods within the cluster, however, we can restrict access between them using the network policies.
