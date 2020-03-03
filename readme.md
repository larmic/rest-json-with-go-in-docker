# JSON static rest example with Go and Docker

[![Build Status](https://travis-ci.org/larmic/rest-json-with-go-in-docker.svg?branch=master)](https://travis-ci.org/larmic/rest-json-with-go-in-docker)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

An example project to create a Docker image for a Go application containing a static REST service.

## Requirements

* Docker 
* Go 1.14.x (if you want to build it without using docker builder)

## Build it

```sh 
$ make build            # build native app to ./build folder

$ make docker-build     # build local docker image
$ make docker-push      # push local docker image to hub.docker.com
$ make docker-all       # build and push docker image to hub.docker.com

$ make clean            # clean up go and build folder
```

# Run it native

```sh 
$ make run                                  # start native app 
$ curl http://localhost:8080/api/channels   # call rest service
$ ctrl+c                                    # stop native app
```

# Run it using docker

```sh 
$ make docker-run                           # start docker image 
$ curl http://localhost:8080/api/channels   # call rest service
$ make docker-stop                          # stop and remove docker app
```