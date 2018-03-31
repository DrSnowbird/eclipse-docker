#!/bin/bash

MY_DIR=$(dirname "$(readlink -f "$0")")

if [ $# -lt 1 ]; then
    echo "Usage: "
    echo "  ${0} <image_tag>"
fi

###################################################
#### ---- Change this only to use your own ----
###################################################
ORGANIZATION=openkbs
baseDataFolder="$HOME/data-docker"

###################################################
#### **** Container package information ****
#### ---- (Don't change this section!)  ----
###################################################
MY_IP=`ip route get 1|awk '{print$NF;exit;}'`
DOCKER_IMAGE_REPO=`echo $(basename $PWD)|tr '[:upper:]' '[:lower:]'|tr "/: " "_" `
imageTag=${1:-"${ORGANIZATION}/${DOCKER_IMAGE_REPO}"}
#PACKAGE=`echo ${imageTag##*/}|tr "/\-: " "_"`
PACKAGE="${imageTag##*/}"

###################################################
#### ---- (DEPRECATED but still supported)    -----
#### ---- Volumes to be mapped (change this!) -----
###################################################
# (examples)
# IDEA_PRODUCT_NAME="IdeaIC2017"
# IDEA_PRODUCT_VERSION="3"
# IDEA_INSTALL_DIR="${IDEA_PRODUCT_NAME}.${IDEA_PRODUCT_VERSION}"
# IDEA_CONFIG_DIR=".${IDEA_PRODUCT_NAME}.${IDEA_PRODUCT_VERSION}"
# IDEA_PROJECT_DIR="IdeaProjects"
# VOLUMES_LIST="${IDEA_CONFIG_DIR} ${IDEA_PROJECT_DIR}"

# ---------------------------
# Variable: VOLUMES_LIST
# (NEW: use docker.env with "#VOLUMES_LIST=data workspace" to define entries)
# ---------------------------
## -- If you defined locally here, 
##    then the definitions of volumes map in "docker.env" will be ignored.
# VOLUMES_LIST="data workspace"

# ---------------------------
# OPTIONAL Variable: PORT PAIR
# (NEW: use docker.env with "#PORTS=18000:8000 17200:7200" to define entries)
# ---------------------------
## -- If you defined locally here, 
##    then the definitions of ports map in "docker.env" will be ignored.
#### Input: PORT - list of PORT to be mapped
# (examples)
#PORTS_LIST="18000:8000"
#PORTS_LIST=

#########################################################################################################
######################## DON'T CHANGE LINES STARTING BELOW (unless you need to) #########################
#########################################################################################################
LOCAL_VOLUME_DIR="${baseDataFolder}/${PACKAGE}"
## -- Container's internal Volume base DIR
DOCKER_VOLUME_DIR="/home/developer"

###################################################
#### ---- Function: Generate volume mappings  ----
#### ---- (Don't change this section!)        ----
###################################################
VOLUME_MAP=""
#### Input: VOLUMES - list of volumes to be mapped
function generateVolumeMapping() {
    if [ "$VOLUMES_LIST" == "" ]; then
        ## -- If locally defined in this file, then respect that first.
        ## -- Otherwise, go lookup the docker.env as ride-along source for volume definitions
        VOLUMES_LIST=`cat docker.env|grep "^#VOLUMES_LIST= *"|sed "s/[#\"]//g"|cut -d'=' -f2-`
    fi
    for vol in $VOLUMES_LIST; do
        #echo "$vol"
	hasColon=`echo $vol|grep ":"`
        if [ ! "$hasColon" == "" ]; then
            # asymetric mapping paths, like "/srv/docker/bind:/data"
            VOLUME_MAP="${VOLUME_MAP} -v $vol" 
        else
            if [[ $vol == "/"* ]]; then
                echo "-- non-default /home/developer path; then use the full absolute path --"
                VOLUME_MAP="${VOLUME_MAP} -v ${LOCAL_VOLUME_DIR}$vol:$vol"
            else
                echo "-- default sub-directory (without prefix absolute path) --"
                VOLUME_MAP="${VOLUME_MAP} -v ${LOCAL_VOLUME_DIR}/$vol:${DOCKER_VOLUME_DIR}/$vol"
            fi
        fi
        mkdir -p ${LOCAL_VOLUME_DIR}/$vol
        ls -al ${LOCAL_VOLUME_DIR}/$vol
    done
}
#### ---- Generate Volumes Mapping ----
generateVolumeMapping
echo ${VOLUME_MAP}

###################################################
#### ---- Function: Generate port mappings     ----
#### ---- (Don't change this section!)         ----
###################################################
PORT_MAP=""
function generatePortMapping() {
    if [ "$PORTS" == "" ]; then
        ## -- If locally defined in this file, then respect that first.
        ## -- Otherwise, go lookup the docker.env as ride-along source for volume definitions
        PORTS_LIST=`cat docker.env|grep "^#PORTS_LIST= *"|sed "s/[#\"]//g"|cut -d'=' -f2-`
    fi
    for pp in ${PORTS_LIST}; do
        #echo "$pp"
        port_pair=`echo $pp |  tr -d ' ' `
        if [ ! "$port_pair" == "" ]; then
            # -p ${local_dockerPort1}:${dockerPort1} 
            host_port=`echo $port_pair | tr -d ' ' | cut -d':' -f1`
            docker_port=`echo $port_pair | tr -d ' ' | cut -d':' -f2`
            PORT_MAP="${PORT_MAP} -p ${host_port}:${docker_port}"
        fi
    done
}
#### ---- Generate Port Mapping ----
generatePortMapping
echo ${PORT_MAP}

###################################################
#### ---- Function: Generate privilege String  ----
#### ---- (Don't change this section!)         ----
###################################################
privilegedString=""
function generatePrivilegedString() {
    OS_VER=`which yum`
    if [ "$OS_VER" == "" ]; then
        # Ubuntu
        echo "Ubuntu ... not SE-Lunix ... no privileged needed"
    else
        # CentOS/RHEL
        privilegedString="--privileged"
    fi
}
generatePrivilegedString
echo ${privilegedString}

###################################################
#### ---- Mostly, you don't need change below  ----
#### ---- (Don't change this section!)         ----
###################################################
function cleanup() {
    if [ ! "`docker ps -a|grep ${instanceName}`" == "" ]; then
         docker rm -f ${instanceName}
    fi
}

#instanceName=my-${1:-${imageTag%/*}}_$RANDOM
#instanceName=my-${1:-${imageTag##*/}}
## -- transform '-' and space to '_' 
#instanceName=`echo $(basename ${imageTag})|tr '[:upper:]' '[:lower:]'|tr "/\-: " "_"`
instanceName=`echo $(basename ${imageTag})|tr '[:upper:]' '[:lower:]'|tr "/: " "_"`

echo "---------------------------------------------"
echo "---- Starting a Container for ${imageTag}"
echo "---------------------------------------------"

cleanup

export DISPLAY=:0.0
echo ${DISPLAY}
xhost +SI:localuser:$(id -un) 
#    --user=$(id -u):$(id -g) \
docker run -it \
    --name=${instanceName} \
    --restart=always \
    ${privilegedString} \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    ${VOLUME_MAP} \
    ${PORT_MAP} \
    ${imageTag}

cleanup

