#!/bin/bash 

# Reference: 
# - https://docs.docker.com/engine/userguide/containers/dockerimages/
# - https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile

imageTag=openkbs/eclipse-oxygen-docker

docker build -t ${imageTag} \
	-f Dockerfile .

echo "----> To run in interactive mode: "
echo "  docker run --name <some-name> -it ${imageTag} /bin/bash"
echo "e.g."
echo "  docker run it ${imageTag} "
echo "  docker run --name "my-$(basename $imageTag)" -it ${imageTag} "

echo "----> Docker Images"
echo "To build again: (there is a dot at the end of the command!)"
echo "  docker build -t ${imageTag} . "
echo
docker images |grep "$imageTag"


