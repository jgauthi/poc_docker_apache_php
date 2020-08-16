FROM orsolin/docker-php-5.3-apache
MAINTAINER Jgauthi <github.com/jgauthi>

VOLUME ["/var/www"]

# Install composer
RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
    mv composer.phar /usr/local/bin/composer

COPY apache_default.conf /etc/apache2/sites-available/default
COPY run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN usermod -u 1000 www-data
RUN a2enmod rewrite

WORKDIR /var/www/html
EXPOSE 80
CMD ["/usr/local/bin/run"]