From debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget \
                        vim \
                        nginx \
			mariadb-server \
			php7.3 \
                        php-mysql \
                        php-fpm \
                        php-pdo \
                        php-gd \
                        php-cli \
                        php-mbstring

#Меняем файл default
WORKDIR /etc/nginx/sites-enabled/

RUN rm default
COPY ./srcs/my_config.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/my_config.conf /etc/nginx/sites-enabled/

RUN openssl req -x509 -nodes -days 365 -subj "/C=KR/ST=Korea/L=Seoul/O=innoaca/OU=42seoul/CN=forhjy" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt

WORKDIR /var/www/html/

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
RUN rm phpmyadmin/config.sample.inc.php
COPY ./srcs/config.inc.php phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
RUN rm -rf wordpress/wp-config-sample.php
COPY ./srcs/wp-config.php wordpress

COPY ./srcs/init.sh /
COPY ./srcs/autoindex.sh /

CMD bash /init.sh