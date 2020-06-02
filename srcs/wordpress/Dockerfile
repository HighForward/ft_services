FROM alpine:latest

RUN apk get update
RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

COPY wordpress.tar.gz /wordpress.tar.gz
COPY init.sh /init.sh

ENTRYPOINT sh /init.sh

EXPOSE 5050

