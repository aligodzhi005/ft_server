#!/bin/bash
if grep -q "autoindex on" /etc/nginx/sites-available/my_config.conf
then
    sed -i "s/autoindex on;/autoindex off;/" /etc/nginx/sites-available/my_config.conf
    echo "Autoindex off"
else
    sed -i "s/autoindex off;/autoindex on;/" /etc/nginx/sites-available/my_config.conf
    echo "Autoindex on"
fi
nginx -s reload

