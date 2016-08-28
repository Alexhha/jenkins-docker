FROM alpine

# Set the author
MAINTAINER Alex Domoradov <alex.hha@gmail.com>

ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 TERM=xterm

RUN apk update \
    && apk add curl bash apache2 \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apk/* /var/cache/apk/* \
    && mkdir -p /vhosts/default /run/apache2 \
    && chown root:apache /run/apache2 && chmod 710 /run/apache2 \
    && sed -i 's/Listen 80/Listen 8888/' /etc/apache2/httpd.conf \
    && echo "PidFile run/httpd.pid" >> /etc/apache2/httpd.conf

COPY vhosts/* /var/www/localhost/htdocs/

ENTRYPOINT ["/usr/sbin/httpd", "-DFOREGROUND"]
