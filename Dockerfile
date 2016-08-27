FROM alpine

# Set the author
MAINTAINER Alex Domoradov <alex.hha@gmail.com>

ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 TERM=xterm

RUN apk update \
    && apk add curl bash apache2 \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apk/* /var/cache/apk/*

RUN mkdir /vhosts/default \
    && sed -i 's/Listen 80/Listen 8888/' /etc/apache2/httpd.conf

ENTRYPOINT ["/usr/sbin/httpd", "-DFOREGROUND"]
