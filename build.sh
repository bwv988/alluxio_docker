#!/bin/bash
# Quick build script for docker containers.

sudo docker build -t bwv988/java7 java7-base-docker/

sudo docker build -t bwv988/alluxio alluxio-docker
