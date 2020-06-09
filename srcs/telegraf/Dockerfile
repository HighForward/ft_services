FROM alpine:latest

RUN apk update
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.14.3-static_linux_amd64.tar.gz
RUN tar -C . -xzf telegraf-1.14.3-static_linux_amd64.tar.gz
RUN chmod +x telegraf/*
RUN cp telegraf/telegraf /usr/bin/
RUN rm -rf *.tar.gz* telegraf/

COPY IP_MINIKUBE /tmp/IP_MINIKUBE
COPY init.sh /tmp/init.sh
COPY telegraf.conf /etc/telegraf/telegraf.conf

RUN chmod 777 /tmp/init.sh

ENTRYPOINT sh /tmp/init.sh

EXPOSE 4999