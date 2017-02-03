# Experimental docker file for Alluxio.
# RS03022017

FROM debian:jessie
MAINTAINER Ralph Schlosser, https://github.com/bwv988

ENV ALLUXIO_VER 1.4.0
ENV ALLUXIO_DL_URL http://alluxio.org/downloads/files/${ALLUXIO_VER}/alluxio-${ALLUXIO_VER}-bin.tar.gz
ENV JAVA_MAJOR 8
ENV JAVA_MINOR 101
ENV JAVA_BUILD b13
ENV JAVA_VERSION ${JAVA_MAJOR}u${JAVA_MINOR}
ENV JDK_DL_URL http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-$JAVA_BUILD/jdk-$JAVA_VERSION-linux-x64.tar.gz
ENV JAVA_HOME /opt/jdk1.8.0_$JAVA_MINOR
ENV PATH $JAVA_HOME/bin:$PATH

# FIXME: Perhaps select smaller base image.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    net-tools \
    curl \
    wget \
    unzip \
    tar \
    bzip2 \
    netcat \
    openssh-server \
    sudo && \
    curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  "$JDK_DL_URL" \
  | gunzip \
  | tar x -C /opt/ && \
  ln -s $JAVA_HOME /opt/java && \
  mkdir -p /root/.ssh && chmod 700 /root/.ssh && \
  ssh-keygen -A && \
  rm -f /root/.ssh/id_rsa && \
  ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N "" && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
  chmod og-wx ~/.ssh/authorized_keys && \
  mkdir -p /alluxio && \
  curl -SL ${ALLUXIO_DL_URL} \
  | tar -xvz -C /alluxio --strip-components=1 &&\
  cp alluxio/conf/alluxio-env.sh.template alluxio/conf/alluxio-env.sh && \
  mkdir -p /entrypoints

COPY files/entrypoint.sh /entrypoints

# FIXME: Should not have to do this.
COPY files/alluxio-config.sh /alluxio/libexec
COPY files/alluxio-site.properties /alluxio/conf/alluxio-site.properties

RUN chmod +x alluxio/bin/alluxio-start.sh \
  alluxio/bin/alluxio-stop.sh \
  alluxio/bin/alluxio \
  alluxio/bin/alluxio-workers.sh \
  alluxio/bin/alluxio-mount.sh \
  /entrypoints/entrypoint.sh

EXPOSE 22 19998 19999 29998 29999 30000

# FIXME: Move to /opt
WORKDIR /alluxio

ENTRYPOINT ["/entrypoints/entrypoint.sh"]
