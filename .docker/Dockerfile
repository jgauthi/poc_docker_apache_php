FROM php:7.2-apache
MAINTAINER Jgauthi <github.com/jgauthi>

VOLUME ["/var/www"]

# https://github.com/mlocati/docker-php-extension-installer
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && install-php-extensions \
	gd \
	mysqli pdo pdo_mysql

RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
    mv composer.phar /usr/local/bin/composer

COPY apache_default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
