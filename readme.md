# Docker Apache + PHP
A Docker image based on Ubuntu, serving PHP 5 or 7 running as Apache Module. Useful for Web developers in need for a fixed PHP version. In addition, the `error_reporting` setting in php.ini is configurable per container via environment variable.

## Prerequisite

* [Docker](https://docs.docker.com/get-docker/) v18+

## Installation
You can choose the php version with [tags](https://github.com/jgauthi/poc_docker_apache_php/tags). Then, you can the configuration on "conf section" on file install-image.sh.

```shell script
chmod +x install-image.sh
./install-image.sh
```

Get the current docker IP with the command: 
```shell script
docker inspect apachephp74 | grep '"IPAddress": "'
```

And edit your /etc/hosts: `172.17.X.X php74.local`

**Installed packages:**
* Ubuntu Server 12, based on ubuntu docker image
* apache2
* php
* php-cli
* libapache2-mod-php
* php-curl
* php-ftp
* php-gd
* php-mbstring
* php-mysql, php-myqsli
* php-soap
* php-zlib
* composer (php package manager)


**Default Configurations**:

* Apache: .htaccess-Enabled in webroot (mod_rewrite with AllowOverride all)
* php.ini:
  * display_errors = On
  * error_reporting = E_ALL (default, overridable per env variable)

For uninstall, you can use the command: `docker rm apachephp74`


## Usage

```shell script
# Start container
docker start apachephp74

# Use composer
docker exec -it apachephp74 composer install

# Stop container
docker stop apachephp74
```

You can check on url: http://php74.local

**Access apache logs**: 
Apache is configured to log both access and error log to STDOUT. So you can simply use `docker logs` to get the log output:
