FROM alpine:latest

RUN apk update
RUN apk add influxdb

COPY init.sh /init.sh

ENTRYPOINT sh init.sh

EXPOSE 8086