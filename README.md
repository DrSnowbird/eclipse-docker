# eclipse-oxygen-docker

* Eclipse-Oxygen + Java 8 (1.8.0_162) JDK + Maven 3.5.0 + Python 3.5.2 + X11 (display GUI)

# Configuration
The docker container will assume there is a default /workspace folder. So, it is suggested to mount host <some_path>/workspace to map to the container's internal workspace folder. The default, './run.sh', will use/create the local folder, "$HOME/data_docker/eclipse-oxygen-docker/workspace" to map into the docker's internal "/workspace" folder.

The above approach will ensure all your projects created in the container's "/workspace" folder is "persistent" in your local folder, i.e., "$HOME/data_docker/eclipse-oxygen-docker/workspace"


# Build (if you want build your local docker image instead of pulling from openkbs/eclipse-oxygen-docker)
```
./build.sh
```

# Run
```
./run.sh
```

# Display X11 Issue
More resource in X11 display of Eclipse on your host machine's OS, please see
* [X11 Display problem](https://askubuntu.com/questions/871092/failed-to-connect-to-mir-failed-to-connect-to-server-socket-no-such-file-or-di)

## Other docker-based IDE
* [openkbs/intellij-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/netbeans](https://hub.docker.com/r/openkbs/netbeans/)
* [openkbs/scala-ide-docker](https://hub.docker.com/r/openkbs/scala-ide-docker/)
