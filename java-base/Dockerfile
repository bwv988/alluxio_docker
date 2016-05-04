# Base docker container for Ubuntu Trusty + Oracle JDK 7.
# RS01042016
#
# Build command:
#
# sudo docker build -t bwv988/java7 .


FROM ubuntu:trusty
MAINTAINER Ralph Schlosser, https://github.com/bwv988
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common && \
    apt-get install -y curl && \
    apt-get install -y openssh-server openssh-client && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java7-installer && \
    apt-get clean
