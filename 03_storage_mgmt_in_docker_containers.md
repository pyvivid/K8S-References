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

## Preserving Data within Containers:

+ To preserve data persistently as in a DB container, we need to add a persistent volume to the container.<br>
+ We can create a volume within the `/var/lib/docker ` directory, using a standard `# mkdir new_volName`. <br>
+ Now we can mount the newly created volume to the which will spin up as below:<br>
`# docker run -v new_volName:/var/lib/mysql mysql`<br>
+ Now when the docker container spins up, the host's volume is connected to the /var/lib/mysql volume of the container.<br>
+ This method is called **"Volume Mounting"**.
  

