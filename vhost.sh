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

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
)

echo "${VHOST}" > /etc/apache2/sites-available/${CONF}

a2ensite ${CONF}

service apache2 restart

echo "127.0.0.1		${NAME}" >> /etc/hosts

echo "created vHost http://${NAME}"
