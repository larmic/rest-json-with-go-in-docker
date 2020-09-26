# Go parameters

# CGO_ENABLED=0   -> Disable interoperate with C libraries -> speed up build time! Enable it, if dependencies use C libraries!
# GOOS=linux      -> compile to linux because scratch docker file is linux
# GOARCH=amd64    -> because, hmm, everthing works fine with 64 bit :)
# -a              -> force rebuilding of packages that are already up-to-date.
# -o my-test-x    -> force to build an executable my-test-x file (instead of default https://golang.org/cmd/go/#hdr-Compile_packages_and_dependencies)

BINARY_NAME=rest-json-with-go-in-docker-example
IMAGE_NAME=larmic/rest-json-with-go-in-docker-example
IMAGE_TAG=latest
CONTAINER_NAME=larmic-rest-mock

build: clean
	echo "Build go app"
	go build -a -o build/$(BINARY_NAME)
	echo "Copy response.json"
	cp response.json build

run:
	mkdir -p build
	cd build; ./$(BINARY_NAME)

docker-all: clean docker-build docker-push

docker-build: clean
	echo "Remove docker image if already exists"
	docker rmi -f ${IMAGE_NAME}:${IMAGE_TAG}
	echo "Build go docker image"
	DOCKER_BUILDKIT=1 docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
	echo "Prune intermediate images"
	docker image prune --filter label=stage=intermediate -f

docker-push:
	docker push ${IMAGE_NAME}:${IMAGE_TAG}

docker-run:
	docker run -d -p 8080:8080 --rm --name --rm --name ${CONTAINER_NAME} ${IMAGE_NAME}

docker-stop:
	docker stop ${CONTAINER_NAME}

clean:
	echo "Clean build folder"
	go clean
	rm -rf build