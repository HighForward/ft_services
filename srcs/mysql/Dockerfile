FROM alpine:latest

COPY init.sh /init.sh
COPY db.sh /db.sh

RUN apk update
RUN apk add mariadb mariadb-client

ENTRYPOINT sh /init.sh

EXPOSE 3306