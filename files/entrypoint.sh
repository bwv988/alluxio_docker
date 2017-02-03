#!/bin/bash
# Main entrypoint.
# RS01042016

mkdir /var/run/sshd
chmod 0755 /var/run/sshd
/alluxio/bin/alluxio-start.sh local -f &
/usr/sbin/sshd -D
