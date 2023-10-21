# <p style="text-align: center;">TLS Demystified</p>

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
Now the server also has the user's browser's symmetric keys. All communications from hereon are encrypted.
So now this is basically a 2 step process:
1. We used Asymmetric method to securely receive the user's symmetric keys.
2. Once the server has the user's symmetric keys, all communications are now safely encrypted.

Impotant point to note here is that, the server actually send only a certifictate in digital format issued to the public key of the server.
