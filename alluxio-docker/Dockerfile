# Docker file for Alluxio.
# RS01042016
#
# Build command:
#
# sudo docker build -t bwv988/alluxio .
#
# Run command:
#
# sudo docker run -p 127.0.0.1:19999:19999 -p 127.0.0.1:19998:19998 -p 127.0.0.1:29999:29999 -p 127.0.0.1:29998:29998 --rm bwv988/alluxio


FROM bwv988/java7
MAINTAINER Ralph Schlosser, https://github.com/bwv988

# Set up password-less login for SSH.
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh && \
    ssh-keygen -A

RUN rm -f /root/.ssh/id_rsa && \
    ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N "" && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod og-wx ~/.ssh/authorized_keys

# Download and extract Alluxio.
RUN mkdir -p /alluxio && \
    curl -SL http://alluxio.org/downloads/files/1.0.1/alluxio-1.0.1-bin.tar.gz \
    | tar -xvz -C /alluxio --strip-components=1


# Using default config for now.
# FIXME: Should really have 2 separate containers for Master & Workers so as to allow for scaling.
RUN cp alluxio/conf/alluxio-env.sh.template alluxio/conf/alluxio-env.sh

COPY entrypoint.sh /root

RUN chmod +x alluxio/bin/alluxio-start.sh alluxio/bin/alluxio-stop.sh alluxio/bin/alluxio alluxio/bin/alluxio-workers.sh alluxio/bin/alluxio-mount.sh /root/entrypoint.sh

EXPOSE 22 19998 19999 29998 29999 30000

ENTRYPOINT ["/root/entrypoint.sh"]
