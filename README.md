# eclipse-photon-docker
[![](https://images.microbadger.com/badges/image/openkbs/eclipse-photon-docker.svg)](https://microbadger.com/images/openkbs/eclipse-photon-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/eclipse-photon-docker.svg)](https://microbadger.com/images/openkbs/eclipse-photon-docker "Get your own version badge on microbadger.com")

* Eclipse-Photon + Java 8 JDK + Maven 3.5 + Python 3.5 + Gradle + X11 (display GUI)

# NOTE: This docker default is providing latest Eclipse Photon instead of Oxygen and you can change it to build other versions!!!

# License Agreement
By using this image, you agree the [Oracle Java JDK License](http://www.oracle.com/technetwork/java/javase/terms/license/index.html).
This image contains [Oracle JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html). You must accept the [Oracle Binary Code License Agreement for Java SE](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) to use this image.

# Components
* Eclipse Phonto JEE version (you can change if by change Dockerfile)
* java version "1.8.0_191"
  Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
  Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)
* Apache Maven 3.5.3
* Python 3.5.2
* X11 display desktop
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy 

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

## Build (Older Eclipse, e.g. Oxygen)
* Way-1: Modify the line in Dockefile as below if you use Docker-compose or Openshift CI/CD. That is, you se this way if you are not using command line ./build.sh to build container image.
```
## -- Eclipse version: photon, oxygen, etc.: -- ##
ENV ECLIPSE_VERSION=${ECLIPSE_VERSION:-photon}
or
ENV ECLIPSE_VERSION=${ECLIPSE_VERSION:-oxygen}
```
* Way-2: If you use command line "./build.sh", you can modify ".env (old filename docker.env)" file and then, run "./build.sh" to build image
```
## -- Eclipse version: photon, oxygen, photon, etc.: -- ##
ECLIPSE_VERSION=photon
or
ECLIPSE_VERSION=oxygen
```

# Configurations (Optional)
If you run "./run.sh" instead of "docker-compose up", you don't have to do anything as below.

* The container uses a default "/workspace" folder. 
* The script "./run.sh" will re-use or create the local folder in your $HOME directory with the path below to map into the docker's internal "/workspace" folder.
```
$HOME/data_docker/eclipse-photon-docker/workspace
```
The above configuration will ensure all your projects created in the container's "/workspace" being "persistent" in your local folder, "$HOME/data_docker/eclipse-photon-docker/workspace", for your repetitive restart docker container.

# See Also - Other docker-based IDE
* [openkbs/docker-atom-editor](https://hub.docker.com/r/openkbs/docker-atom-editor/)
* [openkbs/eclipse-photon-docker](https://hub.docker.com/r/openkbs/eclipse-photon-docker/)
* [openkbs/eclipse-oxygen-docker](https://hub.docker.com/r/openkbs/eclipse-oxygen-docker/)
* [openkbs/intellj-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/netbeans9-docker](https://hub.docker.com/r/openkbs/netbeans9-docker/)
* [openkbs/netbeans](https://hub.docker.com/r/openkbs/netbeans/)
* [openkbs/papyrus-sysml-docker](https://hub.docker.com/r/openkbs/papyrus-sysml-docker/)
* [openkbs/pycharm-docker](https://hub.docker.com/r/openkbs/pycharm-docker/)
* [openkbs/scala-ide-docker](https://hub.docker.com/r/openkbs/scala-ide-docker/)
* [openkbs/sublime-docker](https://hub.docker.com/r/openkbs/sublime-docker/)
* [openkbs/webstorm-docker](https://hub.docker.com/r/openkbs/webstorm-docker/)

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
