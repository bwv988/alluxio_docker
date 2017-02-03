# Docker container for Alluxio

## Introduction

This is currently just an experimental image. Learn more about Alluxio @ (<http://www.alluxio.com/>).

## Building the container

Simply run `./build.sh`.

## Usage

### Starting

For a quick test, run:

```bash
docker run --rm \
  --name alluxio \
  -p 19998:19998 \
  -p 19999:19999 \
  -p 29998:29998 \
  -p 29999:29999 \
  -p 30000:30000 bwv988/alluxio
```

### Shell access

Open shell into container:

```bash
docker exec -it alluxio bash
```

### Stopping the container

```bash
docker stop alluxio
```

## TODO

- Lots... :)
