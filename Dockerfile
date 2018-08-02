FROM openkbs/jdk-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

## -------------------------------------------------------------------------------
## ---- USER_NAME is defined in parent image: openkbs/jdk-mvn-py3-x11 already ----
## -------------------------------------------------------------------------------
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}
ENV ECLIPSE_WORKSPACE=${HOME}/eclipse-workspace

## ----------------------------------------------------------------------------
## ---- To change to different Eclipse version: e.g., oxygen, change here! ----
## ----------------------------------------------------------------------------

## -- Eclipse Download Mirror site: -- ##
ARG ECLIPSE_MIRROR_SITE_URL=${ECLIPSE_MIRROR_SITE_URL:-http://mirror.math.princeton.edu}

## -- Eclipse version: oxygen, photon, etc.: -- ##
ENV ECLIPSE_VERSION=${ECLIPSE_VERSION:-photon}

## ----------------------------------------------------------------------------------- ##
## ----------- Don't change below unless Eclipse download system change -------------- ##
## ----------------------------------------------------------------------------------- ##
## -- Eclipse TAR/GZ filename: -- ##
#ARG ECLIPSE_TAR=${ECLIPSE_TAR:-eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz}
ARG ECLIPSE_TAR=${ECLIPSE_TAR:-eclipse-jee-${ECLIPSE_VERSION}-R-linux-gtk-x86_64.tar.gz}

## -- Eclipse Download route: -- ##
ARG ECLIPSE_DOWNLOAD_ROUTE=${ECLIPSE_DOWNLOAD_ROUTE:-pub/eclipse/technology/epp/downloads/release/${ECLIPSE_VERSION}/R}

## -- Eclipse Download full URL: -- ##
## e.g.: http://mirror.math.princeton.edu/pub/eclipse/technology/epp/downloads/release/oxygen/R/
## e.g.: http://mirror.math.princeton.edu/pub/eclipse/technology/epp/downloads/release/photon/R/
ARG ECLIPSE_DOWNLOAD_URL=${ECLIPSE_DOWNLOAD_URL:-"${ECLIPSE_MIRROR_SITE_URL}/${ECLIPSE_DOWNLOAD_ROUTE}"}

## http://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/photon/R/eclipse-jee-photon-R-linux-gtk-x86_64.tar.gz
## http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/photon/R/eclipse-jee-photon-R-linux-gtk-x86_64.tar.gz
## http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/photon/R/eclipse-jee-photon-R-linux-gtk-x86_64.tar.gz

WORKDIR /opt
#RUN sudo wget -c http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/photon/R/eclipse-jee-photon-R-linux-gtk-x86_64.tar.gz  && \
RUN sudo wget -c ${ECLIPSE_DOWNLOAD_URL}/${ECLIPSE_TAR} && \
    sudo tar xvf ${ECLIPSE_TAR} && \
    sudo rm ${ECLIPSE_TAR} 
    
VOLUME ${ECLIPSE_WORKSPACE}
VOLUME ${HOME}/.eclipse 

RUN mkdir -p ${HOME}/.eclipse ${ECLIPSE_WORKSPACE} &&\
    sudo chown -R ${USER_NAME}:${USER_NAME} ${ECLIPSE_WORKSPACE} ${HOME}/.eclipse
    
USER ${USER_NAME}
WORKDIR ${ECLIPSE_WORKSPACE}
CMD ["/opt/eclipse/eclipse"]
