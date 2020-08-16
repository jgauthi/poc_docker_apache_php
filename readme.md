# Docker Apache + PHP
A Docker image based on Ubuntu, serving PHP 5 or 7 running as Apache Module. Useful for Web developers in need for a fixed PHP version. In addition, the `error_reporting` setting in php.ini is configurable per container via environment variable.

## Prerequisite

* [Docker](https://docs.docker.com/get-docker/) v18+

## Installation
You can choose the php version with [tags](https://github.com/jgauthi/poc_docker_apache_php/tags). Then, you can the configuration on "conf section" on file install-image.sh.

```shell script
chmod +x install-image.sh run.sh
./install-image.sh
```

**Installed packages:**
* Ubuntu Server 12, based on ubuntu docker image
* apache2
* php
* php-cli
* libapache2-mod-php
* php-gd
* php-mysql
* composer (php package manager)

**Default Configurations**:

* Apache: .htaccess-Enabled in webroot (mod_rewrite with AllowOverride all)
* php.ini:
  * display_errors = On
  * error_reporting = E_ALL (default, overridable per env variable)


## Usage

```shell script
# Start container
docker start apachephp53

# Stop container
docker stop apachephp53
```

**Access apache logs**: 
Apache is configured to log both access and error log to STDOUT. So you can simply use `docker logs` to get the log output: