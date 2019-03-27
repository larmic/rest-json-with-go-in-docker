# Use multi stage build to# minimize generated docker images size
# see: https://docs.docker.com/develop/develop-images/multistage-build/

# Step 1: create multi stage builder (about 800 MB)
FROM golang:1.12 AS builder
LABEL stage=intermediate
RUN go version

COPY app.go Gopkg.toml /go/src/larmic/
WORKDIR /go/src/larmic/
RUN set -x && \
    go get github.com/golang/dep/cmd/dep && \
    dep ensure -v

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o app .


# Step 2: create minimal executable image (less than 10 MB)
FROM scratch
WORKDIR /root/
COPY --from=builder /go/src/larmic/app .
COPY response.json .

EXPOSE 8080
ENTRYPOINT ["./app"]