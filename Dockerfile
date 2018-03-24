FROM openkbs/jdk-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

## ---- USER_NAME is defined in parent image: openkbs/jre-mvn-py3-x11 already ----
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}
ENV ECLIPSE_WORKSPACE=${HOME}/eclipse-workspace
        
WORKDIR /opt
RUN wget -c http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/oxygen/R/eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz && \
    tar xvf eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz && \
    rm eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz 
    
VOLUME ${ECLIPSE_WORKSPACE}
VOLUME ${HOME}/.eclipse 

RUN mkdir -p ${HOME}/.eclipse ${ECLIPSE_WORKSPACE} &&\
    chown -R ${USER_NAME}:${USER_NAME} ${ECLIPSE_WORKSPACE} ${HOME}/.eclipse
    
USER ${USER_NAME}
WORKDIR ${ECLIPSE_WORKSPACE}
CMD ["/opt/eclipse/eclipse"]
