# <p style="text-align: center;">TLS Demystified</p>

## Understanding SSL TLS Certificates

A certificate is used to guarantee trust between two parties during a transaction.</b>
For example, when a user tries to access a web server, TLS certificates ensure that the communication between the user and the server is encrypted and the server is who it says it is.</br></b>
There are 2 types of encryption of the data being transferred between a user and the server:</b>
1.** Symmetric Encryption** = Data and Keys are sent over network and the network sniffer can catch both and decrypt the information. Not a secure method.</b>
2. **Asymmetric Encryption** - Commonly used passwordless authentication to servers = Uses a set/pair of private and public keys. The Public keys are situated on the server and the user sending data, send their private keys embedded within it. When a right private key is provided then the user is allowed access to the data/server.</b>

## Creating a Public and Private SSH keys:

The ssh keys that are generated are usually stored under the ".ssh" directory of the user.

On any linux server, run the command:
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
