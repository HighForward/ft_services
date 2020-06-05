FROM alpine:latest

COPY init.sh /init.sh

RUN apk update
RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat
RUN wget https://dl.grafana.com/oss/release/grafana-7.0.0.linux-amd64.tar.gz
RUN tar xfz grafana-7.0.0.linux-amd64.tar.gz
RUN rm grafana-7.0.0.linux-amd64.tar.gz
RUN chmod 755 init.sh

ENTRYPOINT /init.sh

EXPOSE 3000