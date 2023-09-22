# <p style="text-align: center;">Storage in Docker Containers</p>

When a docker engine is installed on any node, it creates a file system structure within the `/var/lib/docker` directory as below:<br>

![image](https://github.com/pyvivid/K8S-References/assets/94853400/cd403969-add0-4767-89a9-b6f3ecd2fdb5)<br>

The `/var/lib/docker` is the folder within which all the data is stored by default.<br>
Some Notable Directories:<br>
+ containers = Information related to the containers deployed.
+ volumes = Information related to the volumes used within the Docker Containers.
+ images = Information on images stored or are available on the node.



