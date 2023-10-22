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
   + TLS explanations are in detail in another section. Read that section, if you are new to TLS. Link is here
  
## Understanding SSL TLS Certificates

A certificate is used to guarantee trust between two parties during a transaction.</br>
For example, when a user tries to access a web server, TLS certificates ensure that the communication between the user and the server is encrypted and the server is who it says it is.</br>
There are 2 types of encryption of the data being transferred between a user and the server:</br>

1.** Symmetric Encryption** = Data and Keys are sent over network and the network sniffer can catch both and decrypt the information. Not a secure method.</br>
2. **Asymmetric Encryption** - Commonly used passwordless authentication to servers = Uses a set/pair of private and public keys. The Public keys are situated on the server and the user sending data, send their private keys embedded within it. When a right private key is provided then the user is allowed access to the data/server.</br>

## Creating a Public and Private SSH keys:

The ssh keys that are generated are usually stored under the ".ssh" directory of the user.</br>

On any linux server, run the command:</br>
```
ubuntu@dock-ser:~$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ubuntu/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): # Enter Passphrase if needed
Enter same passphrase again: # Enter Passphrase if needed
Your identification has been saved in /home/ubuntu/.ssh/id_rsa
Your public key has been saved in /home/ubuntu/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:ragadypie0okdbjcdsiZdTDF++rbKLVI4eXEU ubuntu@dock-ser
The key's randomart image is:
+---[RSA 3072]----+
|       .o=+*= E  |
|       .o.*+.=   |
|       .o+=.* o  |
|        oB @ = o |
|        S X O . .|
|         + X   . |
|          * + .  |
|         o o o   |
|          o o.   |
+----[SHA256]-----+
ubuntu@dock-ser:~$ cat /home/ubuntu/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABlwAAAAdzc2gtcn
NhAAAAAwEAAQAAAYEAtc6kRgfCB6v5HKZoxIHZCAmwRd+WBajJdPgZx+oq33mkgQk2GfoR
ZkSyQaogynKLPwOjh6RK/wk8XLNQy/rfDbYgTdlWfA+8L2HQJqenqma003kL/vsrfJL3wB
GYE+2EKvAUEUmqwhrGN1wWWCfHHCEfulnv+Ex+GZDhaRtmK7lUH0YJs1PwEYs1MlaNWE5F
jo3Df43odXvHtvoHmSjYhevZ7jy//zucbkTD3PRGKGJybdohoa40wBMPy8T1sveZL+TJ/K
FDo1AKaSRhxzrZZWlJTShrv7N6x4l07FXXjA5FUwg2B1vdeBlsavh3tmkHhf2Udr5A1x9U
Pr+SFp38NY6WKPora+Kxg4xB0jw4ChbqSpbbxbJ/IjC/qRaywPl8wygD/1+UeHLshVyH8X................
ubuntu@dock-ser:~$ cat /home/ubuntu/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1zqRGB8IH.....
......n8oUOjUAppJGHHOtllaUlNKGu/s3rHiXTsVdeMDkVTCDYHW914GW
xq+He2aQeF/ZR2vkDXH1Q+v5IWnfw1jpYo+itr4rGDjEHSPDgKFupKltvFsn8iML+pFrLA+XzDKAP/X5R4cuyFXIfxfiU6LD4tE
gDP6rsdEmprhWQjWOfs//mBhx1g+fa1YD1ZL9spzgVIz0cHv+bI3uW4ePGS3RBhnASXSomraE8Hjo69gfJ63TT8rdwSuaEFe98pKsk= username@servername

```
</br>
In realtime, both the symmetric and Asymmetric keys are used together to form a tight secure data transfer mechanism. The Public + Private Key pair is generated on the server, not using the ssh-key-gen but as below:</br>
```
# openssl genrsa --out my-keys.keys 1024
# opensll genrsa -in my-keys.key -pubout > mybank.pem
```</br>
When the user first accesses the webserver, the Public Keys --> Sent to User's Browser.</br>
At the browser end, the Symmetric key is encrypted using the Public keys that was received by the browser. Now data returns back to server.</br>
At the server end, there is the private key to decrypt the browser's symmetric keys received. </br>
So, in the whole transation, the sniffer, gets the public key, encrypted private keys of the user. But not the private keys of the public key to decrypt the user's symmetric keys.</br>
Now the server also has the user's browser's symmetric keys. All communications from hereon are encrypted.</br>
So now this is basically a 2 step process:</br>
1. We used Asymmetric method to securely receive the user's symmetric keys.</br>
2. Once the server has the user's symmetric keys, all communications are now safely encrypted.

Impotant point to note here is that, the server actually send only a certifictate in digital format issued to the public key of the server.</br>

## TLS in K8S:</br>

Basically in a TLS authenication mechanism, there are 3 types of certificates being used:</br>
1. Server certificates configured for Servers.
2. Root Certificates configured on CA(Certificate Authority) servers.
3. Client Certificates configured on Clients.</br>


