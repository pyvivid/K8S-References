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

## More on Authentication

From a K8S cluster perspective, there are 2 types of users, who connect and perform work</br>
1. Individuals such as Admins and developers to deploy and configure Infrastructure and applications.</br>
2. APIs communicating to the API Server for managing processes, fetching statuses or even peforming app deployments in automation.</br>

To Note, Kubernetes does not manage user accounts natively, rather it relies on an external sources such as </br>
1. File with user details and certificates</br>
2. Third Party services such as LDAP to manage these users.</br>

Also, remember, we cannot add, delete or manager users like in a conventional way as in a Linux OS. However, Kubernetes can manage Service Accounts. </br>
We can create and manage service accounts using the K8S API.</br>

We still need some sort of a Authentication mechanism to allow or disallow users, which can be achieved using </br>
1. a static password file.</br>
   + Simplest form of Authentication.
   + We can create a CSV file with a list of password, username and user ID and use that as the source. Pass the file information as an option to the K8S API server.
   + The option is configured in the Kube-API server, service which runs as a pod. Within the configuration of the Kube-API server, we provide this info as ```--basic-auth-file=user-details.csv```.
   + The Kube API server is then restarted for the options to take effect.
   + To access the Kube API server, using the creds, we should use the command as below:
   + ```# curl -v -k https://master-node-ip:6443/api/v1/pods -u "username:password"```
   + We can also manage groups within the above file by adding a 4th column to the CSV file.  ```password, username, user ID, groupname```
2. Usernames and tokens in a static token file.</br>
   + Instead of using a Password file, we can use a token file. ```--token-auth-file=user-token-details.csv```
   + Pass the token file as an option while logging on to the KubeAPI Server.
   + To access the KubeAPI server, using the token as creds, use a command as below:
   + ```# curl -v -k https://master-node-ip:6443/api/v1/pods --header "Authorization: Bearer Kpjijijfs78dsnjUc48i"```
4. authentication using certificates.</br>

