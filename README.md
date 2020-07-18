# Eclipse '2020-06' IDE Docker Container + OpenJDK Java 8 (1.8.0_252) JDK + Maven 3.6 + Python 3.6/2.7 + pip 19 + node 12 + npm 6 + Gradle 5.6 + X11 (Desktop)
[![](https://images.microbadger.com/badges/image/openkbs/eclipse-photon-docker.svg)](https://microbadger.com/images/openkbs/eclipse-photon-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/eclipse-photon-docker.svg)](https://microbadger.com/images/openkbs/eclipse-photon-docker "Get your own version badge on microbadger.com")

# NOTE: This docker default is providing latest Eclipse '2020-06' (Latest) instead of Photon, Oxygen and you can change it to build other versions using '.env' file !!!

# Components
* Eclipse '2020-06' JEE version (you can change if by change Dockerfile)
* Base Components (e.g., Maven, Java, NodeJS, etc.)
  * See [openkbs/jdk-mvn-py3](https://github.com/DrSnowbird/jdk-mvn-py3/blob/master/README.md#Components)

# Run (recommended for easy-start)
Image is pulling from openkbs/eclipse-photon-docker
```
./run.sh
```

# Build
You can build your own image locally.
Note that the default build docker is "photon" version. 
If you want to build older Eclipse like "oxygen", you can following instruction in next section
```
./build.sh
```

# Build (Older Eclipse, e.g. Photon, Oxygen)
Two ways (at least) to build:
### Way-1 (**Recommended**):
If you use command line "'**./build.sh**'", you can modify "'**./.env**' (old filename ./docker.env)" file and then, run "./build.sh" to build image
```
## -- Eclipse versions: photon, oxygen, etc.: -- ##
ECLIPSE_VERSION=photon
or
ECLIPSE_VERSION=oxygen
```
Then, 
```
./build/sh
```
### Way-2: 
Modify the line in '**./Dockefile**' as below if you use '**docker-compose**' or Openshift CI/CD. That is, you are not using command line '**./build.sh**' to build container image.
```
## -- Eclipse versions: photon, oxygen, etc.: -- ##
ENV ECLIPSE_VERSION=${ECLIPSE_VERSION:-photon}
or
ENV ECLIPSE_VERSION=${ECLIPSE_VERSION:-oxygen}
```
Then, 
```
docker-compose up -d 
```
# Configurations (Optional)
If you run "./run.sh" instead of "docker-compose up", you don't have to do anything as below.

* The container uses a default "/workspace" folder. 
* The script "./run.sh" will re-use or create the local folder in your $HOME directory with the path below to map into the docker's internal "/workspace" folder.
```
$HOME/data_docker/eclipse-photon-docker/workspace
```
The above configuration will ensure all your projects created in the container's "/workspace" being "persistent" in your local folder, "$HOME/data_docker/eclipse-photon-docker/workspace", for your repetitive restart docker container.

### Create Customized Volume Mapping for "docker-compose"
You can create your own customzied host file mapping, e.g.
```
mkdir -p <my_host_directory>/.eclipse 
mkdir -p <my_host_directory>/eclipse-workspace
```
Then, run docker-comp
```
docker-compose up -d
```
# Distributed Storage
This project provides simple host volumes. For using more advanced storage solutions, there are a few distributed cluster storage options available, e.g., Lustre (popular in HPC), GlusterFS, Ceph, etc.
* [Dockerfiles (CentOS, Fedora, Red Hat) for GlusterFS ](https://github.com/gluster/gluster-containers)
* [GlusterFS Quickstart](https://docs.gluster.org/en/latest/Quick-Start-Guide/Quickstart/)
* [Two Days of Pain or How I Deployed GlusterFS Cluster to Kubernetes](https://blog.lwolf.org/post/how-i-deployed-glusterfs-cluster-to-kubernetes/)

# See Also - docker-based IDE
* [openkbs/atom-docker](https://hub.docker.com/r/openkbs/atom-docker/)
* [openkbs/eclipse-oxygen-docker](https://hub.docker.com/r/openkbs/eclipse-oxygen-docker/)
* [openkbs/eclipse-photon-docker](https://hub.docker.com/r/openkbs/eclipse-photon-docker/)
* [openkbs/eclipse-photon-vnc-docker](https://hub.docker.com/r/openkbs/eclipse-photon-vnc-docker/)
* [openkbs/intellj-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/intellj-vnc-docker](https://hub.docker.com/r/openkbs/intellij-vnc-docker/)
* [openkbs/knime-vnc-docker](https://hub.docker.com/r/openkbs/knime-vnc-docker/)
* [openkbs/netbeans-docker](https://hub.docker.com/r/openkbs/netbeans-docker/)
* [openkbs/papyrus-sysml-docker](https://hub.docker.com/r/openkbs/papyrus-sysml-docker/)
* [openkbs/pycharm-docker](https://hub.docker.com/r/openkbs/pycharm-docker/)
* [openkbs/rapidminer-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/rapidminer-docker)
* [openkbs/scala-ide-docker](https://hub.docker.com/r/openkbs/scala-ide-docker/)
* [openkbs/sublime-docker](https://hub.docker.com/r/openkbs/sublime-docker/)
* [openkbs/webstorm-docker](https://hub.docker.com/r/openkbs/webstorm-docker/)
* [openkbs/webstorm-vnc-docker](https://hub.docker.com/r/openkbs/webstorm-vnc-docker/)

# Resources - JBoss
* [JBoss Tools Integration Stacks 4.6.0.Final](https://tools.jboss.org/downloads/jbosstools_is/photon/4.6.0.Final.html#update_site)
* [Containerize Teiid linked with MariaDB](https://developer.jboss.org/wiki/QuickstartExampleWithDockerizedTeiid)
* [Teiid Downloads](http://teiid.jboss.org/downloads/)
* [Teiid Designer 11.1 with Eclipse Oxygen](http://teiiddesigner.jboss.org/designer_summary/downloads.html)
* [Teiid Cloud - Data Virtualization Services](http://teiid.io/teiid_cloud/)
* [Deploying Teiid VDB](http://teiid.github.io/teiid-documents/master/content/admin/Deploying_VDBs.html)
* [JBoss Tools Integration Stack 4.6.0.Final](https://tools.jboss.org/downloads/jbosstools_is/photon/4.6.0.Final.html)

# Display X11 Issue

More resource in X11 display of Eclipse on your host machine's OS, please see
* [X11 Display problem](https://askubuntu.com/questions/871092/failed-to-connect-to-mir-failed-to-connect-to-server-socket-no-such-file-or-di)
* [X11 Display with Xhost](http://www.ethicalhackx.com/fix-gtk-warning-cannot-open-display/)

# Other possible Issues
You might see the warning message or something similar in the launching xterm console like below, you can just ignore it. I googled around and some blogs just suggested to ignore since the IDE is still functional ok.
```
** (eclipse:1): WARNING **: Couldn't connect to accessibility bus: Failed to connect to socket /tmp/dbus-wrKH8o5rny: Connection refused

** (java:7): WARNING **: Couldn't connect to accessibility bus: Failed to connect to socket /tmp/dbus-wrKH8o5rny: Connection refused

```
# Releases information
  * See [openkbs/jdk-mvn-py3](https://github.com/DrSnowbird/jdk-mvn-py3/blob/master/README.md#Releases-information)

