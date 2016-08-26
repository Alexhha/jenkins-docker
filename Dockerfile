FROM alpine

# Set the author
MAINTAINER Alex Domoradov <alex.hha@gmail.com>

ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 TERM=xterm

RUN apk update \
    && apk add curl openssh openssh-client bash \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apk/* /var/cache/apk/*

RUN mkdir /var/run/sshd \
    && echo 'root:1234567' | chpasswd \
    && sed -i 's/PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config \
    &&  /usr/bin/ssh-keygen -A \
    && touch /var/log/btmp && chown root:utmp /var/log/btmp && chmod 660 /var/log/btmp \
    && adduser -D test -s /bin/bash && echo 'test:1234567' | chpasswd

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
