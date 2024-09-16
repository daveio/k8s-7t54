# syntax=docker/dockerfile:1.10

FROM golang:1.23.1-alpine3.20 AS builder
ADD https://github.com/0xERR0R/blocky.git#v0.24 /src/
RUN apk add --no-cache --update git
WORKDIR /src/
RUN go build -o /blocky .

FROM alpine:3.20.3
COPY --from=builder /blocky /blocky
RUN touch /config.yml
WORKDIR /
VOLUME ["/config.yml"]
EXPOSE 53/tcp
EXPOSE 53/udp
ENTRYPOINT ["/blocky", "--config", "/config.yml"]
