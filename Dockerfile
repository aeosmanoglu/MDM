FROM php:apache

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install wget git libgd-dev libicu-dev libzip-dev libbz2-dev -y
RUN docker-php-ext-install mysqli gd intl zip sockets bz2 exif opcache

RUN wget https://github.com/glpi-project/glpi/releases/download/10.0.3/glpi-10.0.3.tgz -P /var/www/html
RUN tar -xvzf /var/www/html/glpi-10.0.3.tgz
RUN rm -rf /var/www/html/glpi-10.0.3.tgz

RUN chmod -R 777 /var/www/html/glpi/files/
RUN chmod -R 777 /var/www/html/glpi/config/
RUN chmod -R 777 /var/www/html/glpi//marketplace/

RUN wget https://github.com/fusioninventory/fusioninventory-for-glpi/releases/download/glpi10.0.1%2B1.0/fusioninventory-10.0.1+1.0.tar.bz2 -P /var/www/html/glpi/plugins
RUN tar -xvjf /var/www/html/glpi/plugins/fusioninventory-10.0.1+1.0.tar.bz2
RUN rm -rf /var/www/html/glpi/plugins/fusioninventory-10.0.1+1.0.tar.bz2

RUN wget https://github.com/flyve-mdm/glpi-plugin/releases/download/v2.0.0/glpi-flyvemdm-2.0.0.tar.bz2 -P /var/www/html/glpi/plugins
RUN tar -xvjf /var/www/html/glpi/plugins/glpi-flyvemdm-2.0.0.tar.bz2 
RUN rm -rf /var/www/html/glpi/plugins/glpi-flyvemdm-2.0.0.tar.bz2
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
COPY ./composer.json /var/www/html/glpi/plugins/flyvemdm/
RUN composer install -d /var/www/html/glpi/plugins/flyvemdm/ --no-dev
