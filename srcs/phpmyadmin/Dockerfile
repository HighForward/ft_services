FROM alpine:latest

COPY init.sh /init.sh
COPY config.inc.php /www/config.inc.php

RUN apk update && apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session
RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz
RUN rm phpMyAdmin-5.0.2-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.2-all-languages/* /www
RUN chmod -R 777 /www
RUN chmod 600 /www/config.inc.php

ENTRYPOINT sh /init.sh

EXPOSE 5000