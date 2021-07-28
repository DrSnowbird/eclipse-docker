# Eclipse '2021-03' IDE Docker Container + OpenJDK Java 11 + Maven 3 + Python 3 + pip 21 + node 16 + npm 7 + Gradle 6 + X11 (Desktop)
[![](https://images.microbadger.com/badges/image/openkbs/eclipse-photon-docker.svg)](https://microbadger.com/images/openkbs/eclipse-photon-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/eclipse-photon-docker.svg)](https://microbadger.com/images/openkbs/eclipse-photon-docker "Get your own version badge on microbadger.com")

* For any plugin of Eclipse, e.g., BPMN2, etc., you will use Eclipse Marketplace to install once you are inside the Containr's Eclipse -- we are retiring all other specialty versions of Eclipse, e.g., eclipse-uml-docker, etc.

* NOTE: This docker default is providing latest Eclipse '2021-03' (Latest) instead of Photon, Oxygen and you can change it to build other versions using '.env' file !!!

# Components
* Eclipse '2021-03' the latest Modeling or JEE version (you can change if by change .env and then use './build.sh' to build locally)
* Base Components (e.g., Maven, Java, NodeJS, etc.)
  * See [openkbs/jdk-mvn-py3 - Components](https://github.com/DrSnowbird/jdk-mvn-py3/blob/master/README.md#Components)
  * See [openkbs/jdk-mvn-py3 - Releases Information](https://github.com/DrSnowbird/jdk-mvn-py3/blob/master/README.md#Releases-information)

# Run (recommended for easy-start)
Image is pulling from openkbs/eclipse-docker
```
./run.sh
```

# Build
You can build your own image locally.
Note that the default build docker is "latest" version. 
If you want to build older Eclipse like "photon", "oxygen", you can following instruction in next section
```
./build.sh
```

# Build (Older Eclipse, e.g. Photon, Oxygen)
Two ways (at least) to build:
### Way-1 (**Recommended**):
If you use command line "'**./build.sh**'", you can modify "'**./.env**' (old filename ./.env)" file and then, run "./build.sh" to build image
```
## -- Eclipse versions: photon, oxygen, etc.: -- ##
ECLIPSE_VERSION=photon
or
ECLIPSE_VERSION=oxygen
```
Then, 
```
./build.sh
```
### Way-2: (not recommended - to avoid breaking Dockerfile!)
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
# Configurations (Optional - mostly you don't have to do this!)
If you run "./run.sh" instead of "docker-compose up", you don't have to do anything as below.

* The container uses a default "/workspace" folder. 
* The script "./run.sh" will re-use or create the local folder in your $HOME directory with the path below to map into the docker's internal "/workspace" folder.
```
$HOME/data_docker/eclipse-docker/workspace
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
# See Also - Other docker-based IDE
er/)
* [openkbs/eclipse-docker-vnc](https://hub.docker.com/r/openkbs/eclipse-docker-vnc/)
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

# Releases information
  * See [openkbs/jdk-mvn-py3](https://github.com/DrSnowbird/jdk-mvn-py3/blob/master/README.md#Releases-information)

