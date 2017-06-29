FROM openkbs/jre-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

## ---- USER_NAME is defined in parent image: openkbs/jre-mvn-py3-x11 already ----
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}
        
WORKDIR ${HOME}
RUN wget -c http://mirror.math.princeton.edu/pub/eclipse//technology/epp/downloads/release/oxygen/R/eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz && \
    tar xvf eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz && \
    mkdir -p ${HOME}/workspace
    
VOLUME ${HOME}/workspace
VOLUME ${HOME}/.eclipse 

USER ${USER_NAME}

CMD "${HOME}/eclipse/eclise"
