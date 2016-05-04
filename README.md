# Dockerizing Alluxio


## Introduction

This is currently some work in progress to provide a set of docker containers for Alluxio (http://www.alluxio.com/).


## Usage

First run `./build.sh` to build the container images. Start Alluxio via:

    sudo docker run -p 127.0.0.1:19999:19999 -p 127.0.0.1:19998:19998 -p 127.0.0.1:29999:29999 -p 127.0.0.1:29998:29998 --rm bwv988/alluxio


## TODO

* Fix file write issue.
* Have separate containers for master and worker.
* Convert project to Docker Compose.
* Support for existing external volumes.
* Expose Alluxio config settings through environment variables.
