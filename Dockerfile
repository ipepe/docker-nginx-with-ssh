FROM ubuntu:18.04
MAINTAINER docker@ipepe.pl

RUN apt-get update && apt-get install -qq -y locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    echo 'LANGUAGE="en_US:en"' >> /etc/default/locale

RUN apt-get update && apt-get install -qq -y nginx openssh-server nano vim rsync

RUN rm /etc/nginx/sites-available/* /etc/nginx/sites-enabled/*
COPY default_webapp.conf /etc/nginx/sites-available/default.conf
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

# create webapp user
RUN groupadd -g 1000 webapp && \
    useradd -m -s /bin/bash -g webapp -u 1000 webapp && \
    echo "webapp:Password1" | chpasswd

COPY docker-entrypoint.sh /root/docker-entrypoint.sh
CMD ["/root/docker-entrypoint.sh"]