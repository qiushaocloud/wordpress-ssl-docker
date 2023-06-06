FROM wordpress:latest

LABEL Author="qiushaocloud"
LABEL Email="qiushaocloud@126.com"
LABEL Site="www.qiushaocloud.com"


COPY ./ssl-conf /etc/apache2/sites-ssl-conf-available
COPY ./docker-entrypoint-ex.sh /usr/local/bin/docker-entrypoint-ex.sh

RUN chmod +x /usr/local/bin/docker-entrypoint-ex.sh \
    && mkdir -p /ssl \
    && md5sum /etc/apache2/sites-enabled/000-default.conf >/etc/apache2/sites-ssl-conf-available/source-000-default-md5sum
RUN a2enmod ssl

ENTRYPOINT ["docker-entrypoint-ex.sh", '[apache2-foreground]']