#!/bin/bash
set -e

phpversion=5

PHP_ERROR_REPORTING=${PHP_ERROR_REPORTING:-"E_ALL"}
sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php$phpversion/apache2/php.ini
sed -ri "s/^error_reporting\s*=.*$//g" /etc/php$phpversion/apache2/php.ini
echo "error_reporting = $PHP_ERROR_REPORTING" >> /etc/php$phpversion/apache2/php.ini

source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND