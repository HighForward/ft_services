FROM alpine:latest

COPY init.sh /init.sh
COPY pure-ftpd.pem /pure-ftpd.pem
COPY IP_MINIKUBE /IP_MINIKUBE

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
RUN apk update
RUN apk add pure-ftpd
RUN apk add openssl
RUN mkdir -p /etc/ssl/private
RUN mv /pure-ftpd.pem /etc/ssl/private
RUN chmod 600 /etc/ssl/private/pure-ftpd.pem

ENTRYPOINT sh /init.sh

EXPOSE 21