# Use multi stage build to# minimize generated docker images size
# see: https://docs.docker.com/develop/develop-images/multistage-build/

# Step 1: create multi stage builder (about 800 MB)
FROM golang:1.13 AS builder
LABEL stage=intermediate
RUN go version

COPY app.go Gopkg.toml /go/src/larmic/
WORKDIR /go/src/larmic/
RUN set -x && \
    go get github.com/golang/dep/cmd/dep && \
    dep ensure -v

# CGO_ENABLED=0   -> Disable interoperate with C libraries -> speed up build time! Enable it, if dependencies use C libraries!
# GOOS=linux      -> compile to linux because scratch docker file is linux
# GOARCH=amd64    -> because, hmm, everthing works fine with 64 bit :)
# -a              -> force rebuilding of packages that are already up-to-date.
# -o app          -> force to build an executable app file (instead of default https://golang.org/cmd/go/#hdr-Compile_packages_and_dependencies)
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o app .


# Step 2: create minimal executable image (less than 10 MB)
FROM scratch
WORKDIR /root/
COPY --from=builder /go/src/larmic/app .
COPY response.json .

EXPOSE 8080
ENTRYPOINT ["./app"]
