# <p style="text-align: center;">Storage in Docker Containers</p>

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

