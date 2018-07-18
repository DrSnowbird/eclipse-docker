FROM openkbs/jdk-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

## ---- USER_NAME is defined in parent image: openkbs/jdk-mvn-py3-x11 already ----
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}
ENV ECLIPSE_WORKSPACE=${HOME}/eclipse-workspace

#ARG ECLIPSE_TAR=${ECLIPSE_TAR:-eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz}
ARG ECLIPSE_TAR=${ECLIPSE_TAR:-eclipse-jee-photon-R-linux-gtk-x86_64.tar.gz}

#ARG ECLIPSE_URL=${ECLIPSE_URL:-"http://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/photon/R/"}
ARG ECLIPSE_URL=${ECLIPSE_URL:-"http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/photon/R"}

## http://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/photon/R/eclipse-jee-photon-R-linux-gtk-x86_64.tar.gz
## http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/photon/R/eclipse-jee-photon-R-linux-gtk-x86_64.tar.gz

WORKDIR /opt
#RUN wget -c http://mirror.math.princeton.edu/pub/eclipse/technology/epp/downloads/release/oxygen/R/${ECLIPSE_TAR} && \
RUN wget -c ${ECLIPSE_URL}/${ECLIPSE_TAR} && \
    tar xvf ${ECLIPSE_TAR} && \
    rm ${ECLIPSE_TAR} 
    
VOLUME ${ECLIPSE_WORKSPACE}
VOLUME ${HOME}/.eclipse 

RUN mkdir -p ${HOME}/.eclipse ${ECLIPSE_WORKSPACE} &&\
    chown -R ${USER_NAME}:${USER_NAME} ${ECLIPSE_WORKSPACE} ${HOME}/.eclipse
    
USER ${USER_NAME}
WORKDIR ${ECLIPSE_WORKSPACE}
CMD ["/opt/eclipse/eclipse"]
