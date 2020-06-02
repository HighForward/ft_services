FROM alpine:latest

RUN apk update && apk add nginx openssh ca-certificates
RUN adduser -D -g 'user' user
RUN chown -R user:user /var/lib/nginx
RUN rm -f /etc/nginx/nginx.conf
RUN mkdir -p /var/run/nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY sshd_config /etc/ssh/sshd_config
COPY rsa_key.private /etc/ssh/ssh_host_rsa_key
COPY mycert.crt /usr/local/share/ca-certificates/mycert.crt
COPY init.sh /init.sh

ENTRYPOINT sh /init.sh

EXPOSE 80 443 30001