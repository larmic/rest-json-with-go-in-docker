# JSON static rest example with Go and Docker

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

An example project to create a Docker image for a Go application containing a static REST service.

## Requirements

* Docker 

## Build and run

```sh 
# build docker image (result is a < 8MB docker image)
$ ./build_image.sh

# run image
$ docker run -d -p 8080:8080 --rm --name channel-mock larmic/channel-mock

# access rest api
curl http://localhost:8080/api/channels

# stop image
docker stop channel-mock
```