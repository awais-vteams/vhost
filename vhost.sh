#!/usr/bin/env bash

# Usage
# vhost.sh name.com www/path

NAME=$1;
PATHDIR=$2;
CONF="${NAME}.conf"

echo '--- Creating vHost ---'

cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/${CONF}

VHOST=$(cat <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost	
    ServerName ${NAME}
    DocumentRoot ${PATHDIR}
    ServerAlias www.${NAME}

    ErrorLog /var/log/apache2/${NAME}-error_log
    CustomLog /var/log/apache2/${NAME}-access_log combined
</VirtualHost>
EOF
)

echo "${VHOST}" > /etc/apache2/sites-available/${CONF}

a2ensite ${CONF}

service apache2 restart

echo "127.0.0.1		${NAME}" >> /etc/hosts

echo "created vHost http://${NAME}"
