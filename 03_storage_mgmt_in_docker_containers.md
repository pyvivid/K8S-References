# <p style="text-align: center;"> Storage in Docker Containers </p>

When a docker engine is installed on any node, it creates a file system structure within the `/var/lib/docker` directory as below:<br>

![image](https://github.com/pyvivid/K8S-References/assets/94853400/cd403969-add0-4767-89a9-b6f3ecd2fdb5)<br>

The `/var/lib/docker` is the folder within which all the data is stored by default.<br>
Some Notable Directories:<br>
+ containers = Information related to the containers deployed.
+ volumes = Information related to the volumes used within the Docker Containers.
+ images = Information on images stored or are available on the node.

## Understanding the Docker Layered Architecture:

When Docker builds images, the images will contain other images layered within them.
Each line of instruction within the Docker file used for building images, creates a new layer in the Docker Image, with changes from the previous layer.
Sample Docker file as below:
```ruby
FROM ubuntu
RUN apt-get update && apt-get -y install python
RUN pip install flask flask-mysql
COPY . /opt/source-code
ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run
```
![9](https://github.com/pyvivid/K8S-References/assets/94853400/48e7c2cc-2478-4304-b0f7-2cf5be0b40c3)

+ The first layer is the ubuntu OS. 
+ The second layer installs various packages using the apt command.
+ The Third layer created adds packages from Python.
+ Then in the 4th layer, the files in the local dir is copied to the /opt/source-code dir in the container image.
+ The fifth layer, updates the entry point of the image.<br>
**Note: After an image is ready, when we run a container, it ill be editable to add and store data. However, when the container is deleted, all the stored data is gone.**

Now let us say that we want to build a new image, that is very similar to our first image we built.
Sample as below:

```ruby
FROM Ubuntu
RUN apt-get update && apt-get -y install python
RUN pip install flask flask-mysql
COPY app2.py /opt/source-code
ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run
```
If you can compare our first and second image builds, we notice that both the images use Ubuntu as their base image.
Both images install the same packages and PIP installs, except the core application is different from the first one and hence the ENTRYPOINT too.
When a `# docker build` command is run, it reuses the same 3 layers from the 1st image which is in the cache. Only the COPY and ENTRYPOINT layers are newly created, saving disk space considerably.
Likewise, when you are updating your applications core code at step 4, in another build, Docker simply resuses all the other layers from the cache and quickly rebuilds the application image.

After the build is completed, the image is read only and cannot be modified, any changes will require a new build.
When you run a container based off of this image using the docker run command, Docker creates a container based off these layers and creates a new writeable layer on the top of the image layer.
The writable layer is used by the container to store data written by the application temporarily.
The life of this layer is only as long as the container live. When the container is deleted, all data at this layer is also wiped clean.

## Preserving Data within Containers(Persistent Data Volumes):

+ To preserve data persistently as in a DB container, we need to add a persistent volume to the container.<br>
+ We can create a volume within the `/var/lib/docker/volumes ` directory, using a standard `# mkdir new_volName`. <br>
+ We can also create a volume by running the `# docker volume create data_volume`, which will create a volume under the `/var/lib/docker/volumes` directory.
+ Now we can mount the newly created volume to the which will spin up as below:<br>
`# docker run -v data_Volume:/var/lib/mysql mysql`<br>
+ Now when the docker container spins up, the host's volume is connected to the /var/lib/mysql volume of the container.<br>
+ With this method, all data created and stored within the /var/lib/mysql dir of the container is also stored in the /var/lib/docker/volumes/data_Volume of the host.
+ Even if the container is destroyed, the host volume and data still exists.
+ In the event, that the new volume was not created, but, the command `# docker run -v data_Vol2:/var/lib/mysql mysql` was run, Docker will automatically create the volume within the volumes dir. This method is called **"Volume Mounting"**.
+ Now if I want to store data in a directory other than the usual `/var/lib/docker/volumes` directory, like /data/mysql and running a command as below
  `# docker run -v /data/mysql:/var/lib/mysql mysql`, will bind the host's volume to the sql container's volume. This is called **bind mounting**. Note the usage of the absolute path of the host here.

Note: The newer method of writing the docker command is as:
`# docker run --mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql`

## Storage Drivers in Docker:

Docker uses storage drivers to enable layered architecture to perform following tasks:
+ Maintaining the writeable layer.
+ Creating a Writeable Layer.
+ Moving files across layers to enable copy and write, etc.

Common Storage Drivers:
+ AUFS
+ VTRFS
+ ZFS
+ Device Mapper Overlay
+ Overlay2

Selection of the Storage Driver depends on the underlying OS being used. such as Fedora or CentOS.
Docker will choose the best driver for the OS automatically.

## Volume Drivers in Docker:

Volumes in Docker are not handled by the Storage Driver. They are managed by the Volume Driver Plugins.
Default Volume Driver Plugin is Local.
The local volume plugin, creates a volume on the Docker host and stores the data under /var/lib/docker volumes directory.
There are many other volume driver plugins that allow you to create a volume on third part solutions like
+ Azure File Storage
+ Digital Ocean
+ Block Storage
+ Google Compute Persistent Disks
+ ClusterFS
+ REX-Ray
+ PortWorx
to name a few.

REX-Ray storage driver can be used to provision volumes on AWS EBS, S3, Isilon and ScaleIO.
When running a Docker container you can choose to use a specific volume driver such as REX-Ray EBS to provision a volume.
When the container is destroyed, the data still persists in the cloud.

