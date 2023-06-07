#!/usr/bin/env bash
set -Eeuo pipefail

SSL_KEY_PATH_TMP='/ssl_cetrts/server.key'
SSL_CRT_PATH_TMP='/ssl_cetrts/server.pem'
FORCE_HTTPS_TMP='yes'
if [ $SSL_KEY_PATH ]; then
    SSL_KEY_PATH_TMP=$SSL_KEY_PATH
fi
if [ $SSL_CRT_PATH ]; then
    SSL_CRT_PATH_TMP=$SSL_CRT_PATH
fi
if [ $FORCE_HTTPS ]; then
    FORCE_HTTPS_TMP=$FORCE_HTTPS
fi
echo "SSL_KEY_PATH_TMP: $SSL_KEY_PATH_TMP"
echo "SSL_CRT_PATH_TMP: $SSL_CRT_PATH_TMP"
echo "FORCE_HTTPS_TMP: $FORCE_HTTPS_TMP"

if [ -f "$SSL_KEY_PATH_TMP" ] && [ -f "$SSL_CRT_PATH_TMP" ]; then
    echo "exsit ssl need files, use https"
    if [ ! -f "/etc/apache2/sites-enabled/default-ssl.conf" ]; then
        echo "cp /etc/apache2/sites-enabled/default-ssl.conf"
        cp -ra /etc/apache2/sites-ssl-conf-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf
        
        if [ "$SSL_CRT_PATH_TMP" != "/ssl_cetrts/server.pem" ]; then
            echo "change default-ssl.conf /ssl_cetrts/server.pem to $SSL_CRT_PATH_TMP"
            sed -i s#/ssl_cetrts/server.pem#$SSL_CRT_PATH_TMP#g /etc/apache2/sites-enabled/default-ssl.conf
        fi

        if [ "$SSL_KEY_PATH_TMP" != "/ssl_cetrts/server.key" ]; then
            echo "change default-ssl.conf /ssl_cetrts/server.key to $SSL_KEY_PATH_TMP"
            sed -i s#/ssl_cetrts/server.key#$SSL_KEY_PATH_TMP#g /etc/apache2/sites-enabled/default-ssl.conf
        fi
    fi
    
    if [ "$FORCE_HTTPS_TMP" == "yes" ]; then
        if [ "`md5sum /etc/apache2/sites-enabled/000-default.conf`" == "`cat /etc/apache2/sites-ssl-conf-available/source-000-default-md5sum`" ]; then
            echo "/etc/apache2/sites-enabled/000-default.conf is default file"
            echo "cp /etc/apache2/sites-enabled/000-default.conf"
            cp -ra /etc/apache2/sites-ssl-conf-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf
        fi
    fi
fi


# a2enmod ssl

docker-entrypoint.sh $1