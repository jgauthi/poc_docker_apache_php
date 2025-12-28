# POC Project Apache/PHP with docker
Provide an dev environnement for Apache and php with a specific version. 


## Prerequisites

* Docker v28+ & Docker compose v2.4+
* `Make` command. On linux, install with `sudo apt install build-essential`. On Windows, [see here](https://stackoverflow.com/questions/32127524/how-to-install-and-use-make-in-windows/54086635).
* These ports must be available for docker: `8000, 9003` _(you can change it on `.docker/apachephp/app.yml` or create a `docker-compose.override.yml` file after install)_.


## Installation
Put your project files on **demo** folder _(you can rename if you edit docker/*/.yml files)_, or you can your folder as a git repository instead. You can edit [.env](./.env) files on `COMPOSE_FILE` variable for add additionals docker compose config files (splitted by a comma `,`).

Exemple:
```env
COMPOSE_FILE=.docker/apachephp/app.yml,.docker/database/mysql.yml,.docker/database/phpmyadmin.yml

# [Optional] You can set php version, recommanded: 7.4, 8.4+
APP_PORT=APP_PORT
PHP_VERSION=8.4

# [Optional] php5 support, recommanded: 5.6
PHP_VERSION=5.6
XDEBUG_CONFIG_FILE=98-xdebug-php5.ini

#...
```

Once prepare, use command lines:

```bash
make install
```

The `Makefile` can be completed: if you use a Symfony Project --> uncomment some lines.


## Usage
Use docker for execute the built-in web server and access the application in your browser at <http://localhost:8000>:

```bash
make up

# For stop services
make stop

# Help: List command
make
```

Enjoy!